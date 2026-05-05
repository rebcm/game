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
t('materialOpaco com toneMapped: true (Cineon comprime overbright)',
  /materialOpaco\s*=[\s\S]*?toneMapped:\s*true/.test(game),
  'toneMapped:false faz o material ignorar o tonemap e clipar pra branco — top faces parecem "translúcidas".');

// ---------------------------------------------------------------------
// materialTransp inicia idêntico ao opaco no modo "sólido" (default).
// Antes: side: DoubleSide ficava ligado mesmo com transparência off,
// expondo back-faces de leaves/vidro — parecia "ver através do bloco".
// ---------------------------------------------------------------------
grupo('materialTransp arranque sólido');
t('materialTransp inicia com transparent: false',
  /materialTransp\s*=[\s\S]*?transparent:\s*false/.test(game));
t('materialTransp inicia com side: FrontSide (não DoubleSide)',
  /materialTransp\s*=[\s\S]*?side:\s*THREE\.FrontSide/.test(game),
  'DoubleSide com transparência off vaza back-faces — leitura de "transparência" pelo usuário.');
t('setTransparenciaAtiva alterna side junto com transparent',
  /setTransparenciaAtiva[\s\S]*?side\s*=\s*THREE\.DoubleSide[\s\S]*?side\s*=\s*THREE\.FrontSide/.test(game),
  'Toggle precisa flippar side também — senão o modo "sólido" continua com DoubleSide herdado.');

// ---------------------------------------------------------------------
// Atlas opaco
// ---------------------------------------------------------------------
grupo('Atlas de texturas 100% opaco');
t('canvas do atlas é forçado a alpha=255 antes de virar textura',
  /dataAll\.data\[i\]\s*=\s*255/.test(game),
  'Sem isso, padrões com strokeStyle rgba(...,0.5) vazam alpha < 255.');

// ---------------------------------------------------------------------
// Tone mapping Cineon (suave, comprime overbright sem matar escuros)
// Antes era NoToneMapping pra evitar caverna preta, mas isso fazia
// faces top em pleno sol clipar pra branco e parecer "translúcidas".
// Cineon é mais suave que ACESFilmic — o piso de luz vem do
// emissiveMap + ambient/hemi reduzidos.
// ---------------------------------------------------------------------
grupo('Tone mapping');
t('renderer com CineonToneMapping (rolloff suave)',
  /toneMapping\s*=\s*THREE\.CineonToneMapping/.test(game));
t('toneMappingExposure entre 0.9 e 1.2 (compensa Cineon sem estourar)', (() => {
  const m = game.match(/toneMappingExposure\s*=\s*(\d+\.?\d*)/);
  if (!m) return false;
  const v = parseFloat(m[1]);
  return v >= 0.9 && v <= 1.2;
}));

// ---------------------------------------------------------------------
// Iluminação mínima (regressão: cavernas ficavam pretas)
// ---------------------------------------------------------------------
grupo('Iluminação mínima');
t('emissiveMap aplicado nos materiais (piso de luz própria)',
  /emissiveMap:\s*this\.atlas\.texture/.test(game));
t('emissiveIntensity entre 0.15 e 0.30 (não overbright nem preto)', (() => {
  const matches = game.match(/emissiveIntensity:\s*(0\.\d+)/g);
  if (!matches) return false;
  return matches.every(m => {
    const v = parseFloat(m.match(/0\.\d+/)[0]);
    return v >= 0.15 && v <= 0.30;
  });
}), 'Abaixo de 0.15 = preto em cavernas; acima de 0.30 = blocos fundem visualmente.');
t('hemi (>= 0.30 noite) + ambient (>= 0.18 noite) carregam piso de luz', (() => {
  const m1 = game.match(/this\.hemi\.intensity\s*=\s*(0\.\d+)/);
  const m2 = game.match(/this\.ambient\.intensity\s*=\s*(0\.\d+)/);
  return m1 && m2 && parseFloat(m1[1]) >= 0.30 && parseFloat(m2[1]) >= 0.18;
}), 'Valores reduzidos vs antes (eram 0.55/0.40) pq agora o Cineon comprime picos suavemente.');
t('soma de luzes em pleno dia <= 1.7 (evita clipping)', (() => {
  // ambient_dia + hemi_dia + sol_dia <= 1.7 garante que com tone
  // mapping Cineon (rolloff suave acima de ~0.8) os top faces fiquem
  // próximos de 1.0 sem virar branco puro.
  const m1 = game.match(/this\.hemi\.intensity\s*=\s*(0\.\d+)\s*\+\s*(0\.\d+)/);
  const m2 = game.match(/this\.ambient\.intensity\s*=\s*(0\.\d+)\s*\+\s*(0\.\d+)/);
  const m3 = game.match(/this\.sol\.intensity\s*=\s*(0\.\d+)\s*\+\s*(0\.\d+)/);
  if (!m1 || !m2 || !m3) return false;
  const dia = parseFloat(m1[1]) + parseFloat(m1[2])
            + parseFloat(m2[1]) + parseFloat(m2[2])
            + parseFloat(m3[1]) + parseFloat(m3[2]);
  return dia <= 1.7;
}), 'Antes (0.75 + 1.05 + 1.00 = 2.80) clipava top faces pra branco.');
t('PointLight intensity da lava/tocha reduzida (<= 1.0)', (() => {
  const m = game.match(/l\.intensity\s*=\s*c\.nivel\s*\/\s*15\s*\*\s*(\d+\.?\d*)/);
  return m && parseFloat(m[1]) <= 1.0;
}), 'Intensity > 1.0 satura blocos próximos da lava → parecem transparentes.');
t('SHADE.bottom entre 0.65 e 0.95 (contraste sem virar preto)',
  (() => {
    const m = game.match(/bottom:\s*(0\.\d+)/);
    if (!m) return false;
    const v = parseFloat(m[1]);
    return v >= 0.65 && v <= 0.95;
  })(), 'Muito alto = sem volume; muito baixo = preto absoluto.');

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
