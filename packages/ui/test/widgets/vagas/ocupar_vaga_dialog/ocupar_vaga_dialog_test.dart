import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_enums.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/dialogs/ocupar_vaga_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:ui/src/injection.dart';

import 'ocupar_vaga_dialog_test.mocks.dart';

void _getItRegisterCubit({required VagasCubit vagasCubit}) {
  getIt.registerFactory(() => vagasCubit);
}

void _getItUnregisterCubit() {
  getIt.unregister<VagasCubit>();
}

final Vaga vaga =
    Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1);

Future<void> _initWidget(tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              key: const Key('open_dialog'),
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return OcuparVagaDialog(
                      vaga: vaga,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    ),
  );
}

@GenerateMocks([GetVagasUseCase, CloseVagaUseCase, OpenVagaUseCase])
void main() {
  tearDown(() async {
    _getItUnregisterCubit();
  });

  group('OcuparVagaWidget', () {
    group('When OcuparVagaWidget is called', () {
      testWidgets('Should display title, confirm and cancel button',
          (WidgetTester tester) async {
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

        await _initWidget(tester);
        await tester.tap(find.byKey(const Key('open_dialog')));
        await tester.pump();

        expect(find.text('Informe a placa'), findsOneWidget);
        expect(find.text('cancelar'), findsOneWidget);
        expect(find.text('confirmar'), findsOneWidget);
      });

      group('When confirm button is clicked', () {
        testWidgets('If placa is not informed should show display error',
            (WidgetTester tester) async {
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

          await _initWidget(tester);
          await tester.tap(find.byKey(const Key('open_dialog')));
          await tester.pump();

          await tester.tap(find.text('confirmar'));
          await tester.pumpAndSettle();

          expect(
              find.text('Por favor informe uma placa válida.'), findsOneWidget);
        });

        testWidgets('If placa is lower than 7 digits should show display error',
            (WidgetTester tester) async {
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

          await _initWidget(tester);
          await tester.tap(find.byKey(const Key('open_dialog')));
          await tester.pump();

          await tester.enterText(find.byType(TextFormField), '12345');
          await tester.tap(find.text('confirmar'));
          await tester.pumpAndSettle();

          expect(find.text('A placa deve ter no mínimo 7 digítos.'),
              findsOneWidget);
        });

        testWidgets(
            'If placa is valid should call CloseVagaUseCase and then display snakbar message and close the dialog',
            (WidgetTester tester) async {
          final mockedGetVagasUseCase = MockGetVagasUseCase();
          final mockedCloseVagaUseCase = MockCloseVagaUseCase();
          final mockedOpenVagaUseCase = MockOpenVagaUseCase();

          when(mockedGetVagasUseCase.call())
              .thenAnswer((_) async => Right([vaga]));

          when(mockedCloseVagaUseCase.call(vagaId: 'id', placa: 'ABCDEFG'))
              .thenAnswer(
            (_) async => Right(Vaga(
                id: 'id',
                disponivel: false,
                tipoVaga: TipoVagaEnum.moto,
                numero: 1)),
          );

          final VagasCubit vagasCubit = VagasCubit(
              getVagasUseCase: mockedGetVagasUseCase,
              closeVagaUseCase: mockedCloseVagaUseCase,
              openVagaUseCase: mockedOpenVagaUseCase);

          _getItRegisterCubit(
            vagasCubit: vagasCubit,
          );

          await _initWidget(tester);
          await vagasCubit.getVagas();

          await tester.tap(find.byKey(const Key('open_dialog')));
          await tester.pump();

          await tester.enterText(find.byType(TextFormField), 'ABCDEFG');
          await tester.tap(find.text('confirmar'));
          await tester.pumpAndSettle();

          expect(find.text('Marcando a vaga como ocupada...'), findsOneWidget);
          expect(find.byType(OcuparVagaDialog), findsNothing);

          verify(mockedCloseVagaUseCase.call(vagaId: 'id', placa: 'ABCDEFG'));
        });
      });

      group('When cancel button is clicked', () {
        testWidgets('Should close the dialog', (WidgetTester tester) async {
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

          await _initWidget(tester);

          await tester.tap(find.byKey(const Key('open_dialog')));
          await tester.pump();

          await tester.tap(find.text('cancelar'));
          await tester.pumpAndSettle();

          expect(find.byType(OcuparVagaDialog), findsNothing);
        });
      });
    });
  });
}
