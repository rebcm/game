// =====================================================================
// particles.js — Partículas, item drops, XP orbs, ambient triggers
// =====================================================================

import * as THREE from 'three';
import { BLOCO, BLOCO_INFO, GRAVIDADE, WORLD_Y } from './constants.js';
import { World } from './world.js';
import { state } from './state.js';
import { Audio } from './audio.js';

// === Partículas (faíscas, fumaça, gotas, sparks de lava) ===
export class Particulas {
  constructor(scene) {
    this.scene = scene;
    this.geo = new THREE.BoxGeometry(0.12, 0.12, 0.12);
    this.geoSmoke = new THREE.SphereGeometry(0.12, 6, 4);
    this.geoDrip = new THREE.SphereGeometry(0.06, 5, 4);
    this.lista = [];
    this.materiaisCache = new Map();
    this.ambientAcc = 0;
  }
  _matPara(corHex, transp = false) {
    const k = `${corHex}_${transp ? 1 : 0}`;
    let m = this.materiaisCache.get(k);
    if (!m) {
      m = new THREE.MeshBasicMaterial({
        color: corHex, transparent: transp, opacity: transp ? 0.55 : 1,
      });
      this.materiaisCache.set(k, m);
    }
    return m;
  }
  spawnQuebra(cx, cy, cz, blocoTipo) {
    const cor = BLOCO_INFO[blocoTipo]?.cor ?? 0x888888;
    const mat = this._matPara(cor);
    const n = 10 + Math.floor(Math.random() * 5);
    for (let i = 0; i < n; i++) {
      const m = new THREE.Mesh(this.geo, mat);
      m.position.set(
        cx + 0.5 + (Math.random() - 0.5) * 0.6,
        cy + 0.5 + (Math.random() - 0.5) * 0.6,
        cz + 0.5 + (Math.random() - 0.5) * 0.6,
      );
      m.userData = {
        vx: (Math.random() - 0.5) * 4.5,
        vy: 1.5 + Math.random() * 3.5,
        vz: (Math.random() - 0.5) * 4.5,
        life: 0.8 + Math.random() * 0.4,
        lifeMax: 1.0,
      };
      m.userData.lifeMax = m.userData.life;
      this.scene.add(m);
      this.lista.push(m);
    }
  }
  spawnSmoke(cx, cy, cz) {
    const mat = this._matPara(0xcccccc, true);
    const m = new THREE.Mesh(this.geoSmoke, mat);
    m.position.set(
      cx + 0.5 + (Math.random() - 0.5) * 0.3,
      cy + 1.05,
      cz + 0.5 + (Math.random() - 0.5) * 0.3,
    );
    m.userData = {
      vx: (Math.random() - 0.5) * 0.4,
      vy: 0.6 + Math.random() * 0.4,
      vz: (Math.random() - 0.5) * 0.4,
      life: 1.6 + Math.random() * 0.8,
      lifeMax: 2.0,
      isSmoke: true,
    };
    m.userData.lifeMax = m.userData.life;
    this.scene.add(m);
    this.lista.push(m);
  }
  spawnLavaSpark(cx, cy, cz) {
    const mat = this._matPara(0xFF6F00);
    const m = new THREE.Mesh(this.geoDrip, mat);
    m.position.set(
      cx + 0.5 + (Math.random() - 0.5) * 0.4,
      cy + 1.0,
      cz + 0.5 + (Math.random() - 0.5) * 0.4,
    );
    m.userData = {
      vx: (Math.random() - 0.5) * 0.6,
      vy: 1.5 + Math.random() * 0.8,
      vz: (Math.random() - 0.5) * 0.6,
      life: 1.0,
      lifeMax: 1.0,
      isSpark: true,
    };
    this.scene.add(m);
    this.lista.push(m);
  }
  emitirAmbient(world, player) {
    if (!world || !player) return;
    const px = Math.floor(player.pos.x), py = Math.floor(player.pos.y), pz = Math.floor(player.pos.z);
    for (let dx = -8; dx <= 8; dx++)
      for (let dy = -3; dy <= 3; dy++)
        for (let dz = -8; dz <= 8; dz++) {
          const x = px + dx, y = py + dy, z = pz + dz;
          const b = world.get(x, y, z);
          if (b === BLOCO.FORNALHA && Math.random() < 0.25) {
            const f = world.fornalhaEstados.get(World.keyXYZ(x, y, z));
            if (f && f.combustivel) this.spawnSmoke(x, y, z);
          }
          if (b === BLOCO.LAVA && Math.random() < 0.05) {
            if (world.get(x, y + 1, z) === BLOCO.AR) this.spawnLavaSpark(x, y, z);
          }
        }
  }
  atualizar(dt) {
    this.ambientAcc += dt;
    if (this.ambientAcc >= 0.4) {
      this.ambientAcc = 0;
      if (state.world && state.player) this.emitirAmbient(state.world, state.player);
    }
    // Cave drip ambient: subterrâneo (sem skylight) toca som esporádico
    // de gota d'água. Paridade Minecraft "cave ambience".
    this._caveAmbAcc = (this._caveAmbAcc || 0) + dt;
    if (this._caveAmbAcc > 6 + Math.random() * 14) {
      this._caveAmbAcc = 0;
      if (state.world && state.player) {
        const luz = state.world.getLightAt(
          Math.floor(state.player.pos.x),
          Math.floor(state.player.pos.y),
          Math.floor(state.player.pos.z));
        if (luz.sky < 4 && state.player.pos.y < 32) Audio.caveDrip();
      }
    }
    for (let i = this.lista.length - 1; i >= 0; i--) {
      const p = this.lista[i];
      const u = p.userData;
      p.position.x += u.vx * dt;
      p.position.y += u.vy * dt;
      p.position.z += u.vz * dt;
      if (u.isSmoke) {
        u.vx *= 0.95; u.vz *= 0.95; u.vy *= 0.95;
        const k = u.life / u.lifeMax;
        p.scale.setScalar(0.6 + (1 - k) * 1.2);
        p.material.opacity = 0.55 * k;
      } else if (u.isDrip || u.isSpark) {
        u.vy -= (u.isSpark ? 4 : 12) * dt;
        const k = u.life / u.lifeMax;
        p.scale.setScalar(0.7 + k * 0.5);
      } else {
        u.vy -= 14 * dt;
        u.vx *= 0.92; u.vz *= 0.92;
        const k = Math.max(0, u.life / u.lifeMax);
        p.scale.setScalar(0.6 + 0.5 * k);
      }
      u.life -= dt;
      if (u.life <= 0) {
        this.scene.remove(p);
        this.lista.splice(i, 1);
      }
    }
  }
}

