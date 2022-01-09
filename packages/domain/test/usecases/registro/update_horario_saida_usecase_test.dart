import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/registro/registro_repository.dart';
import 'package:domain/src/domain/usecases/registro/update_horario_saida_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_registros_usecase_test.mocks.dart';

@GenerateMocks([RegistroRepository])
void main() {
  group('UpdateHorarioSaidaUseCase', () {
    group('When UpdateHorarioSaidaUseCase is called', () {
      group('And RegistroRepository returns the updated registro', () {
        test(
            'UpdateHorarioSaidaUseCase should call registroRepository.update() and return the updated registro',
            () async {
          final RegistroRepository mockedRegistroRepository =
              MockRegistroRepository();

          when(
            mockedRegistroRepository.updateHorarioSaida(id: 'id'),
          ).thenAnswer((_) async => Right(Registro(
                id: 'id',
                horarioEntrada: DateTime.now(),
                placa: 'ABCDEF',
              )));

          final UpdateHorarioSaidaUseCase updateHorarioSaidaUseCase =
              UpdateHorarioSaidaUseCase(
                  registroRepository: mockedRegistroRepository);

          final result = await updateHorarioSaidaUseCase(id: 'id');

          verify(mockedRegistroRepository.updateHorarioSaida(id: 'id'));
          expect(result.isRight(), true);
          result.fold((exception) => {}, (registro) {
            expect(registro.id, 'id');
            expect(registro.placa, 'ABCDEF');
          });
        });
      });

      group('And RegistroRepository returns a failure', () {
        test('UpdateHorarioSaidaUseCase should return the left value',
            () async {
          final RegistroRepository mockedRegistroRepository =
              MockRegistroRepository();

          when(
            mockedRegistroRepository.updateHorarioSaida(id: 'id'),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          final UpdateHorarioSaidaUseCase updateHorarioSaidaUseCase =
              UpdateHorarioSaidaUseCase(
                  registroRepository: mockedRegistroRepository);

          final result = await updateHorarioSaidaUseCase(id: 'id');

          verify(mockedRegistroRepository.updateHorarioSaida(id: 'id'));
          expect(result.isLeft(), true);
        });
      });
    });
  });
}
