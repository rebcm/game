// =====================================================================
// player.js — Player: input, física AABB, swim, sneak, fome/ar/HP
// =====================================================================

import * as THREE from 'three';
import {
  PLAYER_HEIGHT, PLAYER_RADIUS, GRAVIDADE, VEL_TERM, PULO_VEL,
  VEL_ANDAR, VEL_SPRINT, VEL_SNEAK, VEL_AR, BLOCO, BLOCO_INFO,
} from './constants.js';
import { clamp, materialDeBloco } from './utils.js';
import { Audio } from './audio.js';
import { state } from './state.js';
import { spawnItemDrop } from './particles.js';

const _tmpVecFwd   = new THREE.Vector3();
const _tmpVecRight = new THREE.Vector3();
const _yAxis       = new THREE.Vector3(0, 1, 0);

export class Player {
  constructor(camera) {
    this.pos = new THREE.Vector3(8, 30, 8);
    this.vel = new THREE.Vector3();
    this.noChao = false;
    this.modo = 'creative';
    this.terceiraPessoa = false;
    this.hp = 20; this.hpMax = 20;
    this.fome = 20; this.fomeMax = 20;
    this.saturation = 5.0;
    this.ar = 20; this.arMax = 20;
    this.accAr = 0;
    this.xp = 0; this.nivel = 0;
    this.morto = false;
    this.causaMorte = '';
    this.spawn = this.pos.clone();
    this.semDano = 99;
    this.accFome = 0;
    this.accRegen = 0;
    this.accDanoTerreno = 0;
    this.sneak = false;
    this.submerso = false;
    this.foiSubmerso = false;
    this.pausado = false;

    this.camera = camera;
    this.controls = null;

    this.input = { fwd: 0, side: 0, up: 0, sprint: false, jump: false };
    this.cliqueE = false; this.cliqueD = false; this.holdE = false;
    this.progressoQuebra = 0;
    this.alvoQuebra = null;
    this.distAndada = 0;
    this.materialPasso = 'grama';
  }