// === Item drops voando ===
class ItemDrop {
  constructor(scene, drop, x, y, z) {
    this.scene = scene;
    this.drop = drop;
    this.x = x; this.y = y; this.z = z;
    this.vx = (Math.random() - 0.5) * 1.5;
    this.vy = 2.0 + Math.random() * 1.5;
    this.vz = (Math.random() - 0.5) * 1.5;
    this.life = 60.0;
    this.tempoColeta = 0.5;
    const cor = drop.b !== undefined ? (BLOCO_INFO[drop.b]?.cor ?? 0xcccccc) : 0xeeeeee;
    const geo = new THREE.BoxGeometry(0.28, 0.28, 0.28);
    const mat = new THREE.MeshLambertMaterial({ color: cor });
    this.mesh = new THREE.Mesh(geo, mat);
    this.mesh.position.set(x, y + 0.4, z);
    this.scene.add(this.mesh);
  }
  atualizar(dt, world, player) {
    this.life -= dt;
    this.tempoColeta -= dt;
    this.vy += GRAVIDADE * 0.5 * dt;
    this.vy = Math.max(this.vy, -8);
    this.x += this.vx * dt;
    this.y += this.vy * dt;
    this.z += this.vz * dt;
    this.vx *= 0.92;
    this.vz *= 0.92;
    if (this.y < 0.4) { this.y = 0.4; this.vy = 0; }
    let yChao = WORLD_Y;
    while (yChao > 0 && !world.isSolido(Math.floor(this.x), yChao - 1, Math.floor(this.z))) yChao--;
    if (this.y < yChao + 0.3) { this.y = yChao + 0.3; this.vy = 0; this.vx *= 0.6; this.vz *= 0.6; }
    this.mesh.position.set(this.x, this.y + Math.sin(this.life * 2) * 0.05, this.z);
    this.mesh.rotation.y += dt * 1.5;
    this.mesh.rotation.x += dt * 0.7;
    if (this.tempoColeta <= 0 && player && !player.morto) {
      const dx = this.x - player.pos.x;
      const dy = this.y - (player.pos.y + 0.5);
      const dz = this.z - player.pos.z;
      if (dx*dx + dy*dy + dz*dz < 2.25) {
        if (state.inv.adicionar({ ...this.drop })) {
          Audio.pickup();
          this.life = 0;
        }
      }
    }
  }
  destruir() {
    this.scene.remove(this.mesh);
    this.mesh.geometry.dispose();
    this.mesh.material.dispose();
  }
}

