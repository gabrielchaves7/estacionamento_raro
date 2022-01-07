import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_errors.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/src/bloc/registro_cubit.dart';

import './registro_cubit_test.mocks.dart';

final List<Registro> mockedRegistros = [
  Registro(
      id: 'id',
      horarioEntrada: DateTime.now(),
      placa: 'ABCDEF',
      vagaId: 'vagas/EALKSM123'),
  Registro(
      id: 'id2',
      horarioEntrada: DateTime.now(),
      placa: 'ABCDEF2',
      vagaId: 'vagas/DSALKJ32'),
];

@GenerateMocks([GetRegistrosUseCase])
void main() {
  group('RegistroCubit', () {
    group(
        'when getRegistros is called and GetRegistrosUseCase returns a list of registros',
        () {
      final mockedGetRegistrosUseCase = MockGetRegistrosUseCase();

      when(mockedGetRegistrosUseCase.call())
          .thenAnswer((_) async => Right(mockedRegistros));

      blocTest(
        'should emit RegistroLoadingState and then RegistroLoadedState',
        build: () {
          return RegistroCubit(getRegistrosUseCase: mockedGetRegistrosUseCase);
        },
        act: (RegistroCubit cubit) {
          cubit.getRegistros();
        },
        expect: () => [isA<RegistroLoadingState>(), isA<RegistroLoadedState>()],
        verify: (_) {
          verify(mockedGetRegistrosUseCase.call());
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
  });
}
