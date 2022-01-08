import 'package:domain/estacionamento_raro_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ui/src/widgets/registros/registro_card_widget.dart';

Future<void> _initWidget(tester, {required Registro registro}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: RegistroCardWidget(
          registro: registro,
        ),
      ),
    ),
  );
}

void main() {
  setUpAll(() => initializeDateFormatting('pt_BR', ''));

  group('RegistroCardWidget', () {
    group('When RegistroCardWidget is called', () {
      testWidgets(
          'Should display placa, horario de entrada, tempo de permanência e horario saida',
          (WidgetTester tester) async {
        //Horario entrada: 07/01/2022 10:06
        //Horario saida: 07/01/2022 11:06

        final Registro registro = Registro(
            horarioEntrada: DateTime.fromMillisecondsSinceEpoch(1641560814000),
            id: '1',
            vagaId: 'vaga/klmxaskl12',
            placa: 'PLACAA',
            horarioSaida: DateTime.fromMillisecondsSinceEpoch(1641564414000));

        await _initWidget(tester, registro: registro);

        expect(find.text('Placa'), findsOneWidget);
        expect(find.text('PLACAA'), findsOneWidget);

        expect(find.text('Entrada'), findsOneWidget);
        expect(find.text('07/01/2022 10:06'), findsOneWidget);

        expect(find.text('Permanência'), findsOneWidget);
        expect(find.text('1 hora (s).'), findsOneWidget);

        expect(find.text('Saída'), findsOneWidget);
        expect(find.text('07/01/2022 11:06'), findsOneWidget);
      });

      testWidgets(
          'If permanencia is bigger than 24 hours should display days and hours',
          (WidgetTester tester) async {
        //Horario entrada: 06/01/2022 11:06
        //Horario saida: 07/01/2022 12:06

        final Registro registro = Registro(
            horarioEntrada: DateTime.fromMillisecondsSinceEpoch(1641478014000),
            id: '1',
            vagaId: 'vaga/klmxaskl12',
            placa: 'PLACAA',
            horarioSaida: DateTime.fromMillisecondsSinceEpoch(1641568014000));

        await _initWidget(tester, registro: registro);

        expect(find.text('Permanência'), findsOneWidget);
        expect(find.text('1 dia (s) e 1 hora (s).'), findsOneWidget);
      });

      testWidgets(
          'If permanencia is smaller than 1 hour should display minutes',
          (WidgetTester tester) async {
        //Horario entrada: 06/01/2022 11:06
        //Horario saida: 06/01/2022 11:51

        final Registro registro = Registro(
            horarioEntrada: DateTime.fromMillisecondsSinceEpoch(1641478014000),
            id: '1',
            vagaId: 'vaga/klmxaskl12',
            placa: 'PLACAA',
            horarioSaida: DateTime.fromMillisecondsSinceEpoch(1641480714000));

        await _initWidget(tester, registro: registro);

        expect(find.text('Permanência'), findsOneWidget);
        expect(find.text('45 minuto (s).'), findsOneWidget);
      });

      testWidgets('If horario_saida is null should display aguardando',
          (WidgetTester tester) async {
        //Horario entrada: 06/01/2022 11:06
        //Horario saida: 06/01/2022 11:51

        final Registro registro = Registro(
            horarioEntrada: DateTime.fromMillisecondsSinceEpoch(1641478014000),
            id: '1',
            vagaId: 'vaga/klmxaskl12',
            placa: 'PLACAA',
            horarioSaida: null);

        await _initWidget(tester, registro: registro);

        expect(find.text('Aguardando'), findsOneWidget);
      });
    });
  });
}