export function spawnItemDrop(drop, x, y, z) {
  if (!drop || drop.q <= 0) return;
  if (state.dropEntidades.length > 60) {
    const old = state.dropEntidades.shift();
    old.destruir();
  }
  const d = new ItemDrop(state.renderer.scene, drop, x, y, z);
  state.dropEntidades.push(d);
}
export function atualizarItemDrops(dt) {
  for (let i = state.dropEntidades.length - 1; i >= 0; i--) {
    const d = state.dropEntidades[i];
    d.atualizar(dt, state.world, state.player);
    if (d.life <= 0) {
      d.destruir();
      state.dropEntidades.splice(i, 1);
    }
  }
}

// === XP Orbs visíveis ===
class XPOrb {
  constructor(scene, valor, x, y, z) {
    this.scene = scene;
    this.valor = valor;
    this.x = x; this.y = y; this.z = z;
    this.vx = (Math.random() - 0.5) * 1.0;
    this.vy = 1.5 + Math.random() * 1.0;
    this.vz = (Math.random() - 0.5) * 1.0;
    this.life = 60.0;
    this.fase = Math.random() * Math.PI * 2;
    const geo = new THREE.SphereGeometry(0.18, 8, 6);
    const mat = new THREE.MeshBasicMaterial({ color: 0xb6f24a, transparent: true, opacity: 0.95 });
    this.mesh = new THREE.Mesh(geo, mat);
    this.mesh.position.set(x, y + 0.3, z);
    this.scene.add(this.mesh);
  }
  atualizar(dt, world, player, ganharXPFn) {
    this.life -= dt;
    this.fase += dt * 4;
    if (player && !player.morto) {
      const dx = player.pos.x - this.x;
      const dy = (player.pos.y + 0.5) - this.y;
      const dz = player.pos.z - this.z;
      const d2 = dx*dx + dy*dy + dz*dz;
      if (d2 < 25) {
        const d = Math.sqrt(d2);
        const k = 8.0 / Math.max(0.5, d);
        this.vx += dx * k * dt;
        this.vy += dy * k * dt;
        this.vz += dz * k * dt;
      }
      if (d2 < 0.64) {
        ganharXPFn(this.valor);
        Audio.xpOrb();
        this.life = 0;
        return;
      }
    }
    this.x += this.vx * dt;
    this.y += this.vy * dt;
    this.z += this.vz * dt;
    this.vy -= 6 * dt;
    this.vx *= 0.94;
    this.vz *= 0.94;
    let yChao = WORLD_Y;
    while (yChao > 0 && !world.isSolido(Math.floor(this.x), yChao - 1, Math.floor(this.z))) yChao--;
    if (this.y < yChao + 0.25) { this.y = yChao + 0.25; this.vy = 0; }
    this.mesh.position.set(this.x, this.y + Math.sin(this.fase) * 0.06, this.z);
  }
  destruir() {
    this.scene.remove(this.mesh);
    this.mesh.geometry.dispose();
    this.mesh.material.dispose();
  }
}

export function spawnXPOrb(valor, x, y, z) {
  if (!valor || valor <= 0 || !state.renderer) return;
  while (state.xpOrbs.length > 50) {
    const old = state.xpOrbs.shift();
    old.destruir();
  }
  const orb = new XPOrb(state.renderer.scene, valor, x, y, z);
  state.xpOrbs.push(orb);
}
export function atualizarXpOrbs(dt, ganharXPFn) {
  for (let i = state.xpOrbs.length - 1; i >= 0; i--) {
    const o = state.xpOrbs[i];
    o.atualizar(dt, state.world, state.player, ganharXPFn);
    if (o.life <= 0) {
      o.destruir();
      state.xpOrbs.splice(i, 1);
    }
  }
}

