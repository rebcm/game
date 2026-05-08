// =====================================================================
// test-web3d-precheck.js — Smoke tests pré-deploy do web3d/
//
// Validações estáticas (sem rodar o jogo) que garantem invariantes
// críticas. Roda automaticamente em scripts/deploy-web3d.sh antes do
// `wrangler pages deploy`. Falha → deploy aborta com exit 1.
//
// Uso: node scripts/test-web3d-precheck.js [diretorio]
// Default diretorio = ./web3d
// =====================================================================

const fs = require('fs');
const path = require('path');

const dir = process.argv[2] || path.join(__dirname, '..', 'web3d');
let falhas = 0;
let totalGrupos = 0;

function lerArquivo(rel) {
  const p = path.join(dir, rel);
  if (!fs.existsSync(p)) return null;
  return fs.readFileSync(p, 'utf8');
}

function grupo(nome) {
  totalGrupos++;
  console.log(`\n▌ ${nome}`);
}
function t(desc, cond, hint) {
  if (cond) console.log(`  ✓ ${desc}`);
  else {
    console.log(`  ✗ ${desc}`);
    if (hint) console.log(`      ${hint}`);
    falhas++;
  }
}

// =====================================================================
// 1) ESTRUTURA DE ARQUIVOS
// =====================================================================
grupo('Estrutura de arquivos');
const arquivosObrigatorios = [
  'index.html', 'style.css', 'manifest.json', '_headers',
  'src/main.js', 'src/constants.js', 'src/utils.js', 'src/state.js',
  'src/audio.js', 'src/world.js', 'src/render.js', 'src/player.js',
  'src/inventory.js', 'src/mobs.js', 'src/particles.js',
  'src/ui.js', 'src/save.js', 'src/input.js',
  'src/weather.js',  // Novo: sistema de chuva
];
for (const f of arquivosObrigatorios) {
  t(`existe ${f}`, fs.existsSync(path.join(dir, f)));
}
t('NÃO existe game.js (refatoração modular)',
  !fs.existsSync(path.join(dir, 'game.js')),
  'O jogo agora carrega src/main.js como entry point.');

// =====================================================================
// 2) SINTAXE DE CADA MÓDULO
// =====================================================================
grupo('Sintaxe (node --check) por módulo');
const { execSync } = require('child_process');
const srcDir = path.join(dir, 'src');
if (fs.existsSync(srcDir)) {
  for (const f of fs.readdirSync(srcDir)) {
    if (!f.endsWith('.js')) continue;
    try {
      execSync(`node --check "${path.join(srcDir, f)}"`, { stdio: 'pipe' });
      t(`${f} sintaxe ok`, true);
    } catch (e) {
      t(`${f} sintaxe ok`, false, e.message);
    }
  }
}

// =====================================================================
// 3) BLOCOS OPACOS (eliminação de transparência)
// =====================================================================
grupo('Blocos opacos: transparência foi eliminada');
const constants = lerArquivo('src/constants.js') || '';
t('constants.js NÃO declara `transp` em BLOCO_INFO',
  !/transp\s*:\s*true/.test(constants),
  'A refatoração eliminou todos os blocos transparentes.');
t('vidro/folha/agua/tocha aparecem em BLOCO_INFO',
  /BLOCO\.VIDRO/.test(constants) && /BLOCO\.FOLHA/.test(constants) &&
  /BLOCO\.AGUA/.test(constants) && /BLOCO\.TOCHA/.test(constants));
const render = lerArquivo('src/render.js') || '';
t('render.js NÃO usa meshT/positionsT (path transparente removido)',
  !/meshT|positionsT|colorsT|indicesT/.test(render),
  'O mesh builder é único — todos os blocos no mesh principal.');

