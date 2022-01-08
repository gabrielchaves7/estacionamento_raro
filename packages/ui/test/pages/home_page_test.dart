import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/src/bloc/registro_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/pages/home_page.dart';
import 'package:ui/src/widgets/registros/registros_widget.dart';

import './home_page_test.mocks.dart';

void _getItRegisterCubit({required RegistroCubit registroCubit}) {
  getIt.registerFactory(() => registroCubit);
}

void _getItUnregisterCubit() {
  getIt.unregister<RegistroCubit>();
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
      vagaId: 'vaga/klmxaskl11',
      placa: 'PLACAA',
      horarioSaida: DateTime.fromMillisecondsSinceEpoch(1641564414000)),
  Registro(
      horarioEntrada: DateTime.fromMillisecondsSinceEpoch(1641478014000),
      id: '2',
      vagaId: 'vaga/klmxaskl12',
      placa: 'PLACAB',
      horarioSaida: DateTime.fromMillisecondsSinceEpoch(1641480714000)),
  Registro(
      horarioEntrada: DateTime.fromMillisecondsSinceEpoch(1641478014000),
      id: '3',
      vagaId: 'vaga/klmxaskl13',
      placa: 'PLACAC',
      horarioSaida: DateTime.fromMillisecondsSinceEpoch(1641480714000))
];

@GenerateMocks([GetRegistrosUseCase])
void main() {
  tearDown(() async {
    _getItUnregisterCubit();
  });

  group('When HomePage is called', () {
    testWidgets('it should display Home, Vagas and Registros at bottom menu',
        (WidgetTester tester) async {
      final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

      when(mockedGetRegistrosUseCase.call())
          .thenAnswer((_) async => Right(registros));

      final RegistroCubit registroCubit =
          RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

      _getItRegisterCubit(
        registroCubit: registroCubit,
      );

      await _initWidget(tester);
      await tester.pump(const Duration(milliseconds: 1));

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Vagas'), findsOneWidget);
      expect(find.text('Registros'), findsOneWidget);
    });

    group('When Registros option at menu is clicked', () {
      testWidgets('it should display RegistrosWidget',
          (WidgetTester tester) async {
        final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

        when(mockedGetRegistrosUseCase.call())
            .thenAnswer((_) async => Right(registros));

        final RegistroCubit registroCubit =
            RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

        _getItRegisterCubit(
          registroCubit: registroCubit,
        );

        await _initWidget(tester);
        await tester.pump(const Duration(milliseconds: 1));

        expect(find.byType(RegistrosWidget), findsNothing);

        await tester.tap(find.text('Registros'));
        await tester.pump();

        expect(find.byType(RegistrosWidget), findsOneWidget);
      });
    });
  });
}