// =====================================================================
// Arrow — projétil de flecha (bow).
// Voa em linha reta com gravidade leve. Atinge mob no caminho.
// =====================================================================
class Arrow {
  constructor(scene, x, y, z, vx, vy, vz, dano) {
    this.scene = scene;
    this.x = x; this.y = y; this.z = z;
    this.vx = vx; this.vy = vy; this.vz = vz;
    this.dano = dano;
    this.life = 4.0; // viagem máx ~120m em 4s
    const geo = new THREE.BoxGeometry(0.08, 0.08, 0.5);
    const mat = new THREE.MeshLambertMaterial({ color: 0xa1887f });
    this.mesh = new THREE.Mesh(geo, mat);
    this.mesh.position.set(x, y, z);
    // Aponta na direção de voo
    this.mesh.lookAt(x + vx, y + vy, z + vz);
    this.scene.add(this.mesh);
  }
  atualizar(dt, world, mobMgr) {
    this.life -= dt;
    if (this.life <= 0) return false;
    this.x += this.vx * dt;
    this.y += this.vy * dt;
    this.z += this.vz * dt;
    this.vy -= 4 * dt; // gravidade leve (paridade Minecraft real)
    this.mesh.position.set(this.x, this.y, this.z);
    this.mesh.lookAt(this.x + this.vx, this.y + this.vy, this.z + this.vz);
    // Colisão com bloco sólido
    if (world.isSolido(Math.floor(this.x), Math.floor(this.y), Math.floor(this.z))) {
      Audio.flechaImpacto();
      return false;
    }
    // Colisão com mob (raio 0.7)
    if (mobMgr) {
      for (const m of mobMgr.mobs) {
        const ddx = m.x - this.x;
        const ddy = (m.y + 0.8) - this.y;
        const ddz = m.z - this.z;
        if (ddx*ddx + ddy*ddy + ddz*ddz < 0.5) {
          Audio.flechaImpacto();
          if (m.tipo === 'zumbi') Audio.zumbiHit(); else Audio.hit();
          // Knockback velocity = direção da flecha × fator
          const len = Math.hypot(this.vx, this.vz) || 1;
          m.tomarDano(this.dano, (this.vx/len) * 5, (this.vz/len) * 5);
          if (state.ui) state.ui.toast(`Acertou ${m.tipo} -${this.dano} 🏹`);
          return false;
        }
      }
    }
    return true;
  }
  destruir() {
    this.scene.remove(this.mesh);
    this.mesh.geometry.dispose();
    this.mesh.material.dispose();
  }
}

if (typeof window !== 'undefined') window._arrows = window._arrows || [];

export function spawnArrow(origem, dir, dano = 4) {
  if (!state.renderer) return;
  // Velocidade base 28 blocos/s na direção da câmera
  const vel = 28;
  const vx = dir.x * vel, vy = dir.y * vel, vz = dir.z * vel;
  // Spawn um pouco à frente da câmera para não atingir o player
  const a = new Arrow(state.renderer.scene,
    origem.x + dir.x * 0.6, origem.y + dir.y * 0.6 - 0.1, origem.z + dir.z * 0.6,
    vx, vy, vz, dano);
  window._arrows.push(a);
  Audio.flechaSolta();
}

export function atualizarArrows(dt) {
  if (!state.world || !state.mobMgr) return;
  for (let i = window._arrows.length - 1; i >= 0; i--) {
    const a = window._arrows[i];
    if (!a.atualizar(dt, state.world, state.mobMgr)) {
      a.destruir();
      window._arrows.splice(i, 1);
    }
  }
}

// === Ambient triggers (cave drip, vento) ===
export function atualizarAmbientTriggers(dt) {
  if (!state.player || !state.world) return;
  state.ambientAcc += dt;
  if (state.ambientAcc < 7.0) return;
  state.ambientAcc = 0;
  if (Math.random() > 0.35) return;
  const px = Math.floor(state.player.pos.x), py = Math.floor(state.player.pos.y), pz = Math.floor(state.player.pos.z);
  const luz = state.world.getLightAt(px, py, pz);
  if (luz.sky === 0 && py > 4) {
    if (Math.random() < 0.5) Audio.caveDrip();
    else Audio.caveAmbient();
    return;
  }
  if (luz.sky >= 12 && py >= 18) Audio.vento();
}
