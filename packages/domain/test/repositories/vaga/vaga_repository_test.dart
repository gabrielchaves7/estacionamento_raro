import 'package:domain/src/data/datasource/vaga/vaga_datasource_impl.dart';
import 'package:domain/src/data/models/vaga/vaga_model.dart';
import 'package:domain/src/data/repositories/vaga/vaga_repository_impl.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';
import 'package:domain/src/enum/tipo_vaga_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './vaga_repository_test.mocks.dart';

final List<VagaModel> mockedVagas = [
  VagaModel(
      id: 'id1', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1),
  VagaModel(
      id: 'id2', disponivel: false, tipoVaga: TipoVagaEnum.carro, numero: 2),
  VagaModel(
      id: 'id3', disponivel: true, tipoVaga: TipoVagaEnum.caminhao, numero: 3),
];

@GenerateMocks([VagaDataSource])
void main() {
  group('VagaReposoritory', () {
    group('When VagaReposoritory.all is called', () {
      group('And VagaDataSource returns an array of VagaModel', () {
        test('VagaReposoritory should return an array of VagaEntity', () async {
          final VagaDataSource mockedVagaDataSource = MockVagaDataSource();

          when(
            mockedVagaDataSource.all(),
          ).thenAnswer((_) async => mockedVagas);

          final VagaRepository vagaRepository =
              VagaRepositoryImpl(vagaDataSource: mockedVagaDataSource);

          final result = await vagaRepository.all();

          verify(mockedVagaDataSource.all());
          expect(result.isRight(), true);
          result.fold((exception) => {}, (vagas) => {expect(vagas.length, 3)});
        });
      });

      group('And VagaDataSource returns an empty array or null', () {
        test(
            'VagaReposoritory should return the left value with UnexpectedValue',
            () async {
          final VagaDataSource mockedVagaDataSource = MockVagaDataSource();

          when(
            mockedVagaDataSource.all(),
          ).thenAnswer((_) async => []);

          final VagaRepository vagaRepository =
              VagaRepositoryImpl(vagaDataSource: mockedVagaDataSource);

          final result = await vagaRepository.all();

          verify(mockedVagaDataSource.all());
          expect(result.isLeft(), true);
          result.fold(
              (exception) => {expect(exception is UnexpectedValue, true)},
              (registros) => {});
        });
      });

      group('And VagaDataSource throws an exception', () {
        test(
            'VagaReposoritory should return the left value with UnexpectedFailure',
            () async {
          final VagaDataSource mockedVagaDataSource = MockVagaDataSource();

          when(
            mockedVagaDataSource.all(),
          ).thenThrow((_) async => Exception());

          final VagaRepository vagaRepository =
              VagaRepositoryImpl(vagaDataSource: mockedVagaDataSource);

          final result = await vagaRepository.all();

          verify(mockedVagaDataSource.all());
          expect(result.isLeft(), true);
          result.fold(
              (exception) => {expect(exception is UnexpectedFailure, true)},
              (registros) => {});
        });
      });
    });

    group('When VagaReposoritory.openVaga is called', () {
      test(
          'And VagaDataSource returns a VagaModel, VagaReposoritory should return a VagaEntity',
          () async {
        final VagaDataSource mockedVagaDataSource = MockVagaDataSource();

        when(
          mockedVagaDataSource.update(disponivel: true, id: 'id1'),
        ).thenAnswer((_) async => mockedVagas.first);

        final VagaRepository vagaRepository =
            VagaRepositoryImpl(vagaDataSource: mockedVagaDataSource);

        final result = await vagaRepository.openVaga(id: 'id1');

        verify(mockedVagaDataSource.update(disponivel: true, id: 'id1'));
        expect(result.isRight(), true);
        result.fold((exception) => {}, (vaga) => {expect(vaga.id, 'id1')});
      });

      test(
          'And VagaDataSource throws an exception VagaReposoritory should return the left value with UnexpectedFailure',
          () async {
        final VagaDataSource mockedVagaDataSource = MockVagaDataSource();

        when(
          mockedVagaDataSource.update(disponivel: true, id: 'id1'),
        ).thenThrow((_) async => Exception());

        final VagaRepository vagaRepository =
            VagaRepositoryImpl(vagaDataSource: mockedVagaDataSource);

        final result = await vagaRepository.openVaga(id: 'id1');

        verify(mockedVagaDataSource.update(disponivel: true, id: 'id1'));
        expect(result.isLeft(), true);
        result.fold(
            (exception) => {expect(exception is UnexpectedFailure, true)},
            (registros) => {});
      });
    });

    group('When VagaReposoritory.closeVaga is called', () {
      test(
          'And VagaDataSource returns a VagaModel, VagaReposoritory should return a VagaEntity',
          () async {
        final VagaDataSource mockedVagaDataSource = MockVagaDataSource();

        when(
          mockedVagaDataSource.update(
              disponivel: false, id: 'id1', registroId: 'registroId1'),
        ).thenAnswer((_) async => mockedVagas.first);

        final VagaRepository vagaRepository =
            VagaRepositoryImpl(vagaDataSource: mockedVagaDataSource);

        final result = await vagaRepository.closeVaga(
            id: 'id1', registroId: 'registroId1');

        verify(mockedVagaDataSource.update(
            disponivel: false, id: 'id1', registroId: 'registroId1'));
        expect(result.isRight(), true);
        result.fold((exception) => {}, (vaga) {
          expect(vaga.id, 'id1');
        });
      });

      test(
          'And VagaDataSource throws an exception VagaReposoritory should return the left value with UnexpectedFailure',
          () async {
        final VagaDataSource mockedVagaDataSource = MockVagaDataSource();

        when(
          mockedVagaDataSource.update(
              disponivel: false, id: 'id1', registroId: 'registroId1'),
        ).thenThrow((_) async => Exception());

        final VagaRepository vagaRepository =
            VagaRepositoryImpl(vagaDataSource: mockedVagaDataSource);

        final result = await vagaRepository.closeVaga(
            id: 'id1', registroId: 'registroId1');

        verify(mockedVagaDataSource.update(
            disponivel: false, id: 'id1', registroId: 'registroId1'));
        expect(result.isLeft(), true);
        result.fold((exception) {
          expect(exception is UnexpectedFailure, true);
        }, (registros) => {});
      });
    });
  });
}
