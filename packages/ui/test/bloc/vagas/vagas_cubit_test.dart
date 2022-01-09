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

@GenerateMocks([GetVagasUseCase, CloseVagaUseCase, OpenVagaUseCase])
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
      final mockedOpenVagaUseCase = MockOpenVagaUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));

      final VagasCubit vagasCubit = VagasCubit(
          getVagasUseCase: mockedGetVagasUseCase,
          closeVagaUseCase: mockedCloseVagaUseCase,
          openVagaUseCase: mockedOpenVagaUseCase);

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
      final mockedOpenVagaUseCase = MockOpenVagaUseCase();

      when(mockedGetVagasUseCase.call())
          .thenAnswer((_) async => Left(UnexpectedFailure()));

      blocTest(
        'should emit VagasLoadingState and then VagasErrorState',
        build: () {
          return VagasCubit(
              getVagasUseCase: mockedGetVagasUseCase,
              closeVagaUseCase: mockedCloseVagaUseCase,
              openVagaUseCase: mockedOpenVagaUseCase);
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
      final mockedOpenVagaUseCase = MockOpenVagaUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));
      when(mockedCloseVagaUseCase.call(vagaId: 'id1', placa: 'ABCDEFG'))
          .thenAnswer(
        (_) async => Right(Vaga(
            id: 'id1',
            disponivel: false,
            tipoVaga: TipoVagaEnum.moto,
            numero: 1)),
      );
      final VagasCubit vagasCubit = VagasCubit(
          getVagasUseCase: mockedGetVagasUseCase,
          closeVagaUseCase: mockedCloseVagaUseCase,
          openVagaUseCase: mockedOpenVagaUseCase);

      blocTest(
        'should emit VagaClosedState with vagas filtered by exibirVagasDisponiveis',
        build: () {
          return vagasCubit;
        },
        act: (VagasCubit vagasCubit) async {
          await vagasCubit.getVagas();
          await vagasCubit.closeVaga(vagaId: 'id1', placa: 'ABCDEFG');
        },
        expect: () => [
          isA<VagasLoadingState>(),
          isA<VagasLoadedState>(),
          isA<VagaClosedState>()
        ],
        verify: (_) {
          final state = vagasCubit.state as VagaClosedState;
          verify(mockedCloseVagaUseCase.call(vagaId: 'id1', placa: 'ABCDEFG'));
          expect(state.vagas.length, 1);
        },
      );
    });

    group('when closeVaga is called and CloseVagaUseCase returns a failure',
        () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();
      final mockedCloseVagaUseCase = MockCloseVagaUseCase();
      final mockedOpenVagaUseCase = MockOpenVagaUseCase();

      when(mockedCloseVagaUseCase.call(vagaId: 'id1', placa: 'ABCDEFG'))
          .thenAnswer(
        (_) async => Left(UnexpectedFailure()),
      );

      blocTest(
        'should emit VagaClosedErrorState',
        build: () {
          return VagasCubit(
              getVagasUseCase: mockedGetVagasUseCase,
              closeVagaUseCase: mockedCloseVagaUseCase,
              openVagaUseCase: mockedOpenVagaUseCase);
        },
        act: (VagasCubit cubit) async {
          await cubit.closeVaga(vagaId: 'id1', placa: 'ABCDEFG');
        },
        expect: () => [
          isA<VagaClosedErrorState>(),
        ],
        verify: (_) {
          verify(mockedCloseVagaUseCase.call(vagaId: 'id1', placa: 'ABCDEFG'));
        },
      );
    });

    group('when changeExibirVagasDisponiveis is called', () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();
      final mockedCloseVagaUseCase = MockCloseVagaUseCase();
      final mockedOpenVagaUseCase = MockOpenVagaUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));

      final VagasCubit vagasCubit = VagasCubit(
          getVagasUseCase: mockedGetVagasUseCase,
          closeVagaUseCase: mockedCloseVagaUseCase,
          openVagaUseCase: mockedOpenVagaUseCase);

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

    group('when openVagas is called ', () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();
      final mockedCloseVagaUseCase = MockCloseVagaUseCase();
      final mockedOpenVagaUseCase = MockOpenVagaUseCase();

      when(mockedGetVagasUseCase.call()).thenAnswer((_) async => Right(vagas));
      when(mockedOpenVagaUseCase.call(vagaId: 'id2', registroId: 'registroId1'))
          .thenAnswer((_) async => Right(Vaga(
              id: 'id2',
              disponivel: true,
              tipoVaga: TipoVagaEnum.carro,
              numero: 2)));

      final VagasCubit vagasCubit = VagasCubit(
          getVagasUseCase: mockedGetVagasUseCase,
          closeVagaUseCase: mockedCloseVagaUseCase,
          openVagaUseCase: mockedOpenVagaUseCase);

      blocTest(
        'should emit VagaOpenedState with vagas filtered by exibirVagasDisponiveis',
        build: () {
          return vagasCubit;
        },
        act: (VagasCubit vagasCubit) async {
          await vagasCubit.getVagas();
          await vagasCubit.openVaga(vagaId: 'id2', registroId: 'registroId1');
        },
        expect: () => [
          isA<VagasLoadingState>(),
          isA<VagasLoadedState>(),
          isA<VagaOpenedState>(),
        ],
        verify: (_) {
          final state = vagasCubit.state as VagaOpenedState;
          expect(state.vagas.length, 3);
          verify(mockedOpenVagaUseCase.call(
              vagaId: 'id2', registroId: 'registroId1'));
        },
      );
    });

    group('when openVagas is called and OpenVagaUseCase returns a failure', () {
      final mockedGetVagasUseCase = MockGetVagasUseCase();
      final mockedCloseVagaUseCase = MockCloseVagaUseCase();
      final mockedOpenVagaUseCase = MockOpenVagaUseCase();

      when(mockedOpenVagaUseCase.call(vagaId: 'id1', registroId: 'registroId1'))
          .thenAnswer(
        (_) async => Left(UnexpectedFailure()),
      );

      blocTest(
        'should emit VagaOpenedErrorState',
        build: () {
          return VagasCubit(
              getVagasUseCase: mockedGetVagasUseCase,
              closeVagaUseCase: mockedCloseVagaUseCase,
              openVagaUseCase: mockedOpenVagaUseCase);
        },
        act: (VagasCubit cubit) async {
          await cubit.openVaga(vagaId: 'id1', registroId: 'registroId1');
        },
        expect: () => [
          isA<VagaOpenedErrorState>(),
        ],
        verify: (_) {
          verify(mockedOpenVagaUseCase.call(
              vagaId: 'id1', registroId: 'registroId1'));
        },
      );
    });
  });
}
