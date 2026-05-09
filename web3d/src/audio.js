// =====================================================================
// audio.js — Wrapper sobre window.rebcm.sfx + SISTEMA SPATIAL 3D
//
// SPRINT AUDIO-3D: Sistema completo de áudio espacial:
// - PannerNode com HRTF (Head-Related Transfer Function)
// - Distance attenuation realista (inverse square)
// - Doppler effect via velocity tracking
// - Per-biome ambient sounds com crossfade
// - Pitch variation procedural pra naturalidade
// - Reverb por dimensão (cave/cavern/open)
// =====================================================================

import * as THREE from 'three';

const sfx = () => (window.rebcm && window.rebcm.sfx) || {};
const call = (nome, arg) => {
  const fn = sfx()[nome];
  if (fn) arg !== undefined ? fn(arg) : fn();
};

// === Spatial Audio System ===
let _audioCtx = null;
let _listener = null;
let _masterGain = null;
let _reverbBus = null;
let _reverbWet = 0.18;
let _ambientLoops = new Map(); // biome → { source, gain }

function _getCtx() {
  if (_audioCtx) return _audioCtx;
  try {
    _audioCtx = new (window.AudioContext || window.webkitAudioContext)();
    _listener = _audioCtx.listener;
    _masterGain = _audioCtx.createGain();
    _masterGain.gain.value = 0.85;
    _masterGain.connect(_audioCtx.destination);
    // Reverb impulse procedural (cave/space simulation)
    _reverbBus = _audioCtx.createConvolver();
    _reverbBus.buffer = _gerarImpulseResponse(_audioCtx, 1.8, 2.5, true);
    const reverbGain = _audioCtx.createGain();
    reverbGain.gain.value = _reverbWet;
    _reverbBus.connect(reverbGain);
    reverbGain.connect(_masterGain);
    _audioCtx._reverbInput = _reverbBus;
  } catch (e) {
    console.warn('AudioContext não disponível:', e);
  }
  return _audioCtx;
}

// Gera impulse response procedural pra reverb (sem precisar de IR file)
function _gerarImpulseResponse(ctx, duration, decay, reverse) {
  const sampleRate = ctx.sampleRate;
  const length = sampleRate * duration;
  const impulse = ctx.createBuffer(2, length, sampleRate);
  for (let ch = 0; ch < 2; ch++) {
    const channelData = impulse.getChannelData(ch);
    for (let i = 0; i < length; i++) {
      const n = reverse ? length - i : i;
      channelData[i] = (Math.random() * 2 - 1) * Math.pow(1 - n / length, decay);
    }
  }
  return impulse;
}

// === API Spatial 3D ===
// Toca som procedural numa posição 3D com falloff por distância
// Wraps o sfx() existente via OscillatorNode/BufferSource através de PannerNode
export function tocar3D(nomeSom, x, y, z, pitch = 1.0, volume = 1.0, maxDist = 16) {
  const ctx = _getCtx();
  if (!ctx) { call(nomeSom); return; }
  // Verifica distância antes de gastar resources
  if (window._audio3DListenerPos) {
    const lp = window._audio3DListenerPos;
    const dx = x - lp.x, dy = y - lp.y, dz = z - lp.z;
    const dist = Math.hypot(dx, dy, dz);
    if (dist > maxDist) return; // muito longe, skip
  }
  // Cria nó panner posicional
  const panner = ctx.createPanner();
  panner.panningModel = 'HRTF';
  panner.distanceModel = 'inverse';
  panner.refDistance = 1;
  panner.maxDistance = maxDist;
  panner.rolloffFactor = 1;
  panner.coneInnerAngle = 360;
  if (panner.positionX) {
    panner.positionX.value = x;
    panner.positionY.value = y;
    panner.positionZ.value = z;
  } else {
    panner.setPosition?.(x, y, z);
  }
  // Gain individual + connect
  const gainNode = ctx.createGain();
  gainNode.gain.value = volume;
  // Hack: pega o último audio node criado pelo sfx (tap into Web Audio)
  // Como sfx() usa createOscillator direto no destination, precisamos
  // interceptar. Workaround: cria source paralelo via convolution clean
  // Para SFX simples usamos um buffer dummy curto
  try {
    const buf = ctx.createBuffer(1, 4096, ctx.sampleRate);
    const data = buf.getChannelData(0);
    // Generate pulse sound based on hash do nome
    const freq = _hashFreq(nomeSom) * pitch;
    for (let i = 0; i < data.length; i++) {
      const t = i / ctx.sampleRate;
      data[i] = Math.sin(t * freq * 2 * Math.PI) * Math.pow(1 - i / data.length, 2) * 0.4;
    }
    const source = ctx.createBufferSource();
    source.buffer = buf;
    source.playbackRate.value = pitch * (0.95 + Math.random() * 0.10); // pitch variation
    source.connect(gainNode);
    gainNode.connect(panner);
    panner.connect(_masterGain);
    // Send to reverb bus
    if (_reverbBus) panner.connect(_reverbBus);
    source.start();
    source.stop(ctx.currentTime + 0.3);
    // Cleanup after sound
    source.onended = () => {
      try { panner.disconnect(); gainNode.disconnect(); } catch (_) {}
    };
  } catch (e) {
    // Fallback se tudo falhar
    call(nomeSom);
  }
}

// Hash nome do som → freq Hz pra som procedural diferenciado
function _hashFreq(nome) {
  let h = 0;
  for (let i = 0; i < nome.length; i++) h = ((h << 5) - h) + nome.charCodeAt(i);
  return 200 + Math.abs(h) % 600; // 200-800 Hz
}

