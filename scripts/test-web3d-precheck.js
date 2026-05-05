// Testes de pré-deploy do web3d.
//
// Validações estáticas que NÃO precisam de Three.js carregado — checa
// invariantes do game.js que, quando violadas, causaram bugs visuais
// reportados pelo usuário (transparência fantasma, blocos pretos).
//
// Como rodar: node scripts/test-web3d-precheck.js [diretorio]
// Default diretorio = ./web3d
//
// Saída: exit code 0 se todos passaram; 1 se algum falhou. Mensagens
// claras descrevem cada teste.
//
// Adicione testes novos sempre que um bug visual reincidente for
// corrigido — esse arquivo é a salvaguarda contra regressões.

const fs = require('fs');
const path = require('path');

const dir = process.argv[2] || path.join(__dirname, '..', 'web3d');
let falhas = 0;
let passados = 0;

function t(nome, condicao, detalhe) {
  if (condicao) {
    passados++;
    console.log(`  ✓ ${nome}`);
  } else {
    falhas++;
    console.log(`  ✗ ${nome}${detalhe ? '\n      ' + detalhe : ''}`);
  }
}
function grupo(nome) { console.log(`\n▌ ${nome}`); }

// ---------------------------------------------------------------------
// Carrega arquivos
// ---------------------------------------------------------------------
function read(p) { return fs.readFileSync(path.join(dir, p), 'utf8'); }
const game = read('game.js');
const html = read('index.html');
const css = read('style.css');

// ---------------------------------------------------------------------
// Sanidade básica
// ---------------------------------------------------------------------
grupo('Estrutura de arquivos');
t('game.js existe e é não-vazio', game.length > 1000);
t('index.html existe', html.length > 100);
t('style.css existe', css.length > 100);

// ---------------------------------------------------------------------
// Cache busting
// ---------------------------------------------------------------------
grupo('Cache busting');
t('index.html usa import() com versão',
  /import\(`\.\/game\.js\?v=\$\{BUILD_VERSION\}`\)/.test(html));
t('placeholder __BUILD_VERSION__ presente para substituição em build',
  /__BUILD_VERSION__/.test(html) || /BUILD_VERSION\s*=\s*'\d/.test(html));
t('arquivo _headers existe (Cloudflare Pages cache control)',
  fs.existsSync(path.join(dir, '_headers')));

// ---------------------------------------------------------------------
// Materiais opacos: transparent=false explícito + alphaTest:0
// (regressão histórica: blocos pareciam transparentes vistos de cima)
// ---------------------------------------------------------------------
grupo('Materiais opacos não-translúcidos');
t('materialOpaco com transparent: false',
  /materialOpaco\s*=[\s\S]*?transparent:\s*false/.test(game),
  'Sem isso, alpha residual no atlas vaza em pixels semi-transparentes.');
t('materialOpaco com alphaTest: 0 (não cull pixels translúcidos)',
  /materialOpaco\s*=[\s\S]*?alphaTest:\s*0/.test(game));
t('materialOpaco com depthWrite: true',
  /materialOpaco\s*=[\s\S]*?depthWrite:\s*true/.test(game));
t('materialOpaco com toneMapped: false (defesa contra ACES)',
  /materialOpaco\s*=[\s\S]*?toneMapped:\s*false/.test(game));

// ---------------------------------------------------------------------
// Atlas opaco
// ---------------------------------------------------------------------
grupo('Atlas de texturas 100% opaco');
t('canvas do atlas é forçado a alpha=255 antes de virar textura',
  /dataAll\.data\[i\]\s*=\s*255/.test(game),
  'Sem isso, padrões com strokeStyle rgba(...,0.5) vazam alpha < 255.');

// ---------------------------------------------------------------------
// Tone mapping desligado (regressão: ACES Filmic crushava escuros)
// ---------------------------------------------------------------------
grupo('Tone mapping');
t('renderer com NoToneMapping (cores diretas, evita preto absoluto)',
  /toneMapping\s*=\s*THREE\.NoToneMapping/.test(game));

// ---------------------------------------------------------------------
// Iluminação mínima (regressão: cavernas ficavam pretas)
// ---------------------------------------------------------------------
grupo('Iluminação mínima');
t('emissiveMap aplicado nos materiais (piso de luz própria)',
  /emissiveMap:\s*this\.atlas\.texture/.test(game));
t('emissiveIntensity >= 0.7',
  /emissiveIntensity:\s*0\.[7-9]/.test(game),
  'Abaixo de 0.7 não cobre cavernas profundas.');
t('SHADE.bottom >= 0.85 (face inferior não fica preta)',
  (() => {
    const m = game.match(/bottom:\s*(0\.\d+)/);
    return m && parseFloat(m[1]) >= 0.85;
  })());

// ---------------------------------------------------------------------
// Cor de céu: c1 (noite) não pode estar perto do preto
// ---------------------------------------------------------------------
grupo('Céu noturno legível');
t('c1 (cor noturna) tem RGB médio > 60 (não-preto)', (() => {
  const m = game.match(/new THREE\.Color\(0x([0-9a-fA-F]{6})\)[^\n]*\/\/ noite|const c1 = new THREE\.Color\(0x([0-9a-fA-F]{6})\)/);
  // procura mais defensivo
  const m2 = game.match(/Cor do c[éé]u[\s\S]*?const c1 = new THREE\.Color\(0x([0-9a-fA-F]{6})\)/);
  const hex = (m2 && m2[1]) || (m && (m[1] || m[2]));
  if (!hex) return false;
  const v = parseInt(hex, 16);
  const r = (v >> 16) & 0xFF, g = (v >> 8) & 0xFF, b = v & 0xFF;
  const med = (r + g + b) / 3;
  return med > 60;
}), 'Antes era 0x0B1430 (RGB med 26) — quase preto.');

// ---------------------------------------------------------------------
// Obsidiana visualmente distinta (não confundir com céu noturno)
// ---------------------------------------------------------------------
grupo('Obsidiana distinta do céu');
t('cor da obsidiana tem brilho médio > 40 (visível mesmo em sombra)', (() => {
  const m = game.match(/\[BLOCO\.OBSIDIANA\][\s\S]*?cor:\s*0x([0-9a-fA-F]{6})/);
  if (!m) return false;
  const v = parseInt(m[1], 16);
  const r = (v >> 16) & 0xFF, g = (v >> 8) & 0xFF, b = v & 0xFF;
  return (r + g + b) / 3 > 40;
}), 'Antes 0x1A1A2E (RGB med 26) parecia idêntica ao céu noturno.');

// ---------------------------------------------------------------------
// Cavernas não muito densas
// ---------------------------------------------------------------------
grupo('Cavernas: thresholds moderados');
t('threshold raso < 0.20 (poucos buracos perto da superfície)', (() => {
  const m = game.match(/y < 12 \?\s*(0\.\d+)/);
  return m && parseFloat(m[1]) < 0.20;
}));
t('threshold superficial < 0.15 (quase nenhum buraco perto do topo)', (() => {
  const m = game.match(/y < 12 \? [^:]+:\s*(0\.\d+)\)/);
  return m && parseFloat(m[1]) < 0.15;
}));

