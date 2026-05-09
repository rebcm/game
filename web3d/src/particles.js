// =====================================================================
// particles.js — Partículas, item drops, XP orbs, ambient triggers
// =====================================================================

import * as THREE from 'three';
import { BLOCO, BLOCO_INFO, GRAVIDADE, WORLD_Y, ITEM } from './constants.js';
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
    this.partes = []; // SPRINT VISUAL-6: leaf/snow/pollen/spark
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
  // Poeira de sprint: pequenas partículas marrons atrás dos pés ao correr.
  // Spawnadas em batch pelo main loop.
  spawnSprintDust(x, y, z) {
    const mat = this._matPara(0xa07442);
    const m = new THREE.Mesh(this.geoDrip, mat);
    m.position.set(x + (Math.random()-0.5)*0.3, y + 0.05, z + (Math.random()-0.5)*0.3);
    m.userData = {
      vx: (Math.random()-0.5) * 0.6,
      vy: 0.4 + Math.random() * 0.5,
      vz: (Math.random()-0.5) * 0.6,
      life: 0.45,
      lifeMax: 0.45,
      isSpark: true,
    };
    this.scene.add(m);
    this.lista.push(m);
  }
  // Estrelas de crítico: 5-7 partículas amarelas explosivas em mob hit.
  spawnCritStars(cx, cy, cz) {
    for (let i = 0; i < 7; i++) {
      const ang = (i / 7) * Math.PI * 2;
      const mat = this._matPara(0xFFEB3B);
      const m = new THREE.Mesh(this.geoDrip, mat);
      m.position.set(cx, cy, cz);
      m.scale.setScalar(1.4);
      m.userData = {
        vx: Math.cos(ang) * (1.5 + Math.random()),
        vy: 0.8 + Math.random() * 1.2,
        vz: Math.sin(ang) * (1.5 + Math.random()),
        life: 0.7,
        lifeMax: 0.7,
        isSpark: true,
      };
      this.scene.add(m);
      this.lista.push(m);
    }
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
  // SPRINT VISUAL-6: Particles ambientes premium
  // Pétala caindo de árvore (cherry leaves)
  spawnLeafFalling(cx, cy, cz, cor = 0x66bb6a) {
    if (!this.scene) return;
    // Cap pra evitar overload
    if (this.partes && this.partes.length > 100) return;
    const geo = new THREE.PlaneGeometry(0.10, 0.10);
    const mat = new THREE.MeshBasicMaterial({ color: cor, transparent: true, opacity: 0.85, side: THREE.DoubleSide });
    const mesh = new THREE.Mesh(geo, mat);
    mesh.position.set(cx + Math.random() * 0.5, cy, cz + Math.random() * 0.5);
    mesh.rotation.set(Math.random() * Math.PI, Math.random() * Math.PI, 0);
    state.scene.add(mesh);
    this.partes.push({
      mesh, life: 8, maxLife: 8,
      vx: (Math.random() - 0.5) * 0.3,
      vy: -0.4 + Math.random() * 0.2,
      vz: (Math.random() - 0.5) * 0.3,
      rotZ: (Math.random() - 0.5) * 2,
      type: 'leaf',
    });
  }
  // Floco de neve caindo
  spawnSnowflake(cx, cy, cz) {
    if (!this.scene) return;
    const geo = new THREE.PlaneGeometry(0.06, 0.06);
    const mat = new THREE.MeshBasicMaterial({ color: 0xffffff, transparent: true, opacity: 0.95, side: THREE.DoubleSide });
    const mesh = new THREE.Mesh(geo, mat);
    mesh.position.set(cx + Math.random() * 0.5, cy, cz + Math.random() * 0.5);
    state.scene.add(mesh);
    this.partes.push({
      mesh, life: 5, maxLife: 5,
      vx: Math.sin(Date.now() / 1000) * 0.15,
      vy: -0.3,
      vz: Math.cos(Date.now() / 1000) * 0.15,
      type: 'snow',
    });
  }
  // Pollen de bee (amarelo brilhante)
  spawnPollen(cx, cy, cz) {
    if (!this.scene) return;
    const geo = new THREE.PlaneGeometry(0.05, 0.05);
    const mat = new THREE.MeshBasicMaterial({ color: 0xffeb3b, transparent: true, opacity: 0.9, side: THREE.DoubleSide });
    const mesh = new THREE.Mesh(geo, mat);
    mesh.position.set(cx, cy, cz);
    state.scene.add(mesh);
    this.partes.push({
      mesh, life: 3, maxLife: 3,
      vx: (Math.random() - 0.5) * 0.4,
      vy: (Math.random() - 0.5) * 0.3,
      vz: (Math.random() - 0.5) * 0.4,
      type: 'pollen',
    });
  }
  // Faíscas premium para tochas (laranja brilhante)
  spawnTorchSpark(cx, cy, cz) {
    if (!this.scene) return;
    const geo = new THREE.SphereGeometry(0.025, 4, 3);
    const mat = new THREE.MeshBasicMaterial({ color: 0xffaa00, transparent: true, opacity: 1.0 });
    const mesh = new THREE.Mesh(geo, mat);
    mesh.position.set(cx + 0.5, cy + 0.6, cz + 0.5);
    state.scene.add(mesh);
    this.partes.push({
      mesh, life: 1.0, maxLife: 1.0,
      vx: (Math.random() - 0.5) * 0.2,
      vy: 0.8 + Math.random() * 0.3,
      vz: (Math.random() - 0.5) * 0.2,
      type: 'spark',
    });
  }
  emitirAmbient(world, player) {
    if (!world || !player) return;
    const px = Math.floor(player.pos.x), py = Math.floor(player.pos.y), pz = Math.floor(player.pos.z);
    // _temChunk evita auto-gerar chunks só pra ambient — economia de
    // performance enorme em explorações de longa distância.
    const _temChunk = (x, z) => world.hasChunk(Math.floor(x / 16), Math.floor(z / 16));
    for (let dx = -6; dx <= 6; dx++)
      for (let dy = -3; dy <= 3; dy++)
        for (let dz = -6; dz <= 6; dz++) {
          const x = px + dx, y = py + dy, z = pz + dz;
          if (!_temChunk(x, z)) continue;
          const b = world.get(x, y, z);
          if (b === BLOCO.FORNALHA && Math.random() < 0.25) {
            const f = world.fornalhaEstados.get(World.keyXYZ(x, y, z));
            if (f && f.combustivel) this.spawnSmoke(x, y, z);
          }
          // SPRINT VISUAL-6: pétalas caindo de cherry leaves
          if (b === BLOCO.CHERRY_FOLHA && Math.random() < 0.005 && world.get(x, y - 1, z) === BLOCO.AR) {
            this.spawnLeafFalling(x, y - 0.2, z, 0xf48fb1);
          }
          // Folhas verdes ocasionais
          if ((b === BLOCO.FOLHA || b === BLOCO.JUNGLE_FOLHA) && Math.random() < 0.002 && world.get(x, y - 1, z) === BLOCO.AR) {
            this.spawnLeafFalling(x, y - 0.2, z, 0x66bb6a);
          }
          // Faíscas em tochas
          if (b === BLOCO.TOCHA && Math.random() < 0.10) {
            this.spawnTorchSpark(x, y, z);
          }
          if (b === BLOCO.LAVA) {
            if (Math.random() < 0.05 && world.get(x, y + 1, z) === BLOCO.AR) this.spawnLavaSpark(x, y, z);
            // Queima madeira/folha: chance reduzida pra evitar chunk thrashing.
            // Era 4% por bloco LAVA por tick = mesh rebuild constante.
            if (Math.random() < 0.008) {
              const dirs = [[1,0,0],[-1,0,0],[0,1,0],[0,-1,0],[0,0,1],[0,0,-1]];
              for (const [ax,ay,az] of dirs) {
                const vx = x+ax, vy = y+ay, vz = z+az;
                const vb = world.get(vx, vy, vz);
                if (vb === BLOCO.MADEIRA || vb === BLOCO.FOLHA) {
                  world.set(vx, vy, vz, BLOCO.AR);
                  this.spawnSmoke(vx, vy, vz);
                  if (vb === BLOCO.MADEIRA) {
                    spawnItemDrop({ i: ITEM.CARVAO, q: 1 }, vx + 0.5, vy + 0.2, vz + 0.5);
                  }
                  break;
                }
              }
            }
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
    // SPRINT VISUAL-6: tick partes premium (leaf, snow, pollen, spark)
    if (this.partes && this.partes.length) {
      for (let i = this.partes.length - 1; i >= 0; i--) {
        const p = this.partes[i];
        if (!p.mesh) { this.partes.splice(i, 1); continue; }
        // Físicas por tipo
        if (p.type === 'leaf') {
          // Pétala caindo: drift sinusoidal + rotação
          p.vx = Math.sin(p.life * 2) * 0.3;
          p.vz = Math.cos(p.life * 1.5) * 0.3;
          p.mesh.rotation.z += (p.rotZ || 1) * dt;
          p.mesh.rotation.y += dt;
        } else if (p.type === 'snow') {
          // Floco: drift mais lento
          p.vx = Math.sin(p.life * 0.5) * 0.2;
        } else if (p.type === 'pollen') {
          // Polen: zig-zag
          p.vx += (Math.random() - 0.5) * 0.5 * dt;
          p.vz += (Math.random() - 0.5) * 0.5 * dt;
          p.vy += (Math.random() - 0.5) * 0.2 * dt;
        } else if (p.type === 'spark') {
          // Faisca: gravidade + slowdown
          p.vy -= 4 * dt;
          p.vx *= 0.92; p.vz *= 0.92;
        }
        p.mesh.position.x += p.vx * dt;
        p.mesh.position.y += p.vy * dt;
        p.mesh.position.z += p.vz * dt;
        // Fade out
        const k = p.life / p.maxLife;
        if (p.mesh.material) p.mesh.material.opacity = 0.95 * k;
        p.life -= dt;
        if (p.life <= 0) {
          if (this.scene && p.mesh.parent === this.scene) this.scene.remove(p.mesh);
          else if (state.scene) state.scene.remove(p.mesh);
          this.partes.splice(i, 1);
        }
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
    this.tempoColeta = 0.25; // antes 0.5s — coleta mais responsiva
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
      // Raio 2.5 (antes 1.5) — pickup mais generoso, evita perder
      // drops por causa de movimento ou drop caindo em buraco vizinho.
      if (dx*dx + dy*dy + dz*dz < 6.25) {
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

// =====================================================================
// FishingBobber — bóia de pesca lançada pela vara.
// Voa em arco, cai por gravidade até pousar em água ou bloco sólido.
// Estados: 'voando' → 'na_agua' (espera bite) → 'mordeu' (janela curta).
// =====================================================================
export class FishingBobber {
  constructor(scene, x, y, z, vx, vy, vz) {
    this.scene = scene;
    this.x = x; this.y = y; this.z = z;
    this.vx = vx; this.vy = vy; this.vz = vz;
    this.estado = 'voando';
    this.timerBite = 4 + Math.random() * 8; // 4-12s pra peixe morder
    this.janelaBite = 0; // segundos restantes na janela "mordeu"
    this.life = 60;
    this.naoEhAgua = false; // pousou em chão sólido (sem peixe possível)
    // Visual: bóia branca/vermelha (estilo MC)
    const grupo = new THREE.Group();
    const top = new THREE.Mesh(
      new THREE.BoxGeometry(0.18, 0.10, 0.18),
      new THREE.MeshBasicMaterial({ color: 0xe53935 }),
    );
    top.position.y = 0.05;
    const bot = new THREE.Mesh(
      new THREE.BoxGeometry(0.18, 0.10, 0.18),
      new THREE.MeshBasicMaterial({ color: 0xfafafa }),
    );
    bot.position.y = -0.05;
    grupo.add(top); grupo.add(bot);
    grupo.position.set(x, y, z);
    this.mesh = grupo;
    this.scene.add(grupo);
  }
  atualizar(dt, world) {
    this.life -= dt;
    if (this.life <= 0) return false;
    if (this.estado === 'voando') {
      this.x += this.vx * dt;
      this.y += this.vy * dt;
      this.z += this.vz * dt;
      this.vy -= 12 * dt; // gravidade
      // Pousou em água?
      const fxi = Math.floor(this.x), fyi = Math.floor(this.y), fzi = Math.floor(this.z);
      const b = world.get(fxi, fyi, fzi);
      if (b === BLOCO.AGUA) {
        // Snap pra superfície (bóia flutua)
        this.estado = 'na_agua';
        this.vx = 0; this.vy = 0; this.vz = 0;
        this.y = fyi + 0.95;
        Audio.splash?.();
      } else if (BLOCO_INFO[b]?.solido && b !== BLOCO.AR) {
        // Pousou em chão sólido — sem peixe, fica parado e fade
        this.estado = 'na_agua'; // reusa estado pra render igual
        this.naoEhAgua = true;
        this.vx = 0; this.vy = 0; this.vz = 0;
        this.timerBite = 999;
      }
    } else if (this.estado === 'na_agua') {
      // Bobbing visual (sobe/desce levemente sobre a água)
      const t = (60 - this.life) * 2;
      this.mesh.position.y = this.y + Math.sin(t) * 0.05;
      if (this.naoEhAgua) return true;
      this.timerBite -= dt;
      if (this.timerBite <= 0) {
        this.estado = 'mordeu';
        this.janelaBite = 1.4; // 1.4s pra reagir
        Audio.splash?.();
        if (state.ui?.toast) state.ui.toast('🐟 Algo mordeu! Clique pra puxar!');
        // Anima bobber afundando
        this.mesh.position.y = this.y - 0.25;
      }
    } else if (this.estado === 'mordeu') {
      this.janelaBite -= dt;
      // Bobbing rápido (algo puxando)
      const t = (60 - this.life) * 12;
      this.mesh.position.y = this.y - 0.25 + Math.sin(t) * 0.10;
      if (this.janelaBite <= 0) {
        // Fugiu — bobber volta a flutuar, novo timer
        this.estado = 'na_agua';
        this.timerBite = 4 + Math.random() * 6;
        this.mesh.position.y = this.y;
        if (state.ui?.toast) state.ui.toast('Peixe escapou…');
      }
    }
    if (this.estado === 'voando') {
      this.mesh.position.set(this.x, this.y, this.z);
    } else {
      this.mesh.position.x = this.x;
      this.mesh.position.z = this.z;
    }
    return true;
  }
  reel() {
    // Chamado quando player clica de novo. Retorna o item pescado ou null.
    if (this.naoEhAgua) return null;
    if (this.estado !== 'mordeu') return null;
    const r = Math.random();
    // Pesos: 50% PEIXE, 20% SALMAO, 13% OSSO, 10% PAU, 4% MUDA, 3% ESMERALDA
    if (r < 0.50) return { i: ITEM.PEIXE, q: 1 };
    if (r < 0.70) return { i: ITEM.SALMAO, q: 1 };
    if (r < 0.83) return { i: ITEM.OSSO, q: 1 };
    if (r < 0.93) return { i: ITEM.PAU, q: 1 };
    if (r < 0.97) return { i: ITEM.MUDA, q: 1 };
    return { i: ITEM.ESMERALDA, q: 1 };
  }
  destruir() {
    this.scene.remove(this.mesh);
    for (const c of this.mesh.children) {
      c.geometry.dispose();
      c.material.dispose();
    }
  }
}

// =====================================================================
// Firework — foguete que sobe ~10 blocos e explode em estrelas coloridas.
// Estados: 'subindo' (mesh + trail) → 'explodindo' (N partículas radiais).
// =====================================================================
const _CORES_FOGOS = [
  0xff5252, 0xffeb3b, 0x69f0ae, 0x40c4ff, 0xe040fb, 0xff9100, 0xfff176,
];
class Firework {
  constructor(scene, x, y, z, dirX, dirY, dirZ) {
    this.scene = scene;
    this.x = x; this.y = y; this.z = z;
    // Velocidade: principalmente vertical com leve direção da câmera
    this.vx = dirX * 2;
    this.vy = 18 + dirY * 4;
    this.vz = dirZ * 2;
    this.estado = 'subindo';
    this.timer = 1.0 + Math.random() * 0.4; // explode após ~1.0-1.4s
    this.cor = _CORES_FOGOS[Math.floor(Math.random() * _CORES_FOGOS.length)];
    this.cor2 = _CORES_FOGOS[Math.floor(Math.random() * _CORES_FOGOS.length)];
    // Foguete corpo (cilindro pequeno colorido)
    this.mesh = new THREE.Mesh(
      new THREE.BoxGeometry(0.10, 0.32, 0.10),
      new THREE.MeshBasicMaterial({ color: this.cor }),
    );
    this.mesh.position.set(x, y, z);
    this.scene.add(this.mesh);
    // Partículas da explosão (criadas só no boom)
    this.bits = [];
    this.bitsLife = 0;
  }
  atualizar(dt) {
    if (this.estado === 'subindo') {
      this.x += this.vx * dt;
      this.y += this.vy * dt;
      this.z += this.vz * dt;
      this.vy -= 6 * dt; // arrasto leve
      this.mesh.position.set(this.x, this.y, this.z);
      // Spark trail (fumaça atrás)
      if (Math.random() < 0.5 && state.particulas?.spawnSmoke) {
        state.particulas.spawnSmoke(this.x, this.y - 0.2, this.z);
      }
      this.timer -= dt;
      if (this.timer <= 0) {
        this._explodir();
        Audio.flechaImpacto?.();
      }
    } else if (this.estado === 'explodindo') {
      this.bitsLife += dt;
      // Atualiza posição das estrelas
      for (const b of this.bits) {
        b.x += b.vx * dt;
        b.y += b.vy * dt;
        b.z += b.vz * dt;
        b.vy -= 4 * dt; // gravidade leve
        b.mesh.position.set(b.x, b.y, b.z);
        b.mesh.material.opacity = Math.max(0, 1 - this.bitsLife / 1.6);
      }
      if (this.bitsLife > 1.6) return false;
    }
    return true;
  }
  _explodir() {
    this.estado = 'explodindo';
    // Remove o foguete corpo
    this.scene.remove(this.mesh);
    this.mesh.geometry.dispose();
    this.mesh.material.dispose();
    // Spawn 24 estrelas coloridas em direções esféricas
    const N = 24;
    const geo = new THREE.SphereGeometry(0.14, 5, 4);
    for (let i = 0; i < N; i++) {
      const ang = (i / N) * Math.PI * 2;
      const phi = (Math.random() - 0.5) * Math.PI;
      const vel = 5 + Math.random() * 3;
      const vx = Math.cos(ang) * Math.cos(phi) * vel;
      const vy = Math.sin(phi) * vel + 0.5;
      const vz = Math.sin(ang) * Math.cos(phi) * vel;
      const cor = i % 2 === 0 ? this.cor : this.cor2;
      const mat = new THREE.MeshBasicMaterial({ color: cor, transparent: true, opacity: 1 });
      const m = new THREE.Mesh(geo, mat);
      m.position.set(this.x, this.y, this.z);
      this.scene.add(m);
      this.bits.push({ x: this.x, y: this.y, z: this.z, vx, vy, vz, mesh: m });
    }
  }
  destruir() {
    if (this.estado === 'subindo') {
      this.scene.remove(this.mesh);
      this.mesh.geometry.dispose();
      this.mesh.material.dispose();
    }
    for (const b of this.bits) {
      this.scene.remove(b.mesh);
      b.mesh.material.dispose();
    }
  }
}

// =====================================================================
// Trident — projétil arremessável que volta automaticamente ao player.
// Estados: 'lancado' (voa em arco) → 'cravado' (parado em mob/bloco) → 'voltando'.
// Quando alcança o player (raio 1.5), reabsorve no inventário.
// =====================================================================
class Trident {
  constructor(scene, x, y, z, vx, vy, vz, dano = 8) {
    this.scene = scene;
    this.x = x; this.y = y; this.z = z;
    this.vx = vx; this.vy = vy; this.vz = vz;
    this.dano = dano;
    this.estado = 'lancado';
    this.life = 4.5;
    this.cooldownVolta = 0;
    // Visual: 3 pontas cinza-claro + cabo dourado
    const grupo = new THREE.Group();
    const matAco  = new THREE.MeshLambertMaterial({ color: 0xb0bec5 });
    const matCabo = new THREE.MeshLambertMaterial({ color: 0xffb300 });
    // Cabo (longa barra dourada)
    const cabo = new THREE.Mesh(new THREE.BoxGeometry(0.06, 0.06, 0.55), matCabo);
    cabo.position.z = -0.15;
    grupo.add(cabo);
    // Base do tridente (transversal)
    const base = new THREE.Mesh(new THREE.BoxGeometry(0.30, 0.06, 0.06), matAco);
    base.position.z = 0.18;
    grupo.add(base);
    // 3 pontas paralelas (esquerda, centro, direita)
    for (const dx of [-0.12, 0, 0.12]) {
      const ponta = new THREE.Mesh(new THREE.BoxGeometry(0.05, 0.05, 0.20), matAco);
      ponta.position.set(dx, 0, 0.32);
      grupo.add(ponta);
    }
    grupo.position.set(x, y, z);
    grupo.lookAt(x + vx, y + vy, z + vz);
    this.mesh = grupo;
    this.scene.add(grupo);
  }
  atualizar(dt, world, mobMgr, player) {
    this.life -= dt;
    if (this.life <= 0) return false;
    if (this.estado === 'lancado') {
      this.x += this.vx * dt;
      this.y += this.vy * dt;
      this.z += this.vz * dt;
      this.vy -= 6 * dt; // gravidade leve
      this.mesh.position.set(this.x, this.y, this.z);
      this.mesh.lookAt(this.x + this.vx, this.y + this.vy, this.z + this.vz);
      // Bloco sólido?
      if (world.isSolido(Math.floor(this.x), Math.floor(this.y), Math.floor(this.z))) {
        this._cravar();
        return true;
      }
      // Mob?
      if (mobMgr) {
        for (const m of mobMgr.mobs) {
          const ddx = m.x - this.x;
          const ddy = (m.y + 0.8) - this.y;
          const ddz = m.z - this.z;
          if (ddx*ddx + ddy*ddy + ddz*ddz < 0.6) {
            Audio.flechaImpacto?.();
            const len = Math.hypot(this.vx, this.vz) || 1;
            m.tomarDano(this.dano, (this.vx/len) * 7, (this.vz/len) * 7);
            if (state.ui) state.ui.toast(`🔱 Tridente em ${m.tipo} -${this.dano}`);
            this._cravar();
            return true;
          }
        }
      }
    } else if (this.estado === 'cravado') {
      this.cooldownVolta -= dt;
      if (this.cooldownVolta <= 0) this.estado = 'voltando';
    } else if (this.estado === 'voltando') {
      // Voa direto ao player (loyalty enchantment)
      const dx = player.pos.x - this.x;
      const dy = (player.pos.y + 0.5) - this.y;
      const dz = player.pos.z - this.z;
      const dist = Math.hypot(dx, dy, dz) || 1;
      const VEL = 28;
      this.vx = (dx / dist) * VEL;
      this.vy = (dy / dist) * VEL;
      this.vz = (dz / dist) * VEL;
      this.x += this.vx * dt;
      this.y += this.vy * dt;
      this.z += this.vz * dt;
      this.mesh.position.set(this.x, this.y, this.z);
      this.mesh.lookAt(this.x + this.vx, this.y + this.vy, this.z + this.vz);
      if (dist < 1.5) {
        // Reabsorvido: volta ao inventário
        state.inv?.adicionar?.({ i: ITEM.TRIDENTE, q: 1 });
        Audio.colocar?.();
        if (state.ui) state.ui.toast('🔱 Tridente recuperado');
        return false;
      }
    }
    return true;
  }
  _cravar() {
    this.estado = 'cravado';
    this.cooldownVolta = 0.4; // breve pausa antes de voltar
    this.vx = this.vy = this.vz = 0;
  }
  destruir() {
    this.scene.remove(this.mesh);
    for (const c of this.mesh.children) {
      c.geometry.dispose();
      c.material.dispose();
    }
  }
}

if (typeof window !== 'undefined') window._tridents = window._tridents || [];

export function lancarTridente(origem, dir) {
  if (!state.renderer) return;
  const vel = 32;
  const t = new Trident(state.renderer.scene,
    origem.x + dir.x * 0.5, origem.y - 0.1, origem.z + dir.z * 0.5,
    dir.x * vel, dir.y * vel, dir.z * vel);
  window._tridents.push(t);
  Audio.flechaSolta?.();
}

export function atualizarTridents(dt) {
  if (!state.world || !state.mobMgr || !state.player) return;
  for (let i = window._tridents.length - 1; i >= 0; i--) {
    const t = window._tridents[i];
    if (!t.atualizar(dt, state.world, state.mobMgr, state.player)) {
      t.destruir();
      window._tridents.splice(i, 1);
    }
  }
}

if (typeof window !== 'undefined') window._fireworks = window._fireworks || [];

export function lancarFoguete(origem, dir) {
  if (!state.renderer) return;
  const f = new Firework(state.renderer.scene,
    origem.x + dir.x * 0.4, origem.y - 0.2, origem.z + dir.z * 0.4,
    dir.x, dir.y, dir.z);
  window._fireworks.push(f);
  Audio.colocar?.();
}

export function atualizarFireworks(dt) {
  for (let i = window._fireworks.length - 1; i >= 0; i--) {
    const f = window._fireworks[i];
    if (!f.atualizar(dt)) {
      f.destruir();
      window._fireworks.splice(i, 1);
    }
  }
}

// Spawna ou recolhe bobber. Estado global em state._fishingBobber.
export function castFishingLine(origem, dir) {
  if (!state.renderer) return;
  // Se já existe bobber, click recolhe (reel ou cancela)
  if (state._fishingBobber) {
    const b = state._fishingBobber;
    const pescado = b.reel();
    b.destruir();
    state._fishingBobber = null;
    if (pescado) {
      state.inv?.adicionar?.(pescado);
      Audio.colocar?.();
      const nome = pescado.i === ITEM.SALMAO ? 'Salmão 🐟'
        : pescado.i === ITEM.PEIXE ? 'Peixe 🐟'
        : pescado.i === ITEM.OSSO ? 'Osso 🦴'
        : pescado.i === ITEM.PAU ? 'Pau'
        : pescado.i === ITEM.MUDA ? 'Muda 🌱'
        : pescado.i === ITEM.ESMERALDA ? 'Esmeralda 💚'
        : 'Item';
      state.ui?.toast?.(`🎣 Pescou ${nome}!`);
    } else {
      state.ui?.toast?.('Linha recolhida');
    }
    return;
  }
  // Lança nova bóia: arco de ~3 blocos à frente
  const vel = 14;
  const vx = dir.x * vel, vy = dir.y * vel + 4, vz = dir.z * vel;
  const b = new FishingBobber(state.renderer.scene,
    origem.x + dir.x * 0.6, origem.y - 0.1, origem.z + dir.z * 0.6,
    vx, vy, vz);
  state._fishingBobber = b;
  Audio.splash?.();
}

export function atualizarFishingBobber(dt) {
  if (!state._fishingBobber || !state.world) return;
  if (!state._fishingBobber.atualizar(dt, state.world)) {
    state._fishingBobber.destruir();
    state._fishingBobber = null;
  }
}

export function spawnArrow(origem, dir, dano = 4, vel = 28) {
  if (!state.renderer) return;
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

// =====================================================================
// Ambient bioma particles — folhas, neve, poeira, pólen
// Spawnam ao redor do player conforme bioma + cair com gravidade leve.
// =====================================================================
const _AMBIENT_PARTICLES = [];
function _spawnAmbientParticle(scene, x, y, z, cor, tamanho, dur, vy = -0.4) {
  if (_AMBIENT_PARTICLES.length > 80) return; // cap pra não estourar
  const geo = new THREE.PlaneGeometry(tamanho, tamanho);
  const mat = new THREE.MeshBasicMaterial({
    color: cor,
    transparent: true,
    opacity: 0.85,
    depthWrite: false,
    side: THREE.DoubleSide,
  });
  const m = new THREE.Mesh(geo, mat);
  m.position.set(x, y, z);
  m.rotation.z = Math.random() * Math.PI;
  scene.add(m);
  _AMBIENT_PARTICLES.push({
    mesh: m,
    vx: (Math.random() - 0.5) * 0.6,
    vy,
    vz: (Math.random() - 0.5) * 0.6,
    dur,
    age: 0,
    spin: (Math.random() - 0.5) * 1.2,
  });
}
function _atualizarAmbientParticles(dt) {
  if (!state.renderer) return;
  for (let i = _AMBIENT_PARTICLES.length - 1; i >= 0; i--) {
    const p = _AMBIENT_PARTICLES[i];
    p.age += dt;
    if (p.age >= p.dur) {
      state.renderer.scene.remove(p.mesh);
      p.mesh.geometry.dispose();
      p.mesh.material.dispose();
      _AMBIENT_PARTICLES.splice(i, 1);
      continue;
    }
    p.mesh.position.x += p.vx * dt;
    p.mesh.position.y += p.vy * dt;
    p.mesh.position.z += p.vz * dt;
    p.mesh.rotation.z += p.spin * dt;
    // Fade no último 30% da vida
    const r = p.age / p.dur;
    p.mesh.material.opacity = r < 0.7 ? 0.85 : 0.85 * (1 - (r - 0.7) / 0.3);
    // Faz a partícula sempre encarar a câmera (billboard)
    if (state.renderer.camera) p.mesh.lookAt(state.renderer.camera.position);
  }
}
let _biomaAcc = 0;
export function atualizarAmbientBioma(dt) {
  if (!state.player || !state.world || !state.renderer) return;
  _atualizarAmbientParticles(dt);
  _biomaAcc += dt;
  if (_biomaAcc < 0.40) return;
  _biomaAcc = 0;
  // Skip em condições de baixa visibilidade ou frame pesado
  if (state._heavyFrame) return;
  // Skip em tier baixo (mobile fraco) — partículas ambiente são luxo
  if (state.quality?.tier === 'low') return;
  // Só spawn se player está fora (céu visível) — não dentro de caverna
  const px = Math.floor(state.player.pos.x);
  const py = Math.floor(state.player.pos.y);
  const pz = Math.floor(state.player.pos.z);
  const luz = state.world.getLightAt(px, py, pz);
  if (luz.sky < 8) return; // dentro/embaixo: skip
  const bioma = state.world.biomaEm?.(px, pz);
  if (!bioma) return;
  // Posição aleatória ao redor do player (raio 12, altura 4-12 acima)
  const ang = Math.random() * Math.PI * 2;
  const dist = 4 + Math.random() * 8;
  const x = state.player.pos.x + Math.cos(ang) * dist;
  const z = state.player.pos.z + Math.sin(ang) * dist;
  const y = state.player.pos.y + 4 + Math.random() * 8;
  const scene = state.renderer.scene;
  if (bioma === 'floresta') {
    // Folhas verdes caindo (3 tons aleatórios)
    const cores = [0x4caf50, 0x8bc34a, 0x66bb6a];
    _spawnAmbientParticle(scene, x, y, z, cores[Math.floor(Math.random()*cores.length)],
      0.18, 5.0, -0.6);
  } else if (bioma === 'taiga') {
    // Neve caindo (branco azulado, mais lenta)
    _spawnAmbientParticle(scene, x, y, z, 0xeceff1, 0.10, 6.5, -0.45);
  } else if (bioma === 'deserto') {
    // Poeira amarela flutuante (sobe levemente, drift horizontal forte)
    _spawnAmbientParticle(scene, x, y, z, 0xffd54f, 0.08, 3.5, -0.1);
  } else if (bioma === 'planicies') {
    // Pólen dourado flutuando (raro, dourado)
    if (Math.random() < 0.35) {
      _spawnAmbientParticle(scene, x, y, z, 0xffeb3b, 0.06, 7.0, -0.15);
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
