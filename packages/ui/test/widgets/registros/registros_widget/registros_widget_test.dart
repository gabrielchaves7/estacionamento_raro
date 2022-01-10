import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_enums.dart';
import 'package:domain/estacionamento_raro_errors.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/src/bloc/registro/registro_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/registros/registro_card_widget.dart';
import 'package:ui/src/widgets/registros/registros_widget.dart';

import 'registros_widget_test.mocks.dart';

void _getItRegisterCubit({required RegistroCubit registroCubit}) {
  getIt.registerFactory(() => registroCubit);
}

void _getItUnregisterCubit() {
  getIt.unregister<RegistroCubit>();
}

Future<void> _initWidget(
    WidgetTester tester, RegistroCubit registroCubit) async {
  await registroCubit.getRegistros();

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => registroCubit,
          child: RegistrosWidget(),
        ),
      ),
    ),
  );
}

final DateTime now = DateTime.now();

List<Registro> registros = [
  //registro do mesmo dia
  Registro(
      horarioEntrada: now.subtract(const Duration(hours: 12)),
      id: '1',
      placa: 'PLACAA',
      horarioSaida: now.subtract(const Duration(hours: 11))),
  //registro 2 do mesmo dia
  Registro(
      horarioEntrada: now.subtract(const Duration(hours: 7)),
      id: '12',
      placa: 'PLACAaaa',
      horarioSaida: now.subtract(const Duration(hours: 5))),
  //registro de um dia diferente
  Registro(
      horarioEntrada: now.subtract(const Duration(hours: 27)),
      id: '2',
      placa: 'PLACAB',
      horarioSaida: now.subtract(const Duration(hours: 25))),
  //registro de cinco dias atras
  Registro(
      horarioEntrada: now.subtract(const Duration(days: 6)),
      id: '3',
      placa: 'PLACAC',
      horarioSaida: now.subtract(const Duration(days: 5))),
  //registro de 20 dias atras
  Registro(
      horarioEntrada: now.subtract(const Duration(days: 15)),
      id: '3',
      placa: 'PLACAC',
      horarioSaida: now.subtract(const Duration(days: 10))),
];

@GenerateMocks([GetRegistrosUseCase])
void main() {
  tearDown(() async {
    _getItUnregisterCubit();
  });

  group('When RegistrosWidget is called and dateFilter is for oneDay', () {
    group('And dateFilter is for oneDay', () {
      testWidgets(
          'if state IS RegistroLoadedState it should display the correct number of RegistroCardWidget and should NOT display any RegistroCardLoadingWidget',
          (WidgetTester tester) async {
        final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

        when(mockedGetRegistrosUseCase.call())
            .thenAnswer((_) async => Right(registros));

        final RegistroCubit registroCubit =
            RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

        _getItRegisterCubit(
          registroCubit: registroCubit,
        );

        await _initWidget(tester, registroCubit);
        await tester.pump(const Duration(milliseconds: 1));

        expect(find.byType(RegistroCardWidget), findsNWidgets(2));
        expect(find.byType(RegistroCardLoadingWidget), findsNothing);

        verify(mockedGetRegistrosUseCase.call());
      });

      testWidgets(
          'if state IS RegistroLoadingState it should display two RegistroCardLoadingWidget and NONE RegistroCardWidget',
          (WidgetTester tester) async {
        final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

        when(mockedGetRegistrosUseCase.call())
            .thenAnswer((_) async => Right(registros));

        final RegistroCubit registroCubit =
            RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

        _getItRegisterCubit(
          registroCubit: registroCubit,
        );

        await _initWidget(tester, registroCubit);

        registroCubit.emit(RegistroLoadingState());

        await tester.pump(const Duration(milliseconds: 1));

        expect(find.byType(RegistroCardLoadingWidget), findsNWidgets(2));
        expect(find.byType(RegistroCardWidget), findsNothing);
      });

      testWidgets(
          'if state IS RegistroErrorState it should display two RegistroCardLoadingWidget and NONE RegistroCardWidget and should display error message',
          (WidgetTester tester) async {
        final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

        when(mockedGetRegistrosUseCase.call())
            .thenAnswer((_) async => Left(UnexpectedFailure()));

        final RegistroCubit registroCubit =
            RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

        _getItRegisterCubit(
          registroCubit: registroCubit,
        );

        await _initWidget(tester, registroCubit);
        await tester.pump(const Duration(milliseconds: 1));

        expect(find.byType(RegistroCardLoadingWidget), findsNWidgets(2));
        expect(find.byType(RegistroCardWidget), findsNothing);
        expect(find.text('Ocorreu um erro ao buscar os registros.'),
            findsOneWidget);
        expect(find.text('Deslize para baixo para atualizar.'), findsOneWidget);

        verify(mockedGetRegistrosUseCase.call());
      });
    });
    testWidgets(
        'And dateFilter is for three days It should display the correct number of RegistroCardWidget',
        (WidgetTester tester) async {
      final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

      when(mockedGetRegistrosUseCase.call())
          .thenAnswer((_) async => Right(registros));

      final RegistroCubit registroCubit =
          RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

      _getItRegisterCubit(
        registroCubit: registroCubit,
      );

      await registroCubit.updateFilterDate(DateFilterEnum.threeDays);
      await _initWidget(tester, registroCubit);
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.byType(RegistroCardWidget), findsNWidgets(3));
    });

    testWidgets(
        'And dateFilter is for seven days It should display the correct number of RegistroCardWidget',
        (WidgetTester tester) async {
      final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

      when(mockedGetRegistrosUseCase.call())
          .thenAnswer((_) async => Right(registros));

      final RegistroCubit registroCubit =
          RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

      _getItRegisterCubit(
        registroCubit: registroCubit,
      );

      await registroCubit.updateFilterDate(DateFilterEnum.sevenDays);
      await _initWidget(tester, registroCubit);
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.byType(RegistroCardWidget), findsNWidgets(4));
    });

    testWidgets(
        'And dateFilter is for thirty days It should display the correct number of RegistroCardWidget',
        (WidgetTester tester) async {
      final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

      when(mockedGetRegistrosUseCase.call())
          .thenAnswer((_) async => Right(registros));

      final RegistroCubit registroCubit =
          RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

      _getItRegisterCubit(
        registroCubit: registroCubit,
      );

      await registroCubit.updateFilterDate(DateFilterEnum.thirtyDays);
      await _initWidget(tester, registroCubit);
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.byType(RegistroCardWidget), findsNWidgets(5));
    });
  });
}
