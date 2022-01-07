import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/registro_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './get_registros_usecase_test.mocks.dart';

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

@GenerateMocks([RegistroRepository])
void main() {
  group('GetRegistrosUseCase', () {
    group('When GetRegistrosUseCase is called', () {
      group('And RegistroRepository returns an array of registros', () {
        test(
            'GetRegistrosUseCase should call registroRepository.all() and return the right array',
            () async {
          final RegistroRepository mockedRegistroRepository =
              MockRegistroRepository();

          when(
            mockedRegistroRepository.all(),
          ).thenAnswer((_) async => Right(mockedRegistros));

          final GetRegistrosUseCase getRegistrosUseCase =
              GetRegistrosUseCase(registroRepository: mockedRegistroRepository);

          final result = await getRegistrosUseCase();

          verify(mockedRegistroRepository.all());
          expect(result.isRight(), true);
          result.fold(
              (exception) => {}, (registros) => {expect(registros.length, 2)});
        });
      });

      group('And RegistroRepository returns a failure', () {
        test('GetRegistrosUseCase should return the left value', () async {
          final RegistroRepository mockedRegistroRepository =
              MockRegistroRepository();

          when(
            mockedRegistroRepository.all(),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          final GetRegistrosUseCase getRegistrosUseCase =
              GetRegistrosUseCase(registroRepository: mockedRegistroRepository);

          final result = await getRegistrosUseCase();

          verify(mockedRegistroRepository.all());
          expect(result.isLeft(), true);
        });
      });
    });
  });
}
