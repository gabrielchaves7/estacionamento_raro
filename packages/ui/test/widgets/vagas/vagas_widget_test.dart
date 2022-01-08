import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_enums.dart';
import 'package:domain/estacionamento_raro_errors.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/vagas/vaga_card_widget.dart';
import 'package:ui/src/widgets/vagas/vagas_widget.dart';

import './vagas_widget_test.mocks.dart';

void _getItRegisterCubit({required VagasCubit vagasCubit}) {
  getIt.registerFactory(() => vagasCubit);
}

void _getItUnregisterCubit() {
  getIt.unregister<VagasCubit>();
}

Future<void> _initWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: VagasWidget(),
      ),
    ),
  );
}

final List<Vaga> vagas = [
  Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1),
  Vaga(id: 'id', disponivel: false, tipoVaga: TipoVagaEnum.carro, numero: 2),
  Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.caminhao, numero: 3),
];

@GenerateMocks([GetVagasUseCase])
void main() {
  tearDown(() async {
    _getItUnregisterCubit();
  });

  group('When VagasWidget is called', () {
    testWidgets(
        'if state IS VagasLoadedState it should display the correct number of VagaCardWidget and should NOT display any VagaCardLoadingWidget',
        (WidgetTester tester) async {
      final mockedGetVagasUseCase = MockGetVagasUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));

      final VagasCubit vagasCubit =
          VagasCubit(getVagasUseCase: mockedGetVagasUseCase);

      _getItRegisterCubit(
        vagasCubit: vagasCubit,
      );

      await _initWidget(tester);
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.byType(VagaCardWidget), findsNWidgets(3));
      expect(find.byType(VagaCardLoadingWidget), findsNothing);

      verify(mockedGetVagasUseCase.call());
    });

    testWidgets(
        'if state IS VagasLoadingState it should display two VagaCardLoadingWidget and NONE VagaCardWidget',
        (WidgetTester tester) async {
      final mockedGetVagasUseCase = MockGetVagasUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));

      final VagasCubit vagasCubit =
          VagasCubit(getVagasUseCase: mockedGetVagasUseCase);

      _getItRegisterCubit(
        vagasCubit: vagasCubit,
      );

      await _initWidget(tester);

      vagasCubit.emit(VagasLoadingState());

      await tester.pump(const Duration(milliseconds: 1));

      expect(find.byType(VagaCardLoadingWidget), findsNWidgets(4));
      expect(find.byType(VagaCardWidget), findsNothing);
    });

    testWidgets(
        'if state IS VagasErrorState it should display two VagaCardLoadingWidget and NONE VagaCardWidget',
        (WidgetTester tester) async {
      final mockedGetVagasUseCase = MockGetVagasUseCase();

      when(mockedGetVagasUseCase.call())
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      final VagasCubit vagasCubit =
          VagasCubit(getVagasUseCase: mockedGetVagasUseCase);

      _getItRegisterCubit(
        vagasCubit: vagasCubit,
      );

      await _initWidget(tester);
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.byType(VagaCardLoadingWidget), findsNWidgets(4));
      expect(find.byType(VagaCardWidget), findsNothing);

      verify(mockedGetVagasUseCase.call());
    });
  });
}
