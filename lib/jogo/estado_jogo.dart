import 'dart:async';
import 'package:flutter/foundation.dart';
import '../mundo/mundo.dart';
import '../mundo/persistencia.dart';
import '../personagem/rebeca.dart';

enum EstadoTela { inicio, jogando, pausado }

class EstadoJogo extends ChangeNotifier {
  EstadoTela tela = EstadoTela.inicio;
  Mundo? mundo;
  Rebeca? rebeca;
  bool mostrarInventario = false;
  int totalBlocosColocados = 0;
  int totalBlocosRemovidos = 0;
  DateTime? inicioSessao;
  String nomeDoMundo = 'Mundo da Rebeca';
  bool mundoExisteSalvo = false;
  Timer? _autoSave;

  EstadoJogo() {
    _verificarMundoSalvo();
  }

  Future<void> _verificarMundoSalvo() async {
    mundoExisteSalvo = await PersistenciaMundo.mundoExiste();
    if (mundoExisteSalvo) {
      nomeDoMundo = await PersistenciaMundo.carregarNome();
    }
    notifyListeners();
  }

  Future<void> iniciarJogo({String? nome, bool novoMundo = false}) async {
    nomeDoMundo = nome ?? nomeDoMundo;

    if (novoMundo) {
      await PersistenciaMundo.limparMundo();
      mundo = Mundo();
    } else {
      final semente = await PersistenciaMundo.carregarSemente();
      mundo = Mundo(semente: semente);
    }

    final pos = novoMundo ? null : await PersistenciaMundo.carregarPosicao();
    rebeca = Rebeca(
      x: pos?.x.toDouble() ?? 8.0,
      y: pos?.y.toDouble() ?? 20.0,
      z: pos?.z.toDouble() ?? 8.0,
    );

    inicioSessao = DateTime.now();
    tela = EstadoTela.jogando;
    totalBlocosColocados = 0;
    totalBlocosRemovidos = 0;
    mostrarInventario = false;
    notifyListeners();

    _iniciarAutoSave();
  }

  void _iniciarAutoSave() {
    _autoSave?.cancel();
    _autoSave = Timer.periodic(const Duration(seconds: 30), (_) => _salvar());
  }

  Future<void> _salvar() async {
    if (mundo == null || rebeca == null) return;
    await PersistenciaMundo.salvarPosicao(rebeca!.x, rebeca!.y, rebeca!.z);
    await mundo!.salvar(nomeDoMundo);
    mundoExisteSalvo = true;
  }

  Future<void> pausar() async {
    await _salvar();
    tela = EstadoTela.pausado;
    notifyListeners();
  }

  void retomar() {
    tela = EstadoTela.jogando;
    notifyListeners();
  }

  Future<void> voltarInicio() async {
    await _salvar();
    _autoSave?.cancel();
    tela = EstadoTela.inicio;
    mundo = null;
    rebeca = null;
    inicioSessao = null;
    mostrarInventario = false;
    mundoExisteSalvo = await PersistenciaMundo.mundoExiste();
    notifyListeners();
  }

  void abrirInventario() {
    mostrarInventario = !mostrarInventario;
    notifyListeners();
  }

  void blocoColocado() {
    totalBlocosColocados++;
    notifyListeners();
  }

  void blocoRemovido() {
    totalBlocosRemovidos++;
    notifyListeners();
  }

  Duration get tempoJogando =>
      inicioSessao != null
          ? DateTime.now().difference(inicioSessao!)
          : Duration.zero;

  @override
  void dispose() {
    _autoSave?.cancel();
    super.dispose();
  }
}
