import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/data/datasource/registro/registro_datasource_impl.dart';
import 'package:domain/src/data/models/registro/registro_model.dart';
import 'package:domain/src/data/repositories/registro/registro_repository_impl.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/registro/registro_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'registro_repository_test.mocks.dart';

final List<RegistroModel> mockedRegistros = [
  RegistroModel(
      id: 'id',
      horarioEntrada: DateTime.fromMillisecondsSinceEpoch(
          Timestamp.now().millisecondsSinceEpoch),
      placa: '1234FGH',
      vagaId: 'vagas/FONITY'),
  RegistroModel(
      id: 'id2',
      horarioEntrada: DateTime.fromMillisecondsSinceEpoch(
          Timestamp.now().millisecondsSinceEpoch),
      placa: 'XSAE12',
      vagaId: 'vagas/OOFNEO'),
  RegistroModel(
      id: 'id3',
      horarioEntrada: DateTime.fromMillisecondsSinceEpoch(
          Timestamp.now().millisecondsSinceEpoch),
      placa: 'LKJASD1',
      vagaId: 'vagas/LALALA'),
];

@GenerateMocks([RegistroDataSource])
void main() {
  group('RegistroRepository', () {
    group('When RegistroRepository.all is called', () {
      group('And RegistroDataSource returns an array of RegistroModel', () {
        test('RegistroRepository should return an array of RegistroEntity',
            () async {
          final RegistroDataSource mockedRegistroDataSource =
              MockRegistroDataSource();

          when(
            mockedRegistroDataSource.all(),
          ).thenAnswer((_) async => mockedRegistros);

          final RegistroRepository registroRepository = RegistroRepositoryImpl(
              registroDataSource: mockedRegistroDataSource);

          final result = await registroRepository.all();

          verify(mockedRegistroDataSource.all());
          expect(result.isRight(), true);
          result.fold(
              (exception) => {}, (registros) => {expect(registros.length, 3)});
        });
      });

      group('And RegistroDataSource returns an empty array or null', () {
        test(
            'RegistroRepository should return the left value with UnexpectedValue',
            () async {
          final RegistroDataSource mockedRegistroDataSource =
              MockRegistroDataSource();

          when(
            mockedRegistroDataSource.all(),
          ).thenAnswer((_) async => []);

          final RegistroRepository registroRepository = RegistroRepositoryImpl(
              registroDataSource: mockedRegistroDataSource);

          final result = await registroRepository.all();

          verify(mockedRegistroDataSource.all());
          expect(result.isLeft(), true);
          result.fold(
              (exception) => {expect(exception is UnexpectedValue, true)},
              (registros) => {});
        });
      });

      group('And RegistroDataSource throws an exception', () {
        test(
            'RegistroRepository should return the left value with UnexpectedFailure',
            () async {
          final RegistroDataSource mockedRegistroDataSource =
              MockRegistroDataSource();

          when(
            mockedRegistroDataSource.all(),
          ).thenThrow((_) async => Exception());

          final RegistroRepository registroRepository = RegistroRepositoryImpl(
              registroDataSource: mockedRegistroDataSource);

          final result = await registroRepository.all();

          verify(mockedRegistroDataSource.all());
          expect(result.isLeft(), true);
          result.fold(
              (exception) => {expect(exception is UnexpectedFailure, true)},
              (registros) => {});
        });
      });
    });
  });
}