  atualizar(dt, world) {
    if (this.morto || this.pausado) return;
    // Direção da câmera (apenas horizontal)
    const fwd = _tmpVecFwd.set(0, 0, 0);
    this.camera.getWorldDirection(fwd);
    fwd.y = 0;
    if (fwd.lengthSq() > 1e-6) fwd.normalize();
    const right = _tmpVecRight.crossVectors(fwd, _yAxis).normalize();

    // Detecta submersão (cabeça na água)
    const bCabeca = world.get(
      Math.floor(this.pos.x),
      Math.floor(this.pos.y + PLAYER_HEIGHT * 0.85),
      Math.floor(this.pos.z),
    );
    const submersoAgora = (bCabeca === BLOCO.AGUA);
    if (submersoAgora && !this.foiSubmerso) Audio.splash();
    this.foiSubmerso = submersoAgora;
    this.submerso = submersoAgora;

    // Corpo na água?
    const bCorpo = world.get(
      Math.floor(this.pos.x),
      Math.floor(this.pos.y + 0.5),
      Math.floor(this.pos.z),
    );
    const naAgua = (bCorpo === BLOCO.AGUA || bCabeca === BLOCO.AGUA);

    // Velocidade: sneak < andar < sprint, modulado por água.
    // Sneak agora reduz vel em qualquer modo (criativo OU sobrevivência).
    // Bloqueio de borda continua apenas em sobrevivência (movimento abaixo).
    let speed = (this.input.sprint && !this.sneak) ? VEL_SPRINT
              : this.sneak ? VEL_SNEAK
              : VEL_ANDAR;
    if (naAgua) speed *= 0.55;

    let dx = fwd.x * this.input.fwd + right.x * this.input.side;
    let dz = fwd.z * this.input.fwd + right.z * this.input.side;
    const len = Math.hypot(dx, dz);
    if (len > 0) { dx /= len; dz /= len; }
    const move = (this.modo === 'creative' || this.noChao || naAgua) ? speed : VEL_AR;
    let vx = dx * move, vz = dz * move;
    let vy;
    if (this.modo === 'creative') {
      vy = this.input.up * speed;
      this.vel.y = vy;
      this.noChao = true;
    } else if (naAgua) {
      this.vel.y += (GRAVIDADE * 0.12) * dt;
      if (this.input.jump || this.input.up > 0) this.vel.y = Math.max(this.vel.y, 3.5);
      this.vel.y = clamp(this.vel.y, -3.0, 5.0);
      vy = this.vel.y;
    } else {
      this.vel.y += GRAVIDADE * dt;
      if (this.vel.y < VEL_TERM) this.vel.y = VEL_TERM;
      vy = this.vel.y;
      if (this.input.jump && this.noChao) {
        this.vel.y = PULO_VEL;
        vy = PULO_VEL;
        this.noChao = false;
      }
    }
    this.input.jump = false;

    const yMaxAntes = Math.max(this.pos.y, this.spawnY || this.pos.y);
    this.spawnY = yMaxAntes;
    const xAntes = this.pos.x, zAntes = this.pos.z;

    // Sneak: bloqueia movimento que faria cair de borda.
    if (this.sneak && this.noChao && this.modo === 'survival') {
      const xPrev = this.pos.x;
      this.moverEixo(world, vx * dt, 0, 0);
      if (!this._haChaoSob(world)) this.pos.x = xPrev;
      const zPrev = this.pos.z;
      this.moverEixo(world, 0, 0, vz * dt);
      if (!this._haChaoSob(world)) this.pos.z = zPrev;
    } else {
      this.moverEixo(world, vx * dt, 0, 0);
      this.moverEixo(world, 0, 0, vz * dt);
    }
    this.moverEixo(world, 0, vy * dt, 0);

    // Footsteps com material correto
    const dxReal = this.pos.x - xAntes;
    const dzReal = this.pos.z - zAntes;
    const distH = Math.hypot(dxReal, dzReal);
    if (this.noChao && distH > 1e-4) {
      this.distAndada += distH;
      const passoLimiar = this.sneak ? 0.55 : (this.input.sprint ? 0.32 : 0.45);
      if (this.distAndada >= passoLimiar) {
        this.distAndada = 0;
        const bPe = world.get(
          Math.floor(this.pos.x),
          Math.floor(this.pos.y - 0.1),
          Math.floor(this.pos.z),
        );
        this.materialPasso = materialDeBloco(bPe);
        Audio.passo(this.materialPasso);
      }
    }

    // Câmera (sneak baixa offset)
    const camYOffset = (this.sneak && this.modo === 'survival') ? PLAYER_HEIGHT * 0.65 : PLAYER_HEIGHT * 0.85;
    if (this.terceiraPessoa) {
      const yawCam = this.camera.rotation.y;
      const back = new THREE.Vector3(Math.sin(yawCam), 0.5, Math.cos(yawCam)).multiplyScalar(4);
      this.camera.position.copy(this.pos).add(back).add(new THREE.Vector3(0, camYOffset, 0));
    } else {
      this.camera.position.set(this.pos.x, this.pos.y + camYOffset, this.pos.z);
    }

    // Sobrevivência: dano por terreno
    this.semDano += dt;
    this.accDanoTerreno += dt;
    if (this.accDanoTerreno >= 0.5) {
      this.accDanoTerreno = 0;
      const bDentro = world.get(Math.floor(this.pos.x), Math.floor(this.pos.y + 0.5), Math.floor(this.pos.z));
      const bPe = world.get(Math.floor(this.pos.x), Math.floor(this.pos.y - 0.1), Math.floor(this.pos.z));
      if (bDentro === BLOCO.LAVA || bPe === BLOCO.LAVA) this.aplicarDano(3, 'lava');
      else if (bDentro === BLOCO.CACTO || bPe === BLOCO.CACTO) this.aplicarDano(1, 'cacto');
    }

    // Oxigênio submerso
    this.accAr += dt;
    if (this.submerso) {
      if (this.accAr >= 1.0) {
        this.accAr = 0;
        if (this.ar > 0) {
          this.ar -= 1;
          if (Math.random() < 0.4) Audio.bolha();
        } else if (this.modo === 'survival') {
          this.aplicarDano(2, 'afogamento');
        }
      }
    } else {
      if (this.accAr >= 0.5 && this.ar < this.arMax) {
        this.accAr = 0;
        this.ar = Math.min(this.arMax, this.ar + 2);
      }
    }

    // Fome / saturation / regen (paridade Minecraft simplificada)
    const consumoSat = this.input.sprint ? 0.05 * dt : (distH > 0 ? 0.005 * dt : 0);
    if (this.modo === 'survival') {
      this.saturation = Math.max(0, this.saturation - consumoSat);
      if (this.saturation <= 0) {
        this.accFome += dt;
        if (this.accFome >= 30 && this.fome > 0) { this.accFome = 0; this.fome -= 1; }
      }
      if (this.fome <= 0) {
        if (this.accRegen >= 4) { this.accRegen = 0; this.aplicarDano(1, 'fome'); }
        this.accRegen += dt;
      } else if (this.fome >= 18 && this.semDano >= 4 && this.hp < this.hpMax && this.accRegen >= 4) {
        this.accRegen = 0; this.hp += 1;
        if (this.saturation > 1) this.saturation -= 1; else this.fome = Math.max(0, this.fome - 1);
      } else {
        this.accRegen += dt;
      }
    }
  }

  _haChaoSob(world) {
    const r = PLAYER_RADIUS - 0.02;
    const y = Math.floor(this.pos.y - 0.05);
    const xs = [this.pos.x - r, this.pos.x + r];
    const zs = [this.pos.z - r, this.pos.z + r];
    for (const x of xs) for (const z of zs) {
      if (BLOCO_INFO[world.get(Math.floor(x), y, Math.floor(z))].solido) return true;
    }
    return false;
  }