// ---------------------------------------------------------------------
// Default sólido (não transparente)
// ---------------------------------------------------------------------
grupo('Default visual: modo sólido');
t('Renderer init com transparenciaAtiva = false', (() => {
  // Procura pelo bloco onde inicializa transparenciaAtiva
  return /this\.transparenciaAtiva\s*=\s*false/.test(game);
}));
t('botão btn-transp inicia com classe solido', (() => {
  return /id="btn-transp"\s+class="hud-btn solido"/.test(html);
}));

// ---------------------------------------------------------------------
// Pointer lock re-mapeia ao clicar
// ---------------------------------------------------------------------
grupo('Pointer lock: re-mapear no clique após Esc');
t('mousedown handler tem re-lock automático', (() => {
  return /controls\.lock\(\)/.test(game) &&
         /controls\.isLocked/.test(game) &&
         /algumPainelAberto/.test(game);
}));

// ---------------------------------------------------------------------
// Tela de morte: pointer livre + clique respawna
// ---------------------------------------------------------------------
grupo('Tela de morte');
t('mostrarMorte chama exitPointerLock', (() => {
  return /mostrarMorte\(\)\s*\{[\s\S]*?exitPointerLock/.test(game);
}));
t('respawn handler responde a pointerdown / click / touchend', (() => {
  return /pointerdown[\s\S]*?respawnHandler/.test(game) &&
         /touchend[\s\S]*?respawnHandler/.test(game);
}));

// ---------------------------------------------------------------------
// Touch controls
// ---------------------------------------------------------------------
grupo('Touch controls');
t('detecta touch device', /isTouchDevice\s*=/.test(game));
t('joystick virtual', /touch-joy/.test(html));
t('look-zone separado', /touch-look/.test(html));
t('botões touch (jump, break, place, attack)',
  /data-action="jump"/.test(html) &&
  /data-action="break"/.test(html) &&
  /data-action="place"/.test(html) &&
  /data-action="attack"/.test(html));

// ---------------------------------------------------------------------
// Áudio mobile fix
// ---------------------------------------------------------------------
grupo('Áudio mobile (iOS Safari)');
t('listener global desbloqueia AudioContext em touchstart',
  /touchstart[\s\S]*?desbloquear|desbloquear[\s\S]*?touchstart/.test(html));
t('window.rebcm.desbloquearAudio exposto',
  /rebcm\.desbloquearAudio/.test(html));

// ---------------------------------------------------------------------
// Resumo
// ---------------------------------------------------------------------
console.log(`\n────────────────────────────────────────`);
console.log(`✓ ${passados} passaram   ✗ ${falhas} falharam`);
if (falhas > 0) {
  console.log(`\n❌ FALHA — não publique este build até corrigir.`);
  process.exit(1);
} else {
  console.log(`\n✅ Tudo OK — build pronto para deploy.`);
  process.exit(0);
}
