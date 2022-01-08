import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/registro/registro_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './create_registro_usecase_test.mocks.dart';

//Horario entrada: 08/01/2022 17:13
final DateTime horarioEntrada =
    DateTime.fromMillisecondsSinceEpoch(1641672790000);

@GenerateMocks([RegistroRepository])
void main() {
  group('CreateRegistroUseCase', () {
    group('When CreateRegistroUseCase is called', () {
      group('And RegistroRepository returns a Registro', () {
        test(
            'CreateRegistroUseCase should call registroRepository.create() and return the new registro created',
            () async {
          final RegistroRepository mockedRegistroRepository =
              MockRegistroRepository();

          when(
            mockedRegistroRepository.create(
                horarioEntrada: horarioEntrada, placa: 'ABCDEFG'),
          ).thenAnswer((_) async => Right(Registro(
              id: 'id1', horarioEntrada: horarioEntrada, placa: 'ABCDEFG')));

          final CreateRegistroUseCase createRegistroUseCase =
              CreateRegistroUseCase(
                  registroRepository: mockedRegistroRepository);

          final result = await createRegistroUseCase(
              horarioEntrada: horarioEntrada, placa: 'ABCDEFG');

          verify(mockedRegistroRepository.create(
              horarioEntrada: horarioEntrada, placa: 'ABCDEFG'));
          expect(result.isRight(), true);
          result.fold((exception) => {},
              (registro) => {expect(registro.placa, 'ABCDEFG')});
        });
      });

      group('And RegistroRepository returns a failure', () {
        test('CreateRegistroUseCase should return the left value', () async {
          final RegistroRepository mockedRegistroRepository =
              MockRegistroRepository();

          when(
            mockedRegistroRepository.create(
                horarioEntrada: horarioEntrada, placa: 'ABDEFG'),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          final CreateRegistroUseCase createRegistroUseCase =
              CreateRegistroUseCase(
                  registroRepository: mockedRegistroRepository);

          final result = await createRegistroUseCase(
              horarioEntrada: horarioEntrada, placa: 'ABDEFG');

          verify(mockedRegistroRepository.create(
              horarioEntrada: horarioEntrada, placa: 'ABDEFG'));
          expect(result.isLeft(), true);
        });
      });
    });
  });
}
