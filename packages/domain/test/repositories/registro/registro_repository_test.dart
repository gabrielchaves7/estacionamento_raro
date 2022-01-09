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
  ),
  RegistroModel(
    id: 'id2',
    horarioEntrada: DateTime.fromMillisecondsSinceEpoch(
        Timestamp.now().millisecondsSinceEpoch),
    placa: 'XSAE12',
  ),
  RegistroModel(
    id: 'id3',
    horarioEntrada: DateTime.fromMillisecondsSinceEpoch(
        Timestamp.now().millisecondsSinceEpoch),
    placa: 'LKJASD1',
  ),
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

    group('When RegistroRepository.create is called', () {
      //Horario entrada: 08/01/2022 17:13
      final DateTime horarioEntrada =
          DateTime.fromMillisecondsSinceEpoch(1641672790000);
      group('And RegistroDataSource returns a RegistroModel', () {
        test(
            'RegistroRepository should call registroDataSource.create and return the right value',
            () async {
          final RegistroDataSource mockedRegistroDataSource =
              MockRegistroDataSource();

          when(
            mockedRegistroDataSource.create(placa: 'ABC123'),
          ).thenAnswer((_) async => RegistroModel(
              id: 'id1', horarioEntrada: horarioEntrada, placa: 'ABC123'));

          final RegistroRepository registroRepository = RegistroRepositoryImpl(
              registroDataSource: mockedRegistroDataSource);

          final result = await registroRepository.create(placa: 'ABC123');

          verify(mockedRegistroDataSource.create(placa: 'ABC123'));
          expect(result.isRight(), true);
        });
      });

      group('And RegistroDataSource throws an exception', () {
        test(
            'RegistroRepository should return the left value with UnexpectedFailure',
            () async {
          final RegistroDataSource mockedRegistroDataSource =
              MockRegistroDataSource();

          when(
            mockedRegistroDataSource.create(placa: 'ABC123'),
          ).thenThrow((_) async => Exception());

          final RegistroRepository registroRepository = RegistroRepositoryImpl(
              registroDataSource: mockedRegistroDataSource);

          final result = await registroRepository.create(placa: 'ABC123');

          verify(mockedRegistroDataSource.create(placa: 'ABC123'));
          expect(result.isLeft(), true);
          result.fold(
              (exception) => {expect(exception is UnexpectedFailure, true)},
              (registros) => {});
        });
      });
    });

    group('When RegistroRepository.updateHorarioSaida is called', () {
      //Horario entrada: 08/01/2022 17:13
      final DateTime horarioEntrada =
          DateTime.fromMillisecondsSinceEpoch(1641672790000);

      //Horario saida: 08/01/2022 23:22
      final DateTime horarioSaida =
          DateTime.fromMillisecondsSinceEpoch(1641694940000);
      group('And RegistroDataSource returns a RegistroModel', () {
        test(
            'RegistroRepository should call registroDataSource.updateHorarioSaida and return the right value',
            () async {
          final RegistroDataSource mockedRegistroDataSource =
              MockRegistroDataSource();

          when(
            mockedRegistroDataSource.updateHorarioSaida(id: 'id1'),
          ).thenAnswer((_) async => RegistroModel(
              id: 'id1',
              horarioEntrada: horarioEntrada,
              placa: 'ABC123',
              horarioSaida: horarioSaida));

          final RegistroRepository registroRepository = RegistroRepositoryImpl(
              registroDataSource: mockedRegistroDataSource);

          final result = await registroRepository.updateHorarioSaida(id: 'id1');

          verify(mockedRegistroDataSource.updateHorarioSaida(id: 'id1'));
          expect(result.isRight(), true);
        });
      });

      group('And RegistroDataSource throws an exception', () {
        test(
            'RegistroRepository should return the left value with UnexpectedFailure',
            () async {
          final RegistroDataSource mockedRegistroDataSource =
              MockRegistroDataSource();

          when(
            mockedRegistroDataSource.updateHorarioSaida(id: 'id1'),
          ).thenThrow((_) async => Exception());

          final RegistroRepository registroRepository = RegistroRepositoryImpl(
              registroDataSource: mockedRegistroDataSource);

          final result = await registroRepository.updateHorarioSaida(id: 'id1');

          verify(mockedRegistroDataSource.updateHorarioSaida(id: 'id1'));
          expect(result.isLeft(), true);
          result.fold(
              (exception) => {expect(exception is UnexpectedFailure, true)},
              (registros) => {});
        });
      });
    });
  });
}
