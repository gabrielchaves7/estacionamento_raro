import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_enums.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/dialogs/ocupar_vaga_dialog.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/vagas/vaga_card_widget.dart';

import './vaga_card_widget_test.mocks.dart';

void _getItRegisterCubit({required VagasCubit vagasCubit}) {
  getIt.registerFactory(() => vagasCubit);
}

void _getItUnregisterCubit() {
  getIt.unregister<VagasCubit>();
}

Future<void> _initWidget(tester, {required Vaga vaga}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: VagaCardWidget(
          vaga: vaga,
        ),
      ),
    ),
  );
}

@GenerateMocks([GetVagasUseCase, CloseVagaUseCase, OpenVagaUseCase])
void main() {
  group('VagaCardWidget', () {
    group('When VagaCardWidget is called', () {
      testWidgets('Should display codigo and icon',
          (WidgetTester tester) async {
        final Vaga vaga = Vaga(
            id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1);

        await _initWidget(tester, vaga: vaga);

        expect(find.text('1'), findsOneWidget);
        find.byIcon(Icons.motorcycle);
      });

      testWidgets(
          'Should display the directions_car car icon when tipoVaga is TipoVagaEnum.carro',
          (WidgetTester tester) async {
        final Vaga vaga = Vaga(
            id: 'id',
            disponivel: true,
            tipoVaga: TipoVagaEnum.carro,
            numero: 2);

        await _initWidget(tester, vaga: vaga);

        expect(find.text('2'), findsOneWidget);
        find.byIcon(Icons.directions_car);
      });

      testWidgets(
          'Should display the directions_subway car icon when tipoVaga is TipoVagaEnum.caminhao',
          (WidgetTester tester) async {
        final Vaga vaga = Vaga(
            id: 'id',
            disponivel: true,
            tipoVaga: TipoVagaEnum.caminhao,
            numero: 3);

        await _initWidget(tester, vaga: vaga);

        expect(find.text('3'), findsOneWidget);
        find.byIcon(Icons.directions_subway);
      });
    });

    group('When VagaCardWidget is clicked', () {
      testWidgets('Should open OcuparVagaDialog', (WidgetTester tester) async {
        final mockedGetVagasUseCase = MockGetVagasUseCase();
        final mockedCloseVagaUseCase = MockCloseVagaUseCase();
        final mockedOpenVagaUseCase = MockOpenVagaUseCase();

        final VagasCubit vagasCubit = VagasCubit(
            getVagasUseCase: mockedGetVagasUseCase,
            closeVagaUseCase: mockedCloseVagaUseCase,
            openVagaUseCase: mockedOpenVagaUseCase);

        _getItRegisterCubit(
          vagasCubit: vagasCubit,
        );

        final Vaga vaga = Vaga(
            id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1);

        await _initWidget(tester, vaga: vaga);

        await tester.tap(find.text('1'));
        await tester.pump();

        find.byType(OcuparVagaDialog);

        _getItUnregisterCubit();
      });
    });
  });
}