  moverEixo(world, dx, dy, dz) {
    if (dx === 0 && dy === 0 && dz === 0) return;

    // === X com auto step-up ===
    // Se há colisão e o player está no chão, tenta subir 0.55 (slab)
    // ou 1.0 (bloco inteiro). Paridade Minecraft real — sem precisar
    // pular para cada degrau.
    if (dx !== 0) {
      const novoX = this.pos.x + dx;
      if (!this.colisaoBlocos(world, novoX, this.pos.y, this.pos.z)) {
        this.pos.x = novoX;
      } else if (this.noChao) {
        for (const subir of [0.55, 1.0]) {
          if (!this.colisaoBlocos(world, novoX, this.pos.y + subir, this.pos.z)) {
            this.pos.x = novoX;
            this.pos.y += subir;
            this.spawnY = this.pos.y;
            break;
          }
        }
      }
    }

    // === Y (gravidade/pulo) ===
    if (dy !== 0) {
      const novoY = this.pos.y + dy;
      if (this.colisaoBlocos(world, this.pos.x, novoY, this.pos.z)) {
        if (dy < 0) {
          const queda = (this.spawnY || this.pos.y) - novoY;
          if (this.modo === 'survival' && queda > 4) {
            const dano = Math.round(queda - 3);
            if (dano > 0) this.aplicarDano(dano, `queda ${queda.toFixed(1)}`);
          }
          this.spawnY = this.pos.y;
          this.noChao = true;
        }
        this.vel.y = 0;
      } else {
        this.pos.y = novoY;
        if (dy > 0) this.spawnY = Math.max(this.spawnY || this.pos.y, this.pos.y);
        else this.noChao = false;
      }
    }

    // === Z com auto step-up (mesmo padrão do X) ===
    if (dz !== 0) {
      const novoZ = this.pos.z + dz;
      if (!this.colisaoBlocos(world, this.pos.x, this.pos.y, novoZ)) {
        this.pos.z = novoZ;
      } else if (this.noChao) {
        for (const subir of [0.55, 1.0]) {
          if (!this.colisaoBlocos(world, this.pos.x, this.pos.y + subir, novoZ)) {
            this.pos.z = novoZ;
            this.pos.y += subir;
            this.spawnY = this.pos.y;
            break;
          }
        }
      }
    }
  }

  colisaoBlocos(world, px, py, pz) {
    const r = PLAYER_RADIUS;
    const x0 = Math.floor(px - r), x1 = Math.floor(px + r);
    const y0 = Math.floor(py),     y1 = Math.floor(py + PLAYER_HEIGHT - 0.05);
    const z0 = Math.floor(pz - r), z1 = Math.floor(pz + r);
    for (let x = x0; x <= x1; x++)
      for (let y = y0; y <= y1; y++)
        for (let z = z0; z <= z1; z++) {
          const b = world.get(x, y, z);
          // Água é passável (swim physics trata drag/buoyancy separado)
          if (b === BLOCO.AGUA) continue;
          if (BLOCO_INFO[b].solido) return true;
        }
    return false;
  }

  aplicarDano(d, fonte) {
    if (this.morto) return;
    if (this.modo === 'creative' && fonte !== 'void') return;
    const defesa = state.inv ? state.inv.defesaTotal() : 0;
    const reducao = Math.min(0.8, defesa * 0.04);
    const danoReal = Math.max(1, Math.round(d * (1 - reducao)));
    this.hp -= danoReal;
    this.semDano = 0;
    Audio.hurt();
    if (state.ui?.flashDano) state.ui.flashDano();
    if (state.renderer?.aplicarShake) {
      state.renderer.aplicarShake(Math.min(0.30, 0.05 + danoReal * 0.025));
    }
    if (this.hp <= 0) {
      this.hp = 0;
      this.morto = true;
      this.causaMorte = fonte;
      // Drop do inventário no chão (paridade Minecraft survival).
      // Skip em creative — você não perde itens em creative.
      if (this.modo !== 'creative' && state.inv) {
        let dropped = 0;
        for (let k = 0; k < state.inv.slots.length; k++) {
          const it = state.inv.slots[k];
          if (it && it.q > 0) {
            // Espalha em 1 bloco de raio pra não empilharem todos no mesmo ponto
            const ox = (Math.random() - 0.5) * 1.2;
            const oz = (Math.random() - 0.5) * 1.2;
            spawnItemDrop({ ...it }, this.pos.x + ox, this.pos.y, this.pos.z + oz);
            state.inv.slots[k] = null;
            dropped++;
          }
        }
        if (dropped > 0) state.ui.renderHotbar?.();
      }
      state.ui.toast(`Você morreu (${fonte})`);
      state.ui.mostrarMorte(fonte);
    } else {
      state.ui.toast(`-${danoReal} HP (${fonte})${defesa > 0 ? ` [armadura: -${d - danoReal}]` : ''}`);
    }
  }

  respawnar() {
    this.pos.copy(this.spawn);
    this.vel.set(0, 0, 0);
    this.hp = this.hpMax;
    this.fome = this.fomeMax;
    this.saturation = 5.0;
    this.ar = this.arMax;
    this.morto = false;
    this.causaMorte = '';
    this.spawnY = this.pos.y;
    Audio.respawn();
    state.ui.toast('Respawn');
    state.ui.esconderMorte();
  }
}
