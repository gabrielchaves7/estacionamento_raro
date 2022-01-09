import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';
import 'package:domain/src/domain/usecases/registro/create_registro_usecase.dart';
import 'package:domain/src/domain/usecases/vaga/close_vaga_usecase.dart';
import 'package:domain/src/enum/tipo_vaga_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './close_vaga_usecase_test.mocks.dart';

final Vaga vaga =
    Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1);

//Horario entrada: 08/01/2022 17:13
final DateTime horarioEntrada =
    DateTime.fromMillisecondsSinceEpoch(1641672790000);

@GenerateMocks([VagaRepository, CreateRegistroUseCase])
void main() {
  group('CloseVagaUseCase', () {
    group('When CloseVagaUseCase is called', () {
      group('And VagaRepository returns a vaga', () {
        test(
            'CloseVagaUseCase should call vagaRepository.update() and return the updated vaga',
            () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();
          final CreateRegistroUseCase mockedCreateRegistroUseCase =
              MockCreateRegistroUseCase();

          when(
            mockedVagaRepository.closeVaga(id: 'id', registroId: 'registroId1'),
          ).thenAnswer((_) async => Right(vaga));

          when(
            mockedCreateRegistroUseCase.call(placa: 'ABC1234'),
          ).thenAnswer((_) async => Right(Registro(
              id: 'registroId1',
              placa: 'ABC1234',
              horarioEntrada: horarioEntrada)));

          final CloseVagaUseCase closeVagaUseCase = CloseVagaUseCase(
              vagaRepository: mockedVagaRepository,
              createRegistroUseCase: mockedCreateRegistroUseCase);

          final result = await closeVagaUseCase(vagaId: 'id', placa: 'ABC1234');

          verify(mockedVagaRepository.closeVaga(
              id: 'id', registroId: 'registroId1'));
          verify(mockedCreateRegistroUseCase.call(placa: 'ABC1234'));
          expect(result.isRight(), true);
        });
      });

      group('And VagaRepository.closeVaga returns a failure', () {
        test('CloseVagaUseCase should return the left value', () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();
          final CreateRegistroUseCase mockedCreateRegistroUseCase =
              MockCreateRegistroUseCase();

          when(
            mockedVagaRepository.closeVaga(
                id: 'id1', registroId: 'registroId1'),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          when(
            mockedCreateRegistroUseCase.call(placa: 'ABC1234'),
          ).thenAnswer((_) async => Right(Registro(
              id: 'registroId1',
              placa: 'ABC1234',
              horarioEntrada: horarioEntrada)));

          final CloseVagaUseCase closeVagaUseCase = CloseVagaUseCase(
              vagaRepository: mockedVagaRepository,
              createRegistroUseCase: mockedCreateRegistroUseCase);

          final result =
              await closeVagaUseCase(vagaId: 'id1', placa: 'ABC1234');

          verify(mockedVagaRepository.closeVaga(
              id: 'id1', registroId: 'registroId1'));
          verify(mockedCreateRegistroUseCase.call(placa: 'ABC1234'));
          expect(result.isLeft(), true);
        });
      });

      group('And CreateRegistroUseCase returns a failure', () {
        test(
            'CloseVagaUseCase should return the left value and should not call VagaRepository.closeVaga',
            () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();
          final CreateRegistroUseCase mockedCreateRegistroUseCase =
              MockCreateRegistroUseCase();

          when(
            mockedVagaRepository.closeVaga(id: 'id', registroId: 'registroId1'),
          ).thenAnswer((_) async => Right(vaga));

          when(
            mockedCreateRegistroUseCase.call(placa: 'ABC1234'),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          final CloseVagaUseCase closeVagaUseCase = CloseVagaUseCase(
              vagaRepository: mockedVagaRepository,
              createRegistroUseCase: mockedCreateRegistroUseCase);

          final result = await closeVagaUseCase(vagaId: 'id', placa: 'ABC1234');

          verify(mockedCreateRegistroUseCase.call(placa: 'ABC1234'));
          verifyNever(mockedVagaRepository.closeVaga(
              id: 'id', registroId: 'registroId1'));
          expect(result.isLeft(), true);
        });
      });
    });
  });
}
