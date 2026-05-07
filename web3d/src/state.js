// =====================================================================
// state.js — Estado global compartilhado entre módulos
//
// Mantém referências às instâncias principais. Inicializadas em main.js.
// Outros módulos importam `state` e leem/escrevem propriedades.
//
// Padrão: quando um módulo precisa do `world`, faz `import { state } from './state.js'`
// e usa `state.world.get(x,y,z)`. Isso evita ciclos de import e o ônus
// de passar instâncias em todos os parâmetros.
// =====================================================================

export const state = {
  // Instâncias do jogo (atribuídas em main.js init())
  renderer: null,    // Renderer (Three.js)
  world: null,       // World (chunks + lighting + estados)
  player: null,      // Player (física, controles, HP, fome)
  inv: null,         // Inventario (slots, armadura)
  ui: null,          // UI (DOM, paineis, F3, pause)
  mobMgr: null,      // MobManager (mobs vivos)
  particulas: null,  // Particulas (partículas e ambient)

  // Estado do mundo / runtime
  tempoDia: 0.25,    // 0..1, ciclo de 4 minutos
  chunkLoadOrcamento: 3,
  fpsAcc: 0,
  fpsTimer: 0,

  // Entidades flutuantes
  dropEntidades: [], // Item drops voando
  xpOrbs: [],        // XP orbs voando

  // Painel ativo (baú/fornalha)
  bauAtivoCoords: null,
  fornalhaAtivaCoords: null,

  // Acumuladores de ambient
  ambientAcc: 0,
};
