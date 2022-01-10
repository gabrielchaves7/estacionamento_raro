import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:estacionamento_raro/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Tap on the vagas menu should open vagas widget', () {
    testWidgets(
        'and then if user tap on vaga card and fill the placa, the card should not show anymore',
        (WidgetTester tester) async {
      app.main();
      await tester.pump();
      await tester.pump();

      //Acha o card de uma vaga disponível e marca ela como indisponível
      await tester.tap(find.text('1'));
      await tester.pump();

      //Preenche a placa para marcar a vaca como ocupada
      await tester.enterText(find.byType(TextFormField), 'ABCDEFG');
      await tester.tap(find.text('confirmar'));
      await tester.pump(const Duration(milliseconds: 500));

      //Clica em indisponíveis
      await tester.tap(find.text('Indisponíveis'));
      await tester.pump();
      await tester.pump();

      //Confirma se a placa realmente foi para a página de indisponíveis
      expect(find.text('ABCDEFG'), findsOneWidget);

      //Clica na placa informada antes
      await tester.tap(find.text('ABCDEFG'));
      await tester.pump();

      //Clica em confirmar para a vaga voltar a ficar disponivel
      await tester.tap(find.text('confirmar'));
      await tester.pump(const Duration(milliseconds: 500));

      //Confirma se a placa foi removida da página de indisponíveis
      expect(find.text('ABCDEFG'), findsNothing);
    });
  });
}
