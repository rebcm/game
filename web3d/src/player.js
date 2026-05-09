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
import { Save } from './save.js';

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
    this.naAgua = naAgua; // expõe pra UI/render usar (underwater overlay)

    // Velocidade: sneak < andar < sprint, modulado por água.
    // Sneak agora reduz vel em qualquer modo (criativo OU sobrevivência).
    // Bloqueio de borda continua apenas em sobrevivência (movimento abaixo).
    let speed = (this.input.sprint && !this.sneak) ? VEL_SPRINT
              : this.sneak ? VEL_SNEAK
              : VEL_ANDAR;
    if (naAgua) speed *= 0.55;
    // Teia de aranha: reduz drasticamente a velocidade (como Minecraft)
    const blocoEm = world.get(Math.floor(this.pos.x), Math.floor(this.pos.y), Math.floor(this.pos.z));
    if (blocoEm === BLOCO.TEIA) speed *= 0.20;
    // Trilho debaixo do player: pequeno boost (1.15×) — proxy de minecart
    const blocoBaixo = world.get(Math.floor(this.pos.x), Math.floor(this.pos.y - 0.6), Math.floor(this.pos.z));
    if (blocoBaixo === BLOCO.RAIL) speed *= 1.15;
    // Poção de speed: +30% velocidade (decremento natural ao expirar)
    if (this.efeitos?.speed && Date.now() < this.efeitos.speed) speed *= 1.30;
    else if (this.efeitos?.speed) delete this.efeitos.speed;
    // Slowness (flecha do stray): -50% velocidade
    if (this.efeitos?.slowness && Date.now() < this.efeitos.slowness) speed *= 0.50;
    else if (this.efeitos?.slowness) delete this.efeitos.slowness;
    // SPRINT MEGA-1: Dolphin's Grace (golfinho) — +60% nado
    if (this.efeitos?.dolphin && Date.now() < this.efeitos.dolphin) {
      if (naAgua) speed *= 1.60;
    } else if (this.efeitos?.dolphin) delete this.efeitos.dolphin;
    // Soul Speed (passar em soul sand, +30%)
    const blocoBaixoSoul = world.get(Math.floor(this.pos.x), Math.floor(this.pos.y - 0.6), Math.floor(this.pos.z));
    if (blocoBaixoSoul === BLOCO.SOUL_SAND || blocoBaixoSoul === BLOCO.SOUL_SOIL) {
      if (this.efeitos?.soul_speed && Date.now() < this.efeitos.soul_speed) speed *= 1.30;
    }
    // Wither: dano contínuo 1HP a cada 2s, pode matar (igual MC)
    if (this.efeitos?.wither) {
      if (Date.now() >= this.efeitos.wither) delete this.efeitos.wither;
      else {
        this._accWither = (this._accWither || 0) + dt;
        if (this._accWither >= 2.0 && this.modo === 'survival') {
          this._accWither = 0;
          this.hp = Math.max(0, this.hp - 1);
          if (this.hp <= 0) this.morrer?.();
          state.ui?.toast?.('🖤 Wither!');
        }
      }
    }
    // Hunger effect: drena fome 0.5 a cada 1s
    if (this.efeitos?.hunger_effect) {
      if (Date.now() >= this.efeitos.hunger_effect) delete this.efeitos.hunger_effect;
      else {
        this._accHunger = (this._accHunger || 0) + dt;
        if (this._accHunger >= 1.0) {
          this._accHunger = 0;
          this.fome = Math.max(0, (this.fome || 20) - 0.5);
        }
      }
    }
    // Absorption: extra HP amarelo (4 corações por nível)
    if (this.efeitos?.absorption && Date.now() < this.efeitos.absorption) {
      if (!this._absorptionAplicada) {
        this.hpMax = (this._hpMaxBase || this.hpMax) + 4;
        this._hpMaxBase = this._hpMaxBase || 20;
        this._absorptionAplicada = true;
      }
    } else if (this.efeitos?.absorption) {
      delete this.efeitos.absorption;
      if (this._absorptionAplicada) {
        this.hpMax = this._hpMaxBase || 20;
        this.hp = Math.min(this.hp, this.hpMax);
        this._absorptionAplicada = false;
      }
    }
    // Water Breathing / Conduit Power: pula consumo de oxigênio
    // (verificado em this.efeitos?.water_breathing dentro do bloco oxigênio)
    // Jump Boost: +50% pulo (aplicado quando jump triggerado abaixo)
    // Veneno: dreno HP a cada 1.5s enquanto efeito ativo. Mínimo 1 HP
    // (paridade Minecraft real — poison não mata, só debilita).
    if (this.efeitos?.poison) {
      if (Date.now() >= this.efeitos.poison) delete this.efeitos.poison;
      else {
        this._accPoison = (this._accPoison || 0) + dt;
        if (this._accPoison >= 1.5 && this.hp > 1) {
          this._accPoison = 0;
          this.hp = Math.max(1, this.hp - 1);
          state.ui?.toast?.('☠ Envenenado!');
        }
      }
    }
    // Regen: tick HP gain a cada 1s (gerenciado em hunger block, mas aqui só checa expiração)
    if (this.efeitos?.regen) {
      if (Date.now() >= this.efeitos.regen) delete this.efeitos.regen;
      else {
        this._accRegenPocao = (this._accRegenPocao || 0) + dt;
        if (this._accRegenPocao >= 1.5 && this.hp < this.hpMax) {
          this._accRegenPocao = 0;
          this.hp = Math.min(this.hpMax, this.hp + 1);
        }
      }
    }

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
      // Detecta ladder no bloco do player (ou logo abaixo) — climb mode
      const naLadder = this._tocaLadder(world);
      if (naLadder) {
        // Subir/parar/descer baseado em input vertical
        if (this.input.up > 0 || this.input.jump) this.vel.y = 2.6;
        else if (this.input.fwd === 0 && this.input.side === 0) this.vel.y = 0;
        else this.vel.y = Math.max(-1.5, this.vel.y - 4 * dt);
        vy = this.vel.y;
      } else {
        // Slow Fall: gravidade reduzida em 80% (paridade MC slow falling)
        const slowFall = this.efeitos?.slow_fall && Date.now() < this.efeitos.slow_fall;
        // Levitação: gravity invertida (player sobe lentamente)
        const levitacao = this.efeitos?.levitacao && Date.now() < this.efeitos.levitacao;
        if (levitacao) {
          this.vel.y = Math.max(this.vel.y, 1.5); // sobe a 1.5 m/s
        } else {
          this.vel.y += (slowFall ? GRAVIDADE * 0.20 : GRAVIDADE) * dt;
        }
        if (this.vel.y < VEL_TERM) this.vel.y = VEL_TERM;
        vy = this.vel.y;
        if (this.input.jump && this.noChao) {
          // Jump Boost: +50% altura por nível
          let pulo = PULO_VEL;
          if (this.efeitos?.jump_boost && Date.now() < this.efeitos.jump_boost) pulo *= 1.5;
          else if (this.efeitos?.jump_boost) delete this.efeitos.jump_boost;
          this.vel.y = pulo;
          vy = pulo;
          this.noChao = false;
        }
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
      // Magma: dano 1 ao pisar, mas evitado se sneaking (paridade MC)
      else if (bPe === BLOCO.MAGMA && !this.sneak) this.aplicarDano(1, 'magma');
    }

    // Oxigênio submerso (Water Breathing pula consumo)
    this.accAr += dt;
    const waterBreath = (this.efeitos?.water_breathing && Date.now() < this.efeitos.water_breathing) ||
                       (this.efeitos?.dolphin && Date.now() < this.efeitos.dolphin) ||
                       (this.efeitos?.turtle_master && Date.now() < this.efeitos.turtle_master) ||
                       (this.efeitos?.conduit_power && Date.now() < this.efeitos.conduit_power);
    if (this.submerso && !waterBreath) {
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

    // === Hunger system (paridade Minecraft real, simplificada) ===
    // - Exhaustion acumula por ações (sprintar=0.10/s, andar=0.01/s,
    //   pular=0.05, levar dano=0.30, regenerar=6.0).
    // - Quando exhaustion >= 4, consome 1 saturation; se sat=0, consome 1 fome.
    // - Regen só ocorre se fome >= 18 (Saturated Regen) E semDano >= 4s,
    //   gastando 1 saturation/HP. Tick rápido: a cada 0.5s.
    // - Fome 0: dano 1 a cada 4s (até HP 1 em survival, até morte em hard).
    if (this.modo === 'survival') {
      // Acumula exhaustion por movimento
      let exh = 0;
      if (this.input.sprint && distH > 0) exh += 0.10 * dt;
      else if (distH > 0) exh += 0.010 * dt;
      this.exhaustion = (this.exhaustion || 0) + exh;
      // Drena saturation/fome quando exhaustion estoura
      while (this.exhaustion >= 4) {
        this.exhaustion -= 4;
        if (this.saturation > 0) this.saturation = Math.max(0, this.saturation - 1);
        else if (this.fome > 0) this.fome -= 1;
      }
      // Regeneração: 2 modos (paridade MC)
      this.accRegen = (this.accRegen || 0) + dt;
      if (this.fome <= 0) {
        // Sem comida — toma dano lento
        if (this.accRegen >= 4 && this.hp > 1) {
          this.accRegen = 0; this.aplicarDano(1, 'fome');
        }
      } else if (this.fome >= 18 && this.saturation > 0 && this.hp < this.hpMax) {
        // Saturated Regen: rápido, gasta saturation
        if (this.accRegen >= 0.5) {
          this.accRegen = 0;
          this.hp = Math.min(this.hpMax, this.hp + 1);
          this.exhaustion += 6;
        }
      } else if (this.fome >= 18 && this.semDano >= 4 && this.hp < this.hpMax) {
        // Slow Regen: lento, gasta fome
        if (this.accRegen >= 4) {
          this.accRegen = 0;
          this.hp = Math.min(this.hpMax, this.hp + 1);
          this.exhaustion += 6;
        }
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
          // Slow Fall: zera dano de queda completamente (paridade MC)
          const slowFall = this.efeitos?.slow_fall && Date.now() < this.efeitos.slow_fall;
          if (this.modo === 'survival' && queda > 4 && !slowFall) {
            let dano = Math.round(queda - 3);
            // SPRINT MEGA-1: Feather Falling — reduz dano de queda 12% por nível
            const botas = state.inv?.equipado?.('botas');
            if (botas?.encant?.feather_falling) {
              dano = Math.max(0, Math.round(dano * (1 - 0.12 * botas.encant.feather_falling)));
            }
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

  // Verifica se o player está tocando uma escada (ladder) — usado pra
  // ativar o climb mode (subir/descer continuamente sem gravidade).
  _tocaLadder(world) {
    const x = Math.floor(this.pos.x);
    const z = Math.floor(this.pos.z);
    for (let dy = 0; dy <= 1; dy++) {
      const y = Math.floor(this.pos.y) + dy;
      if (BLOCO_INFO[world.get(x, y, z)]?.shape === 'ladder') return true;
    }
    return false;
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
          if (b === BLOCO.AGUA) continue;
          const info = BLOCO_INFO[b];
          if (!info?.solido) continue;
          // Slab: só colide se player intersecta meia altura inferior (y..y+0.5)
          if (info.shape === 'slab') {
            if (py >= y + 0.5) continue;
            if (py + PLAYER_HEIGHT - 0.05 <= y) continue;
            // Player também precisa estar horizontalmente dentro
            if (px + r <= x || px - r >= x + 1) continue;
            if (pz + r <= z || pz - r >= z + 1) continue;
            return true;
          }
          // Fence: pillar central 0.4 de raio (de 0.3 a 0.7 em x e z)
          if (info.shape === 'fence') {
            if (px + r <= x + 0.3 || px - r >= x + 0.7) continue;
            if (pz + r <= z + 0.3 || pz - r >= z + 0.7) continue;
            return true;
          }
          // Ladder: chapinha em -Z (climb tratado fora; passável)
          if (info.shape === 'ladder') continue;
          if (info.shape === 'door_open') continue; // porta aberta passa
          // Porta fechada: chapinha frontal — colisão só na faixa z..z+0.18
          if (info.shape === 'door') {
            if (pz + r <= z || pz - r >= z + 0.18) continue;
            return true;
          }
          return true;
        }
    return false;
  }

  aplicarDano(d, fonte) {
    if (this.morto) return;
    if (this.modo === 'creative' && fonte !== 'void') return;
    const defesa = state.inv ? state.inv.defesaTotal() : 0;
    let reducao = Math.min(0.8, defesa * 0.04);
    // Protection enchantments em armaduras: -5%/lvl
    // SPRINT MEGA-1: Fire/Blast/Projectile Protection específicos
    if (state.inv?.armadura) {
      let protBonus = 0;
      for (const peca of Object.values(state.inv.armadura)) {
        if (peca?.encant?.protection) protBonus += peca.encant.protection * 0.05;
        if (peca?.encant?.fire_protection && (fonte === 'lava' || fonte === 'magma' || fonte === 'fogo' || fonte === 'queima')) {
          protBonus += peca.encant.fire_protection * 0.08;
        }
        if (peca?.encant?.blast_protection && (fonte === 'creeper' || fonte === 'tnt' || fonte === 'explosao')) {
          protBonus += peca.encant.blast_protection * 0.08;
        }
        if (peca?.encant?.projectile_protection && (fonte === 'flecha' || fonte === 'projetil')) {
          protBonus += peca.encant.projectile_protection * 0.08;
        }
        // Thorns: reflete 1-4 dano ao atacante (handled in mob attack code, mas placeholder aqui)
        if (peca?.encant?.thorns && (fonte === 'mob' || fonte === 'zumbi')) {
          // refletido em main.js durante ataque mob→player
        }
      }
      reducao = Math.min(0.85, reducao + protBonus);
    }
    // Fire Resistance: zera dano de lava/fogo/magma
    if (this.efeitos?.fire_res && Date.now() < this.efeitos.fire_res) {
      if (fonte === 'lava' || fonte === 'magma') return;
    } else if (this.efeitos?.fire_res) delete this.efeitos.fire_res;
    let danoReal = Math.max(1, Math.round(d * (1 - reducao)));
    // Resistência: -50% dano (paridade MC potion of resistance)
    if (this.efeitos?.resistencia && Date.now() < this.efeitos.resistencia) {
      danoReal = Math.max(1, Math.round(danoReal * 0.5));
    } else if (this.efeitos?.resistencia) delete this.efeitos.resistencia;
    // Absorption: corações dourados absorvem dano antes do HP normal
    if (this.absorptionHP > 0) {
      const absorvido = Math.min(this.absorptionHP, danoReal);
      this.absorptionHP -= absorvido;
      danoReal -= absorvido;
    }
    this.hp -= danoReal;
    this.semDano = 0;
    Audio.hurt();
    if (state.ui?.flashDano) state.ui.flashDano();
    if (state.renderer?.aplicarShake) {
      state.renderer.aplicarShake(Math.min(0.30, 0.05 + danoReal * 0.025));
    }
    if (this.hp <= 0) {
      // SPRINT MEGA-6: Totem of Undying — revive ao morrer (paridade Minecraft)
      // Procura TOTEM_VIDA no inventário (slots de mão ou hotbar)
      if (state.inv?.slots) {
        let totemSlot = -1;
        for (let i = 0; i < state.inv.slots.length; i++) {
          const it = state.inv.slots[i];
          if (it && it.i === 404 /* ITEM.TOTEM_VIDA */ && it.q > 0) {
            totemSlot = i;
            break;
          }
        }
        if (totemSlot >= 0) {
          // Consome 1 totem, revive
          state.inv.slots[totemSlot].q -= 1;
          if (state.inv.slots[totemSlot].q <= 0) state.inv.slots[totemSlot] = null;
          this.hp = 1;
          this.efeitos = this.efeitos || {};
          this.efeitos.regen = Date.now() + 40000; // Regen II 40s
          this.efeitos.absorption = Date.now() + 5000; // Absorção 5s
          this.efeitos.fire_res = Date.now() + 40000; // Fire Res 40s
          state.ui?.toast?.('🗿 TOTEM DE IMORTALIDADE! Revivido!');
          state.renderer?.aplicarShake?.(0.5);
          if (state.ui?.renderHotbar) state.ui.renderHotbar();
          return;
        }
      }
      this.hp = 0;
      this.morto = true;
      this.causaMorte = fonte;
      Save.incrementarStat('deaths');
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
