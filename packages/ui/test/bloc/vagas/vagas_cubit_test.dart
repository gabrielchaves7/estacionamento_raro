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

List<Vaga> vagas = [];

@GenerateMocks([GetVagasUseCase, CloseVagaUseCase])
void main() {
  setUp(() {
    vagas = [
      Vaga(id: 'id1', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1),
      Vaga(
          id: 'id2',
          disponivel: false,
          tipoVaga: TipoVagaEnum.carro,
          numero: 2),
      Vaga(
          id: 'id3',
          disponivel: true,
          tipoVaga: TipoVagaEnum.caminhao,
          numero: 3),
    ];
  });

  group('VagasCubit', () {
    group(
        'when getVagas is called and GetVagasUseCase returns a list of vagas filtered by exibirVagasDisponiveis',
        () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();
      final mockedCloseVagaUseCase = MockCloseVagaUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));

      final VagasCubit vagasCubit = VagasCubit(
          getVagasUseCase: mockedGetVagasUseCase,
          closeVagaUseCase: mockedCloseVagaUseCase);

      blocTest(
        'should emit VagasLoadingState and then VagasLoadedState',
        build: () {
          return vagasCubit;
        },
        act: (VagasCubit cubit) async {
          cubit.getVagas();
        },
        expect: () => [isA<VagasLoadingState>(), isA<VagasLoadedState>()],
        verify: (_) {
          final state = vagasCubit.state as VagasLoadedState;

          verify(mockedGetVagasUseCase.call());
          expect(state.vagas.length, equals(2));
        },
      );
    });

    group('when getVagas is called and GetVagasUseCase returns a failure', () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();
      final mockedCloseVagaUseCase = MockCloseVagaUseCase();

      when(mockedGetVagasUseCase.call())
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      blocTest(
        'should emit VagasLoadingState and then VagasErrorState',
        build: () {
          return VagasCubit(
              getVagasUseCase: mockedGetVagasUseCase,
              closeVagaUseCase: mockedCloseVagaUseCase);
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

    group('when closeVaga is called and CloseVagaUseCase returns a vaga', () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();
      final mockedCloseVagaUseCase = MockCloseVagaUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));
      when(mockedCloseVagaUseCase.call(id: 'id1')).thenAnswer(
        (_) async => Right(Vaga(
            id: 'id1',
            disponivel: false,
            tipoVaga: TipoVagaEnum.moto,
            numero: 1)),
      );
      final VagasCubit vagasCubit = VagasCubit(
          getVagasUseCase: mockedGetVagasUseCase,
          closeVagaUseCase: mockedCloseVagaUseCase);

      blocTest(
        'should emit VagaClosedState with vagas filtered by exibirVagasDisponiveis',
        build: () {
          return vagasCubit;
        },
        act: (VagasCubit vagasCubit) async {
          await vagasCubit.getVagas();
          await vagasCubit.closeVaga(id: 'id1');
        },
        expect: () => [
          isA<VagasLoadingState>(),
          isA<VagasLoadedState>(),
          isA<VagaClosedState>()
        ],
        verify: (_) {
          final state = vagasCubit.state as VagaClosedState;
          verify(mockedCloseVagaUseCase.call(id: 'id1'));
          expect(state.vagas.length, 1);
        },
      );
    });

    group('when closeVaga is called and CloseVagaUseCase returns a failure',
        () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();
      final mockedCloseVagaUseCase = MockCloseVagaUseCase();

      when(mockedCloseVagaUseCase.call(id: 'id1')).thenAnswer(
        (_) async => Left(UnexpectedFailure()),
      );

      blocTest(
        'should emit VagaClosedErrorState',
        build: () {
          return VagasCubit(
              getVagasUseCase: mockedGetVagasUseCase,
              closeVagaUseCase: mockedCloseVagaUseCase);
        },
        act: (VagasCubit cubit) async {
          await cubit.closeVaga(id: 'id1');
        },
        expect: () => [
          isA<VagaClosedErrorState>(),
        ],
        verify: (_) {
          verify(mockedCloseVagaUseCase.call(id: 'id1'));
        },
      );
    });

    group('when changeExibirVagasDisponiveis is called', () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();
      final mockedCloseVagaUseCase = MockCloseVagaUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));

      final VagasCubit vagasCubit = VagasCubit(
          getVagasUseCase: mockedGetVagasUseCase,
          closeVagaUseCase: mockedCloseVagaUseCase);

      blocTest(
        'should emit VagasLoadedState filtered by the new exibirVagasDisponiveisValue',
        build: () {
          return vagasCubit;
        },
        act: (VagasCubit vagasCubit) async {
          await vagasCubit.getVagas();
          await vagasCubit.changeExibirVagasDisponiveis(
              exibirVagasDisponiveis: false);
        },
        expect: () => [
          isA<VagasLoadingState>(),
          isA<VagasLoadedState>(),
          isA<VagasLoadedState>(),
        ],
        verify: (_) {
          final state = vagasCubit.state as VagasLoadedState;
          expect(state.vagas.length, 1);
        },
      );
    });
  });
}