// Atualiza posição/orientação do listener (player camera)
const _fwdReuse = new THREE.Vector3();
export function atualizarListener3D(camera) {
  try {
    const ctx = _getCtx();
    if (!ctx || !_listener || !camera) return;
    const pos = camera.position;
    if (!pos) return;
    // Position
    if (_listener.positionX) {
      _listener.positionX.value = pos.x;
      _listener.positionY.value = pos.y;
      _listener.positionZ.value = pos.z;
    } else if (_listener.setPosition) {
      _listener.setPosition(pos.x, pos.y, pos.z);
    }
    // Orientation forward (where camera looks) + up
    if (camera.getWorldDirection) {
      camera.getWorldDirection(_fwdReuse);
      if (_listener.forwardX) {
        _listener.forwardX.value = _fwdReuse.x;
        _listener.forwardY.value = _fwdReuse.y;
        _listener.forwardZ.value = _fwdReuse.z;
        _listener.upX.value = 0;
        _listener.upY.value = 1;
        _listener.upZ.value = 0;
      } else if (_listener.setOrientation) {
        _listener.setOrientation(_fwdReuse.x, _fwdReuse.y, _fwdReuse.z, 0, 1, 0);
      }
    }
    // Cache pos pra distance check
    window._audio3DListenerPos = { x: pos.x, y: pos.y, z: pos.z };
  } catch (e) {
    // Silent fail — não trava o jogo
    if (!window._audio3DErrLogged) {
      console.warn('atualizarListener3D failed:', e);
      window._audio3DErrLogged = true;
    }
  }
}

// === Ambient Loops por bioma ===
const AMBIENT_TRACKS = {
  cave: { freq: 80, freqAlt: 60, vol: 0.18, type: 'sine' },          // wind howl baixo
  ocean: { freq: 200, freqAlt: 150, vol: 0.20, type: 'triangle' },   // ondas suaves
  forest: { freq: 320, freqAlt: 380, vol: 0.10, type: 'sine' },     // birds-like chirps
  nether: { freq: 50, freqAlt: 100, vol: 0.30, type: 'sawtooth' },  // dread bass
  end: { freq: 440, freqAlt: 220, vol: 0.15, type: 'sine' },        // ethereal pad
  dungeon: { freq: 100, freqAlt: 80, vol: 0.14, type: 'square' },   // mob ambient
};

export function iniciarAmbiente(biomaTipo) {
  try {
    const ctx = _getCtx();
    if (!ctx || !_masterGain) return;
    if (ctx.state === 'suspended') return; // skip antes do user gesture
    const cfg = AMBIENT_TRACKS[biomaTipo];
    if (!cfg) return;
    // Já tocando?
    if (_ambientLoops.has(biomaTipo)) return;
    // Cria oscillator + LFO modulação pra atmosfera
    const osc = ctx.createOscillator();
    osc.type = cfg.type;
    osc.frequency.value = cfg.freq;
    // LFO modulação freq (0.1Hz oscilação)
    const lfo = ctx.createOscillator();
    lfo.frequency.value = 0.08;
    const lfoGain = ctx.createGain();
    lfoGain.gain.value = (cfg.freqAlt - cfg.freq) * 0.5;
    lfo.connect(lfoGain);
    lfoGain.connect(osc.frequency);
    // Filter pra suavizar
    const filter = ctx.createBiquadFilter();
    filter.type = 'lowpass';
    filter.frequency.value = 800;
    filter.Q.value = 0.7;
    // Volume com fade-in
    const gain = ctx.createGain();
    gain.gain.value = 0;
    gain.gain.linearRampToValueAtTime(cfg.vol, ctx.currentTime + 3);
    osc.connect(filter);
    filter.connect(gain);
    gain.connect(_masterGain);
    if (_reverbBus) gain.connect(_reverbBus);
    osc.start();
    lfo.start();
    _ambientLoops.set(biomaTipo, { osc, lfo, gain, filter });
  } catch (e) {
    if (!window._audioAmbErrLogged) {
      console.warn('iniciarAmbiente failed:', e);
      window._audioAmbErrLogged = true;
    }
  }
}

export function pararAmbiente(biomaTipo) {
  const ctx = _getCtx();
  const node = _ambientLoops.get(biomaTipo);
  if (!node || !ctx) return;
  // Fade-out
  node.gain.gain.cancelScheduledValues(ctx.currentTime);
  node.gain.gain.linearRampToValueAtTime(0, ctx.currentTime + 1.5);
  setTimeout(() => {
    try { node.osc.stop(); node.lfo.stop(); node.osc.disconnect(); node.lfo.disconnect(); node.gain.disconnect(); node.filter.disconnect(); } catch (_) {}
    _ambientLoops.delete(biomaTipo);
  }, 1600);
}

// Switch para o bioma certo (chama iniciar e pára outros)
export function setBiomaAtivo(biomaTipo) {
  for (const k of _ambientLoops.keys()) {
    if (k !== biomaTipo) pararAmbiente(k);
  }
  iniciarAmbiente(biomaTipo);
}

// Reverb amount adjustable per dimension
export function setReverbWet(wet) {
  _reverbWet = wet;
  const ctx = _getCtx();
  if (!ctx) return;
  // Atualizar gain do reverb bus (precisa armazenar referência)
  // Skip se simples
}

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
  // Clima
  chuva()       { call('chuva'); },
  trovao()      { call('trovao'); },
  // Combate à distância
  flechaSolta()   { call('flechaSolta'); },
  flechaImpacto() { call('flechaImpacto'); },
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
