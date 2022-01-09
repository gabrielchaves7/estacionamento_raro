import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_enums.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/src/bloc/registro_cubit.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/pages/home_page.dart';
import 'package:ui/src/widgets/registros/registros_widget.dart';
import 'package:ui/src/widgets/vagas/vagas_widget.dart';

import './home_page_test.mocks.dart';

void _getItRegisterCubit(
    {required RegistroCubit registroCubit, required VagasCubit vagasCubit}) {
  getIt.registerFactory(() => registroCubit);
  getIt.registerFactory(() => vagasCubit);
}

void _getItUnregisterCubit() {
  getIt.unregister<RegistroCubit>();
  getIt.unregister<VagasCubit>();
}

Future<void> _initWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: HomePage(
        title: 'titulo',
      ),
    ),
  );
}

List<Registro> registros = [
  Registro(
      horarioEntrada: DateTime.fromMillisecondsSinceEpoch(1641560814000),
      id: '1',
      placa: 'PLACAA',
      horarioSaida: DateTime.fromMillisecondsSinceEpoch(1641564414000)),
  Registro(
      horarioEntrada: DateTime.fromMillisecondsSinceEpoch(1641478014000),
      id: '2',
      placa: 'PLACAB',
      horarioSaida: DateTime.fromMillisecondsSinceEpoch(1641480714000)),
  Registro(
      horarioEntrada: DateTime.fromMillisecondsSinceEpoch(1641478014000),
      id: '3',
      placa: 'PLACAC',
      horarioSaida: DateTime.fromMillisecondsSinceEpoch(1641480714000))
];

final List<Vaga> vagas = [
  Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1),
  Vaga(id: 'id', disponivel: false, tipoVaga: TipoVagaEnum.carro, numero: 2),
  Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.caminhao, numero: 3),
];

@GenerateMocks(
    [GetRegistrosUseCase, GetVagasUseCase, CloseVagaUseCase, OpenVagaUseCase])
void main() {
  tearDown(() async {
    _getItUnregisterCubit();
  });

  group('When HomePage is called', () {
    testWidgets('it should display Vagas and Registros at bottom menu',
        (WidgetTester tester) async {
      final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();
      final mockedGetVagasUseCase = MockGetVagasUseCase();
      final mockedCloseVagaUseCase = MockCloseVagaUseCase();
      final mockedOpenVagaUseCase = MockOpenVagaUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));

      final RegistroCubit registroCubit =
          RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

      final VagasCubit vagasCubit = VagasCubit(
          getVagasUseCase: mockedGetVagasUseCase,
          closeVagaUseCase: mockedCloseVagaUseCase,
          openVagaUseCase: mockedOpenVagaUseCase);

      _getItRegisterCubit(registroCubit: registroCubit, vagasCubit: vagasCubit);

      await _initWidget(tester);
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.text('Vagas'), findsOneWidget);
      expect(find.text('Registros'), findsOneWidget);
    });

    group('When Registros option at menu is clicked', () {
      testWidgets('it should display RegistrosWidget',
          (WidgetTester tester) async {
        final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();
        final mockedGetVagasUseCase = MockGetVagasUseCase();
        final mockedCloseVagaUseCase = MockCloseVagaUseCase();
        final mockedOpenVagaUseCase = MockOpenVagaUseCase();

        when(mockedGetVagasUseCase.call())
            .thenAnswer((_) async => Right(vagas));

        when(mockedGetRegistrosUseCase.call())
            .thenAnswer((_) async => Right(registros));

        final RegistroCubit registroCubit =
            RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

        final VagasCubit vagasCubit = VagasCubit(
            getVagasUseCase: mockedGetVagasUseCase,
            closeVagaUseCase: mockedCloseVagaUseCase,
            openVagaUseCase: mockedOpenVagaUseCase);

        _getItRegisterCubit(
            registroCubit: registroCubit, vagasCubit: vagasCubit);

        await _initWidget(tester);
        await tester.pump(const Duration(milliseconds: 1));

        expect(find.byType(RegistrosWidget), findsNothing);

        await tester.tap(find.text('Registros'));
        await tester.pump();

        expect(find.byType(RegistrosWidget), findsOneWidget);
      });
    });

    group('When Vagas option at menu is opened', () {
      testWidgets('it should display VagasWidget', (WidgetTester tester) async {
        final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();
        final mockedGetVagasUseCase = MockGetVagasUseCase();
        final mockedCloseVagaUseCase = MockCloseVagaUseCase();
        final mockedOpenVagaUseCase = MockOpenVagaUseCase();

        when(mockedGetVagasUseCase.call())
            .thenAnswer((_) async => Right(vagas));

        final RegistroCubit registroCubit =
            RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

        final VagasCubit vagasCubit = VagasCubit(
            getVagasUseCase: mockedGetVagasUseCase,
            closeVagaUseCase: mockedCloseVagaUseCase,
            openVagaUseCase: mockedOpenVagaUseCase);

        _getItRegisterCubit(
            registroCubit: registroCubit, vagasCubit: vagasCubit);

        await _initWidget(tester);
        await tester.pump(const Duration(milliseconds: 1));

        expect(find.byType(VagasWidget), findsOneWidget);
      });
    });
  });
}
