import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';
import 'package:domain/src/domain/usecases/registro/update_horario_saida_usecase.dart';
import 'package:domain/src/domain/usecases/vaga/open_vaga_usecase.dart';
import 'package:domain/src/enum/tipo_vaga_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './open_vaga_usecase_test.mocks.dart';

final Vaga vaga =
    Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1);

//Horario entrada: 08/01/2022 17:13
final DateTime horarioEntrada =
    DateTime.fromMillisecondsSinceEpoch(1641672790000);

//Horario entrada: 09/01/2022 16:27
final DateTime horarioSaida =
    DateTime.fromMillisecondsSinceEpoch(1641756454000);

@GenerateMocks([VagaRepository, UpdateHorarioSaidaUseCase])
void main() {
  group('OpenVagaUseCase', () {
    group('When OpenVagaUseCase is called', () {
      group('And VagaRepository returns a vaga', () {
        test(
            'OpenVagaUseCase should call vagaRepository.openVaga() and UpdateHorarioSaidaUseCase and return the updated vaga',
            () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();
          final UpdateHorarioSaidaUseCase mockedUpdateHorarioSaidaUseCase =
              MockUpdateHorarioSaidaUseCase();

          when(
            mockedVagaRepository.openVaga(id: 'id'),
          ).thenAnswer((_) async => Right(vaga));

          when(
            mockedUpdateHorarioSaidaUseCase.call(id: 'registroId'),
          ).thenAnswer((_) async => Right(Registro(
              id: 'registroId',
              placa: 'ABC1234',
              horarioEntrada: horarioEntrada,
              horarioSaida: horarioSaida)));

          final OpenVagaUseCase openVagaUseCase = OpenVagaUseCase(
              vagaRepository: mockedVagaRepository,
              updateHorarioSaidaUseCase: mockedUpdateHorarioSaidaUseCase);

          final result =
              await openVagaUseCase(vagaId: 'id', registroId: 'registroId');

          verify(mockedVagaRepository.openVaga(id: 'id'));
          verify(mockedUpdateHorarioSaidaUseCase.call(id: 'registroId'));
          expect(result.isRight(), true);
          result.fold((exception) => {}, (vaga) => {expect(vaga.id, 'id')});
        });
      });

      group('And VagaRepository returns a failure', () {
        test('OpenVagaUseCase should return the left value', () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();
          final UpdateHorarioSaidaUseCase mockedUpdateHorarioSaidaUseCase =
              MockUpdateHorarioSaidaUseCase();

          when(
            mockedVagaRepository.openVaga(id: 'id'),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          when(
            mockedUpdateHorarioSaidaUseCase.call(id: 'registroId'),
          ).thenAnswer((_) async => Right(Registro(
              id: 'registroId',
              placa: 'ABC1234',
              horarioEntrada: horarioEntrada,
              horarioSaida: horarioSaida)));

          final OpenVagaUseCase openVagaUseCase = OpenVagaUseCase(
              vagaRepository: mockedVagaRepository,
              updateHorarioSaidaUseCase: mockedUpdateHorarioSaidaUseCase);

          final result =
              await openVagaUseCase(vagaId: 'id', registroId: 'registroId');

          verify(mockedUpdateHorarioSaidaUseCase.call(id: 'registroId'));
          verify(mockedVagaRepository.openVaga(id: 'id'));
          expect(result.isLeft(), true);
        });
      });

      group('And UpdateHorarioSaidaUseCase returns a failure', () {
        test(
            'OpenVagaUseCase should return the left value and should NOT call vagaRepository.openVaga',
            () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();
          final UpdateHorarioSaidaUseCase mockedUpdateHorarioSaidaUseCase =
              MockUpdateHorarioSaidaUseCase();

          when(
            mockedVagaRepository.openVaga(id: 'id'),
          ).thenAnswer((_) async => Right(vaga));

          when(
            mockedUpdateHorarioSaidaUseCase.call(id: 'registroId'),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          final OpenVagaUseCase openVagaUseCase = OpenVagaUseCase(
              vagaRepository: mockedVagaRepository,
              updateHorarioSaidaUseCase: mockedUpdateHorarioSaidaUseCase);

          final result =
              await openVagaUseCase(vagaId: 'id', registroId: 'registroId');

          verify(mockedUpdateHorarioSaidaUseCase.call(id: 'registroId'));
          verifyNever(mockedVagaRepository.openVaga(id: 'id'));
          expect(result.isLeft(), true);
        });
      });
    });
  });
}
