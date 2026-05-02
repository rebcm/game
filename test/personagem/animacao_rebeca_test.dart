import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/personagem/animacao_rebeca.dart';

void main() {
  testWidgets('AnimacaoRebeca should animate', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TestRebeca(),
        ),
      ),
    );

    final _RebecaState state = tester.state(find.byType(Rebeca));
    final AnimacaoRebeca animacao = state._animacao;

    expect(animacao.anguloBracos, isNot(0));
    expect(animacao.anguloPernas, isNot(0));

    await tester.pump(const Duration(milliseconds: 250));
    expect(animacao.anguloBracos, isNot(animacao.anguloPernas));
  });
}

class TestRebeca extends StatefulWidget {
  @override
  _TestRebecaState createState() => _TestRebecaState();
}

class _TestRebecaState extends State<TestRebeca> with TickerProviderStateMixin {
  late AnimacaoRebeca _animacao;

  @override
  void initState() {
    super.initState();
    _animacao = AnimacaoRebeca(this);
  }

  @override
  void dispose() {
    _animacao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
