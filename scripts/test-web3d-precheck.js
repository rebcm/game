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
// materialTransp arranca sólido no construtor (transparent:false /
// FrontSide). setTransparenciaAtiva(true) ativa transparency real
// (transparent + opacity 0.78 + DoubleSide) — Minecraft-style.
// ---------------------------------------------------------------------
grupo('materialTransp arranque + toggle real');
t('materialTransp criado com transparent: false (estado base)',
  /materialTransp\s*=[\s\S]*?transparent:\s*false/.test(game));
t('materialTransp criado com side: FrontSide (estado base)',
  /materialTransp\s*=[\s\S]*?side:\s*THREE\.FrontSide/.test(game),
  'O construtor cria sólido; setTransparenciaAtiva(true) liga transparência ao final.');
t('setTransparenciaAtiva ativa: transparent=true, opacity ~0.78, DoubleSide',
  /setTransparenciaAtiva\([^)]*\)\s*\{[\s\S]*?this\.transparenciaAtiva\s*=\s*ativa[\s\S]*?if\s*\(\s*ativa\s*\)\s*\{[\s\S]*?this\.materialTransp\.transparent\s*=\s*true[\s\S]*?this\.materialTransp\.opacity\s*=\s*0\.78[\s\S]*?this\.materialTransp\.side\s*=\s*THREE\.DoubleSide/.test(game),
  'Toggle precisa ligar transparency real (Minecraft default).');
t('setTransparenciaAtiva inativa: transparent=false, opacity=1.0, FrontSide',
  /setTransparenciaAtiva[\s\S]*?else\s*\{[\s\S]*?this\.materialTransp\.transparent\s*=\s*false[\s\S]*?this\.materialTransp\.opacity\s*=\s*1\.0[\s\S]*?this\.materialTransp\.side\s*=\s*THREE\.FrontSide/.test(game),
  'Branch sólido precisa restaurar tudo para opaco/FrontSide.');

// ---------------------------------------------------------------------
// Minecraft real: FOLHA/VIDRO/ÁGUA são semi-transparentes (transp=true).
// AR e TOCHA também transp=true (ar pra face-culling, tocha é mesh
// especial, não cubo).
// ---------------------------------------------------------------------
grupo('BLOCO_INFO: folha/vidro/água semi-transparentes (Minecraft real)');
t('BLOCO_INFO[BLOCO.FOLHA].transp === true',
  /\[BLOCO\.FOLHA\][^}]*transp:\s*true/.test(game));
t('BLOCO_INFO[BLOCO.VIDRO].transp === true',
  /\[BLOCO\.VIDRO\][^}]*transp:\s*true/.test(game));
t('BLOCO_INFO[BLOCO.AGUA].transp === true',
  /\[BLOCO\.AGUA\][^}]*transp:\s*true/.test(game));
t('BLOCO_INFO[BLOCO.AR].transp === true (necessário para face-culling)',
  /\[BLOCO\.AR\][^}]*transp:\s*true/.test(game));
t('BLOCO_INFO[BLOCO.TOCHA].transp === true (mesh especial)',
  /\[BLOCO\.TOCHA\][^}]*transp:\s*true/.test(game));
t('Apenas 5 blocos com transp:true (AR/FOLHA/VIDRO/AGUA/TOCHA)', (() => {
  const matches = game.match(/\[BLOCO\.[A-Z_]+\][^}]*transp:\s*true/g) || [];
  return matches.length === 5;
}), 'Qualquer bloco extra com transp:true seria erro de copy/paste.');

// ---------------------------------------------------------------------
// Atlas opaco
// ---------------------------------------------------------------------
grupo('Atlas de texturas 100% opaco');
t('canvas do atlas é forçado a alpha=255 antes de virar textura',
  /dataAll\.data\[i\]\s*=\s*255/.test(game),
  'Sem isso, padrões com strokeStyle rgba(...,0.5) vazam alpha < 255.');
t('células não-pintadas recebem fill cinza neutro (não preto)',
  /for \(let idx = next; idx < cols \* rows; idx\+\+\)[\s\S]*?bg\(idx, 128, 128, 128\)/.test(game),
  'Sem isso, cells vazias viram preto após alpha=255 → bleed escurece bordas.');

// ---------------------------------------------------------------------
// UV inset + mipmaps off (fix da transparência vista de cima)
// ---------------------------------------------------------------------
grupo('Atlas: inset + sem mipmap (anti-bleed)');
t('uvCelula aplica inset > 0 nas bordas das células',
  /const inset = 0\.[1-9]\d*/.test(game),
  'Sem inset, sample oblíquo de longe puxa pixel da célula vizinha — vista de cima fica "transparente".');
t('atlas usa minFilter NearestFilter (sem mipmaps)',
  /tex\.minFilter\s*=\s*THREE\.NearestFilter/.test(game),
  'NearestMipmapLinear pré-mistura células no downsample — mesmo com inset, conteúdo dos mips vem corrompido.');
