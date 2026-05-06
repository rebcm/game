// =====================================================================
// audio.js — Wrapper sobre window.rebcm.sfx (definido inline no HTML)
//
// O HTML cria os SFX procedurais via Web Audio API. Este módulo
// só expõe nomes amigáveis para o resto do código chamar.
// =====================================================================

const sfx = () => (window.rebcm && window.rebcm.sfx) || {};
const call = (nome, arg) => {
  const fn = sfx()[nome];
  if (fn) arg !== undefined ? fn(arg) : fn();
};

export const Audio = {
  // Mundo / blocos
  quebrar()  { call('quebrar'); },
  colocar()  { call('colocar'); },
  // Combate
  atacar()   { call('atacar'); },
  hit()      { call('hit'); },
  hurt()     { (sfx().hurt || sfx().hit || (() => {}))(); },
  critical() { (sfx().critical || sfx().atacar || (() => {}))(); },
  // Comer / sobrevivência
  comer()    { call('comer'); },
  eatCrunch(){ (sfx().eatCrunch || sfx().comer || (() => {}))(); },
  respawn()  { call('respawn'); },
  // Movimento
  passo(mat) { (sfx().passo || (() => {}))(mat); },
  splash()   { call('splash'); },
  bolha()    { call('bolha'); },
  // Progressão
  levelUp()  { (sfx().levelUp || sfx().respawn || (() => {}))(); },
  pickup()   { call('pickup'); },
  xpOrb()    { (sfx().xpOrb || sfx().pickup || (() => {}))(); },
  explosao() { (sfx().explosao || sfx().hit || (() => {}))(); },
  // Mobs
  zumbi()           { call('zumbi'); },
  zumbiHit()        { (sfx().zumbiHit || sfx().hit || (() => {}))(); },
  esqueleto()       { call('esqueleto'); },
  creeperHiss()     { call('creeperHiss'); },
  aranha()          { call('aranha'); },
  vaca()            { call('vaca'); },
  ovelha()          { call('ovelha'); },
  porco()           { call('porco'); },
  galinha()         { call('galinha'); },
  lobo()            { call('lobo'); },
  slime()           { call('slime'); },
  endermanTeleport(){ (sfx().endermanTeleport || sfx().splash || (() => {}))(); },
  // Ambient
  caveDrip()    { call('caveDrip'); },
  caveAmbient() { call('caveAmbient'); },
  vento()       { call('vento'); },
  // UI
  chestOpen()   { call('chestOpen'); },
  chestClose()  { call('chestClose'); },
  bowDraw()     { call('bowDraw'); },
  bowRelease()  { call('bowRelease'); },
  arrow()       { call('arrow'); },
  equipArmor()  { (sfx().equipArmor || sfx().colocar || (() => {}))(); },
  cama()        { call('cama'); },
  fornalhaLit() { call('fornalhaLit'); },
  pageFlip()    { call('pageFlip'); },
  // Wrapper genérico para call casual de mob por tipo
  mobCall(tipo) {
    const map = {
      zumbi: 'zumbi', esqueleto: 'esqueleto', aranha: 'aranha',
      creeper: 'creeperHiss', vaca: 'vaca', ovelha: 'ovelha',
      porco: 'porco', galinha: 'galinha', lobo: 'lobo',
      slime: 'slime', enderman: 'endermanTeleport',
    };
    const fn = sfx()[map[tipo]];
    if (fn) fn();
  },
  // Música
  musicaIniciar() { window.rebcm?.musica?.iniciar?.(); },
  musicaParar()   { window.rebcm?.musica?.parar?.(); },
};
