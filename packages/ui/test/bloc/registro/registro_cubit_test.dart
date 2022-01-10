import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_enums.dart';
import 'package:domain/estacionamento_raro_errors.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/src/bloc/registro/registro_cubit.dart';

import 'registro_cubit_test.mocks.dart';

List<Registro> mockedRegistros = [];

@GenerateMocks([GetRegistrosUseCase])
void main() {
  setUp(() {
    final DateTime now = DateTime.now();
    mockedRegistros = [
      Registro(
          id: 'id',
          horarioEntrada: now.subtract(const Duration(hours: 12)),
          placa: 'ABCDEF',
          horarioSaida: now.subtract(const Duration(hours: 11))),
      Registro(
        id: 'id2',
        horarioEntrada: now.subtract(const Duration(days: 6)),
        horarioSaida: now.subtract(const Duration(days: 5)),
        placa: 'ABCDEF2',
      ),
    ];
  });
  group('RegistroCubit', () {
    group(
        'when getRegistros is called and GetRegistrosUseCase returns a list of registros',
        () {
      final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

      when(mockedGetRegistrosUseCase.call())
          .thenAnswer((_) async => Right(mockedRegistros));

      final RegistroCubit registroCubit =
          RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

      blocTest(
        'should emit RegistroLoadingState and then RegistroLoadedState and return registros filtered by dateFilter',
        build: () {
          return registroCubit;
        },
        act: (RegistroCubit registroCubit) async {
          await registroCubit.getRegistros();
        },
        expect: () => [isA<RegistroLoadingState>(), isA<RegistroLoadedState>()],
        verify: (_) {
          verify(mockedGetRegistrosUseCase.call());
          final state = registroCubit.state as RegistroLoadedState;
          expect(state.registros.length, 1);
        },
      );
    });

    group(
        'when getRegistros is called and GetRegistrosUseCase returns a failure',
        () {
      final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

      when(mockedGetRegistrosUseCase.call())
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      blocTest(
        'should emit RegistroLoadingState and then RegistroErrorState',
        build: () {
          return RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);
        },
        act: (RegistroCubit cubit) {
          cubit.getRegistros();
        },
        expect: () => [isA<RegistroLoadingState>(), isA<RegistroErrorState>()],
        verify: (_) {
          verify(mockedGetRegistrosUseCase.call());
        },
      );
    });

    group('when updateFilterDate is called', () {
      final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

      when(mockedGetRegistrosUseCase.call())
          .thenAnswer((_) async => Right(mockedRegistros));

      final RegistroCubit registroCubit =
          RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);

      blocTest(
        'should emit RegistroLoadedState and filter by the new dateFilter value',
        build: () {
          return registroCubit;
        },
        act: (RegistroCubit cubit) async {
          await cubit.getRegistros();
          await cubit.updateFilterDate(DateFilterEnum.sevenDays);
        },
        expect: () => [
          isA<RegistroLoadingState>(),
          isA<RegistroLoadedState>(),
          isA<RegistroLoadedState>()
        ],
        verify: (_) {
          final state = registroCubit.state as RegistroLoadedState;
          expect(state.registros.length, 2);
        },
      );
    });
  });
}
