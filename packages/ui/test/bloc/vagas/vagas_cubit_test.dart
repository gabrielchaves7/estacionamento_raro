import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_enums.dart';
import 'package:domain/estacionamento_raro_errors.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';

import './vagas_cubit_test.mocks.dart';

final List<Vaga> vagas = [
  Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1),
  Vaga(id: 'id', disponivel: false, tipoVaga: TipoVagaEnum.carro, numero: 2),
  Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.caminhao, numero: 3),
];

@GenerateMocks([GetVagasUseCase])
void main() {
  group('VagasCubit', () {
    group('when getVagas is called and GetVagasUseCase returns a list of vagas',
        () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));

      final VagasCubit vagasCubit =
          VagasCubit(getVagasUseCase: mockedGetVagasUseCase);

      blocTest(
        'should emit VagasLoadingState and then VagasLoadedState',
        build: () {
          return vagasCubit;
        },
        act: (VagasCubit cubit) {
          cubit.getVagas();
        },
        expect: () => [isA<VagasLoadingState>(), isA<VagasLoadedState>()],
        verify: (_) {
          verify(mockedGetVagasUseCase.call());

          expect(vagasCubit.vagasDisponiveis.length, 2);
        },
      );
    });

    group('when getVagas is called and GetVagasUseCase returns a failure', () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();

      when(mockedGetVagasUseCase.call())
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      blocTest(
        'should emit RegistroLoadingState and then RegistroErrorState',
        build: () {
          return VagasCubit(getVagasUseCase: mockedGetVagasUseCase);
        },
        act: (VagasCubit cubit) {
          cubit.getVagas();
        },
        expect: () => [isA<VagasLoadingState>(), isA<VagasErrorState>()],
        verify: (_) {
          verify(mockedGetVagasUseCase.call());
        },
      );
    });
  });
}
