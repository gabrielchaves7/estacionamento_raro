import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_errors.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/src/bloc/registro_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/registros/registro_card_widget.dart';
import 'package:ui/src/widgets/registros/registros_widget.dart';
import 'package:intl/date_symbol_data_local.dart';

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

@GenerateMocks([GetRegistrosUseCase])
void main() {
  setUpAll(() async => await initializeDateFormatting('pt_BR', null));

  tearDown(() async {
    _getItUnregisterCubit();
  });

  group('When RegistrosWidget is called', () {
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

      expect(find.byType(RegistroCardWidget), findsNWidgets(3));
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
      expect(
          find.text('Ocorreu um erro ao buscar os registros.'), findsOneWidget);
      expect(find.text('Deslize para baixo para atualizar.'), findsOneWidget);

      verify(mockedGetRegistrosUseCase.call());
    });
  });
}