t('atlas com generateMipmaps = false',
  /tex\.generateMipmaps\s*=\s*false/.test(game));

// ---------------------------------------------------------------------
// AO por vértice (smooth lighting estilo Minecraft)
// ---------------------------------------------------------------------
grupo('Ambient Occlusion por vértice');
t('AO_OFFSETS definido com 6 faces',
  /const AO_OFFSETS\s*=\s*\[/.test(game) &&
  /\/\/\s*0:\s*TOP/.test(game) &&
  /\/\/\s*5:\s*-Z/.test(game),
  'Sem tabela completa, AO falha em alguma face e vira face plana.');
t('vertexAOValor implementa formula padrão (s1 && s2 → 0)',
  /function vertexAOValor[\s\S]*?if \(s1 && s2\) return 0;[\s\S]*?return 3 - \(s1 \+ s2 \+ cn\)/.test(game));
t('addFace recebe faceIdx + sx,sy,sz (self block) e usa AO_OFFSETS',
  /addFace\s*=\s*\(transp,\s*faceShade,\s*uvIdx,\s*faceIdx,\s*sx,\s*sy,\s*sz/.test(game) &&
  /const tab = AO_OFFSETS\[faceIdx\]/.test(game));
t('AO flip de diagonal aplicado (anti split visual)',
  /if \(ao0 \+ ao2 < ao1 \+ ao3\)/.test(game),
  'Sem flip, AO em quads aparece como rasgo diagonal visível.');
t('AO_FACTOR mapeia [0..3] em range razoável (0.5..1.0)', (() => {
  const m = game.match(/const AO_FACTOR = \[([^\]]+)\]/);
  if (!m) return false;
  const vals = m[1].split(',').map(s => parseFloat(s.trim()));
  if (vals.length !== 4) return false;
  return vals[0] >= 0.45 && vals[0] <= 0.75 &&
         vals[3] === 1.00 &&
         vals[0] < vals[1] && vals[1] < vals[2] && vals[2] < vals[3];
}), 'Range muito agressivo escurece cantos a preto; muito suave torna AO invisível.');

// ---------------------------------------------------------------------
// Tone mapping ACES Filmic (correto pro pipeline sRGB).
// Cineon retorna em espaço gamma 2.2 e o renderer com
// outputColorSpace=SRGBColorSpace encoda DE NOVO → cores saturadas
// viravam fluorescentes (roxo neon dominava a tela). ACES retorna
// linear, então o sRGB output só encoda uma vez.
// ---------------------------------------------------------------------
grupo('Tone mapping');
t('renderer com ACESFilmicToneMapping (linear, sem double-gamma)',
  /toneMapping\s*=\s*THREE\.ACESFilmicToneMapping/.test(game),
  'CineonToneMapping double-encoda gamma com SRGBColorSpace; ACES é o correto.');
t('toneMappingExposure entre 0.95 e 1.25 (compensa compressão ACES)', (() => {
  const m = game.match(/toneMappingExposure\s*=\s*(\d+\.?\d*)/);
  if (!m) return false;
  const v = parseFloat(m[1]);
  return v >= 0.95 && v <= 1.25;
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
// Obsidiana: visível mas não fluorescente.
// Antes 0x6e3a8c (média 87) saturava demais e dominava a tela quando
// exposta por cavernas. Agora 0x3a2148 (média 49) — distinguível do
// céu noturno (RGB 60 floor) mas discreto.
// ---------------------------------------------------------------------
grupo('Obsidiana: tom discreto');
t('cor da obsidiana com brilho médio entre 40 e 80', (() => {
  const m = game.match(/\[BLOCO\.OBSIDIANA\][\s\S]*?cor:\s*0x([0-9a-fA-F]{6})/);
  if (!m) return false;
  const v = parseInt(m[1], 16);
  const r = (v >> 16) & 0xFF, g = (v >> 8) & 0xFF, b = v & 0xFF;
  const med = (r + g + b) / 3;
  return med >= 40 && med <= 80;
}), '< 40 confunde com céu noturno; > 80 vira fluorescente sob ACES.');

// ---------------------------------------------------------------------
// Cavernas estritamente subterrâneas (não vazam pra vista superior)
// ---------------------------------------------------------------------
grupo('Cavernas: subterrâneas e raras');
t('threshold profundo <= 0.15 (cavernas raras mesmo no nível mais raso)', (() => {
  const m = game.match(/y < 8 \?\s*(0\.\d+)/);
  return m && parseFloat(m[1]) <= 0.15;
}), 'Antes 0.22 deixava o piso esponjoso e expunha obsidiana de cima.');
t('threshold mediano <= 0.12', (() => {
  const m = game.match(/y < 14 \?\s*(0\.\d+)/);
  return m && parseFloat(m[1]) <= 0.12;
}));
t('caverna começa em y >= 5 (preserva bedrock + camada lava/pedra)', (() => {
  const m = game.match(/for \(let y = (\d+); y < hSurf - 2/);
  return m && parseInt(m[1]) >= 5;
}), 'Cavernas em y<5 podem expor bedrock obsidiana — vista superior fica dominada por roxo.');
t('bedrock 3 camadas: y<=2 sempre OBSIDIANA', (() => {
  return /if \(y <= 2\) b = BLOCO\.OBSIDIANA/.test(game);
}), 'Sem bedrock espesso, paredes laterais de cavernas baixas vazam obsidiana.');

// ---------------------------------------------------------------------
// Default Minecraft real: transparenciaAtiva = true no init do Renderer.
// ---------------------------------------------------------------------
grupo('Default visual: modo transparente (Minecraft real)');
t('Renderer init com transparenciaAtiva = true', (() => {
  return /this\.transparenciaAtiva\s*=\s*true/.test(game);
}));
t('Renderer chama setTransparenciaAtiva(true) no construtor', (() => {
  // Garantir que materialTransp arranca com flags certos (transparent +
  // DoubleSide + opacity 0.78), não só com transparenciaAtiva=true setado.
  return /this\.transparenciaAtiva\s*=\s*true;\s*this\.setTransparenciaAtiva\(true\)/.test(game);
}));
t('init() sincroniza btn-transp com default transparente (sem classe solido)',
  /btn-transp[\s\S]*?classList\.remove\(['"]solido['"]\)/.test(game),
  'HTML inicia com classe solido — init precisa removê-la pra refletir o default Minecraft.');

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
// UX polish Minecraft authenticity: footstep, hotbar toast, FOV sprint.
// ---------------------------------------------------------------------
grupo('UX Minecraft polish');
t('Audio.passo(mat) existe e delega para sfx.passo com material',
  /passo\(mat\)[^\n]*this\._sfx\(\)\.passo[^\n]*\(mat\)/.test(game),
  'Audio.passo agora aceita material (grama/pedra/madeira/etc) para variar o SFX.');
t('Player tem distAndada accumulator',
  /this\.distAndada\s*=\s*0/.test(game));
t('Player.atualizar acumula distAndada e dispara Audio.passo com material do bloco',
  /this\.distAndada\s*\+=\s*distH[\s\S]*?if\s*\(\s*this\.distAndada\s*>=\s*passoLimiar\s*\)[\s\S]*?materialDeBloco\(bPe\)[\s\S]*?Audio\.passo\(this\.materialPasso\)/.test(game),
  'Passo dispara o SFX correto baseado no material do bloco abaixo dos pés.');
t('Inventario.selecionar emite toast com nome do bloco/item (slot não vazio)',
  /selecionar\(idx\)\s*\{[\s\S]*?BLOCO_INFO\[it\.b\]\?\.nome[\s\S]*?ITEM_INFO\[it\.i\]\?\.nome[\s\S]*?ui\.toast\(nome\)/.test(game),
  'Hotbar deve indicar o que está selecionado quando há item — Minecraft style.');
t('Renderer.atualizarFOV implementa lerp para 70 + (correndo ? 8 : 0)',
  /atualizarFOV\(dt,\s*correndo\)[\s\S]*?const alvo\s*=\s*70\s*\+\s*\(correndo\s*\?\s*8\s*:\s*0\)[\s\S]*?this\.camera\.updateProjectionMatrix\(\)/.test(game),
  'FOV pulse durante sprint reforça sensação de velocidade.');
t('loop chama renderer.atualizarFOV com player.input.sprint',
  /renderer\.atualizarFOV\(dt,[^)]*player\.input\.sprint/.test(game));

// ---------------------------------------------------------------------
// alternarTransparencia handler: real toggle (não no-op)
// ---------------------------------------------------------------------
grupo('alternarTransparencia handler real');
t('alternarTransparencia inverte transparenciaAtiva (não força false)',
  /function alternarTransparencia\(\)\s*\{[\s\S]*?const novo\s*=\s*!renderer\.transparenciaAtiva[\s\S]*?renderer\.setTransparenciaAtiva\(novo\)/.test(game),
  'Handler precisa toggle real, não força sólido.');
t('alternarTransparencia atualiza btn-transp class via toggle',
  /alternarTransparencia[\s\S]*?btn\.classList\.toggle\(['"]solido['"],\s*!novo\)/.test(game));
t('alternarTransparencia emite toast com estado',
  /alternarTransparencia[\s\S]*?ui\.toast\([^)]*Blocos:\s*transparentes[^)]*\|\|[^)]*Blocos:\s*sólidos|alternarTransparencia[\s\S]*?ui\.toast\(novo\s*\?\s*['"][^'"]*transparentes[^'"]*['"]\s*:\s*['"][^'"]*sólidos/.test(game));

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