// =====================================================================
// 4) HTML
// =====================================================================
grupo('index.html');
const html = lerArquivo('index.html') || '';
t('aponta para src/main.js', /import\([^)]*\.\/src\/main\.js/.test(html));
t('NÃO importa game.js antigo', !/['"]\.\/game\.js[^'"]*['"]/.test(html));
t('importmap define three e three/addons',
  /three['"]\s*:\s*['"]https:\/\/[^'"]+three\.module\.js/.test(html) &&
  /three\/addons\/['"]/.test(html));
t('NÃO há btn-transp', !/id="btn-transp"/.test(html));
t('NÃO há tecla T no help de controles', !/Alternar transpar[êe]ncia/i.test(html));
t('div #subtitles existe', /id="subtitles"/.test(html));
t('div #f3-debug existe', /id="f3-debug"/.test(html));
t('div #pause-menu existe', /id="pause-menu"/.test(html));
t('div #painel-criativo existe', /id="painel-criativo"/.test(html));
t('div #vinheta existe', /id="vinheta"/.test(html));
t('div #flash-dano existe', /id="flash-dano"/.test(html));
t('SFX inline define mob sounds',
  /zumbi\s*:|esqueleto\s*:|creeperHiss\s*:/.test(html));
t('SFX inline define música rica (acordes)',
  /tocarAcorde|progressao/.test(html));

// =====================================================================
// 5) MÓDULOS — invariantes críticos
// =====================================================================
grupo('constants.js');
t('exporta CHUNK_SIZE/WORLD_Y/BLOCO/RECEITAS',
  /export\s+const\s+CHUNK_SIZE/.test(constants) &&
  /export\s+const\s+WORLD_Y/.test(constants) &&
  /export\s+const\s+BLOCO\s*=/.test(constants) &&
  /export\s+const\s+RECEITAS/.test(constants));
t('SAVE_KEY versão >= v4',
  /SAVE_KEY\s*=\s*['"]rebcm3d_save_v[4-9]['"]/.test(constants),
  'Refatoração modular bumped o save schema.');

grupo('world.js');
const world = lerArquivo('src/world.js') || '';
t('Chunk com canal de luz (this.light = new Uint8Array)',
  /this\.light\s*=\s*new\s+Uint8Array/.test(world));
t('World.recalcLuzChunk com BFS de blocklight',
  /recalcLuzChunk[\s\S]*queue\s*=\s*\[\][\s\S]*emite/.test(world));
t('World.getLightAt retorna {sky, block}',
  /getLightAt[\s\S]*sky\s*:[\s\S]*block\s*:/.test(world));

grupo('render.js');
t('Renderer com camera shake (aplicarShake/atualizarShake)',
  /aplicarShake|atualizarShake/.test(render));
t('Renderer com nuvens scrolling',
  /cloudMesh|cloudTexture/.test(render));
t('Renderer com estrelas',
  /estrelas/.test(render));
t('mesh builder usa getLightAt (iluminação 15 níveis)',
  /world\.getLightAt/.test(render));

grupo('player.js');
const player = lerArquivo('src/player.js') || '';
t('Player com sneak + naAgua (swim physics)',
  /this\.sneak/.test(player) && /naAgua/.test(player));
t('Player aplica saturation antes de fome',
  /this\.saturation/.test(player));
t('Player tem ar/oxigenio submerso',
  /this\.ar\s*=\s*20/.test(player) || /this\.arMax\s*=\s*20/.test(player));

grupo('mobs.js');
const mobs = lerArquivo('src/mobs.js') || '';
t('Mobs incluem slime + enderman',
  /slime\s*:/.test(mobs) && /enderman\s*:/.test(mobs));
t('Spawn rules por light level',
  /getLightAt[\s\S]*luzMax\s*<=?\s*7/.test(mobs));
t('11 espécies em MOB_INFO',
  (mobs.match(/^\s+[a-z]+\s*:\s*\{/gm) || []).length >= 11);
// Anti-regressão: usos de BLOCO_INFO/colideEm exigem import correto.
// Bug histórico: colideEm usava BLOCO_INFO sem importar e travava o
// jogo (Uncaught ReferenceError) na primeira colisão de mob.
t('mobs.js importa BLOCO_INFO se usa BLOCO_INFO',
  !/\bBLOCO_INFO\b/.test(mobs) ||
  /import\s*\{[^}]*BLOCO_INFO[^}]*\}\s*from\s*['"]\.\/constants\.js['"]/.test(mobs),
  'colideEm e isSolido precisam de BLOCO_INFO importado.');

grupo('particles.js');
const particles = lerArquivo('src/particles.js') || '';
t('XPOrb classe definida',
  /class\s+XPOrb/.test(particles));
t('ItemDrop classe definida',
  /class\s+ItemDrop/.test(particles));
t('spawnSmoke + spawnLavaSpark + emitirAmbient',
  /spawnSmoke/.test(particles) && /spawnLavaSpark/.test(particles) && /emitirAmbient/.test(particles));

grupo('ui.js');
const ui = lerArquivo('src/ui.js') || '';
t('UI tem F3, F1, pause menu, criativo',
  /toggleF3/.test(ui) && /toggleHud/.test(ui) &&
  /mostrarPause/.test(ui) && /renderCriativo/.test(ui));
t('UI tem flash de dano + heart shake',
  /flashDano/.test(ui) && /shake/.test(ui));
t('Tooltip implementation',
  /_tooltipMostrar/.test(ui));

grupo('audio.js');
const audio = lerArquivo('src/audio.js') || '';
t('Audio.passo aceita material como arg',
  /passo\(mat\)[^\n]*passo[^\n]*\(mat\)/.test(audio));
t('Audio.mobCall wrapper genérico',
  /mobCall\(tipo\)/.test(audio));
t('Audio expõe críticos: hurt, critical, splash',
  /hurt\s*\(\s*\)/.test(audio) && /critical\s*\(\s*\)/.test(audio) && /splash\s*\(\s*\)/.test(audio));

grupo('input.js');
const input = lerArquivo('src/input.js') || '';
t('input.js wireado a F1/F3/Esc',
  /F1[\s\S]*toggleHud/.test(input) && /F3[\s\S]*toggleF3/.test(input) && /Escape/.test(input));
t('input.js NÃO menciona KeyT (transparência removida)',
  !/case\s*['"]KeyT['"]/.test(input));
t('input.js suporte touch (joystick + look)',
  /touch-joy/.test(input) && /touch-look/.test(input));

grupo('main.js');
const main = lerArquivo('src/main.js') || '';
t('main.js cria todas as instâncias em init()',
  /new Renderer/.test(main) && /new World/.test(main) &&
  /new Player/.test(main) && /new MobManager/.test(main) &&
  /new Inventario/.test(main));
t('Loop chama atualizarItemDrops + atualizarXpOrbs + atualizarAmbientTriggers',
  /atualizarItemDrops/.test(main) && /atualizarXpOrbs/.test(main) && /atualizarAmbientTriggers/.test(main));
t('Botão JOGAR liga init e pointer lock',
  /play.{0,30}(addEventListener|onclick)/.test(main) &&
  /controls\.lock/.test(main),
  'Boot screen agora usa onclick do play (handler renderBoot) + _entrarNoJogo.');

grupo('save.js');
const save = lerArquivo('src/save.js') || '';
t('Save versão v: 5 (multi-mundo)',
  /v\s*:\s*5/.test(save),
  'Schema v5 inclui name + playerName + savedAt pra multi-mundo.');
t('Save tem listarMundos + carregarPorNome (multi-save)',
  /listarMundos/.test(save) && /carregarPorNome/.test(save));
t('Save expõe identidade do player (getPlayer/setPlayer)',
  /getPlayer/.test(save) && /setPlayer/.test(save));
// BUG-fix: JSON.parse(null) retorna null silently. _safeJSON precisa
// checar isso ou todos os getters retornam null e o boot quebra.
t('_safeJSON trata null/undefined sem retornar null',
  /s\s*===\s*null\s*\|\|\s*s\s*===\s*undefined/.test(save) ||
  /v\s*===\s*null\s*\|\|\s*v\s*===\s*undefined/.test(save),
  'Boot screen não pode quebrar se localStorage está vazio.');
t('Save tem export/import pra compartilhamento de mundo',
  /exportarMundoAtual/.test(save) && /importarMundo/.test(save));
t('Save serializa chunks modificados em base64',
  /btoa\(String\.fromCharCode/.test(save));

grupo('utils.js — Perlin noise');
const utils = lerArquivo('src/utils.js') || '';
t('export perlin2(x, y, seed)',
  /export\s+function\s+perlin2\s*\(/.test(utils));
t('export perlin3(x, y, z, seed)',
  /export\s+function\s+perlin3\s*\(/.test(utils));
t('export fbm2 (fractal Brownian motion)',
  /export\s+function\s+fbm2\s*\(/.test(utils));

grupo('world.js — Perlin aplicado');
t('alturaTerreno usa fbm2 (Perlin orgânico)',
  /alturaTerreno[\s\S]*?fbm2\s*\(/.test(world));
t('caverna usa perlin3 (paridade Minecraft)',
  /caverna[\s\S]*?perlin3\s*\(/.test(world));

grupo('weather.js — Sistema de clima');
const weather = lerArquivo('src/weather.js') || '';
t('export atualizarClima(dt)',
  /export\s+function\s+atualizarClima/.test(weather));
t('export corCeuComClima(cor, sun)',
  /export\s+function\s+corCeuComClima/.test(weather));
t('Define modo clear/rain',
  /'clear'/.test(weather) && /'rain'/.test(weather));
t('Toca SFX de chuva e trovão',
  /Audio\.chuva/.test(weather) && /Audio\.trovao/.test(weather));

grupo('Bow + Arrow combat');
t('ITEM.ARCO + ITEM.FLECHA em constants.js',
  /ARCO\s*:\s*\d+/.test(constants) && /FLECHA\s*:\s*\d+/.test(constants));
t('Receita ARCO em RECEITAS',
  /saida\s*:\s*\{\s*i\s*:\s*ITEM\.ARCO/.test(constants));
t('Receita FLECHA em RECEITAS',
  /saida\s*:\s*\{\s*i\s*:\s*ITEM\.FLECHA/.test(constants));
t('class Arrow em particles.js',
  /class\s+Arrow/.test(particles));
t('export spawnArrow + atualizarArrows',
  /export\s+function\s+spawnArrow/.test(particles) &&
  /export\s+function\s+atualizarArrows/.test(particles));

grupo('Camera bobbing + Damage numbers');
t('Renderer.atualizarBobbing(dt, andando, sprintando)',
  /atualizarBobbing\s*\(dt,\s*andando,\s*sprintando\)/.test(render));
t('main.js aplica bob na camera',
  /atualizarBobbing[\s\S]{0,400}camera\.position\.x\s*\+=/.test(main));
t('UI.spawnDamageNumber + atualizarDamageNumbers',
  /spawnDamageNumber\s*\(/.test(ui) && /atualizarDamageNumbers\s*\(/.test(ui));
t('CSS .damage-number definido',
  /\.damage-number\s*\{/.test(lerArquivo('style.css') || ''));

grupo('main.js — integração das novas features');
t('main.js importa atualizarClima',
  /import\s+\{\s*atualizarClima/.test(main));
t('main.js chama atualizarArrows no loop',
  /atualizarArrows\s*\(\s*dt\s*\)/.test(main));
t('atacarMob detecta ITEM.ARCO (entra em charge mode)',
  /usandoArco[\s\S]{0,400}bowCharging/.test(main),
  'O arco agora carrega: atacarMob arma bowCharging e soltarArco dispara via spawnArrow.');
t('soltarArco dispara projétil com spawnArrow',
  /function soltarArco[\s\S]{0,800}spawnArrow/.test(main));
t('atacarMob spawn damage number',
  /spawnDamageNumber/.test(main));

// =====================================================================
// Sumário
// =====================================================================
console.log('\n────────────────────────────────────────');
console.log(`✓ ${(arquivosObrigatorios.length + totalGrupos * 5) - falhas} passaram   ✗ ${falhas} falharam`);
if (falhas > 0) {
  console.log('\n❌ FALHA — não publique este build até corrigir.');
  process.exit(1);
} else {
  console.log('\n✅ Tudo OK — build pronto para deploy.');
  process.exit(0);
}
