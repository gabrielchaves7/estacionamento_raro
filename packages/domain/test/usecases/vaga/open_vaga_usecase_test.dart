import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';
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

@GenerateMocks([VagaRepository, CreateRegistroUseCase])
void main() {
  group('OpenVagaUseCase', () {
    group('When OpenVagaUseCase is called', () {
      group('And VagaRepository returns a vaga', () {
        test(
            'OpenVagaUseCase should call vagaRepository.update() and return the updated vaga',
            () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();
          final CreateRegistroUseCase mockedCreateRegistroUseCase =
              MockCreateRegistroUseCase();

          when(
            mockedVagaRepository.update(disponivel: true, id: 'id'),
          ).thenAnswer((_) async => Right(vaga));

          when(
            mockedCreateRegistroUseCase.call(placa: 'ABC1234'),
          ).thenAnswer((_) async => Right(Registro(
              id: 'id', placa: 'ABC1234', horarioEntrada: horarioEntrada)));

          final OpenVagaUseCase openVagaUseCase = OpenVagaUseCase(
              vagaRepository: mockedVagaRepository,
              createRegistroUseCase: mockedCreateRegistroUseCase);

          final result = await openVagaUseCase(vagaId: 'id', placa: 'ABC1234');

          verify(mockedVagaRepository.update(disponivel: true, id: 'id'));
          verify(mockedCreateRegistroUseCase.call(placa: 'ABC1234'));
          expect(result.isRight(), true);
        });
      });

      group('And VagaRepository.update returns a failure', () {
        test(
            'OpenVagaUseCase should return the left value and should not call CreateRegistroUseCase',
            () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();
          final CreateRegistroUseCase mockedCreateRegistroUseCase =
              MockCreateRegistroUseCase();

          when(
            mockedVagaRepository.update(disponivel: true, id: 'id'),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          when(
            mockedCreateRegistroUseCase.call(placa: 'ABC1234'),
          ).thenAnswer((_) async => Right(Registro(
              id: 'id1', placa: 'ABC1234', horarioEntrada: horarioEntrada)));

          final OpenVagaUseCase openVagaUseCase = OpenVagaUseCase(
              vagaRepository: mockedVagaRepository,
              createRegistroUseCase: mockedCreateRegistroUseCase);

          final result = await openVagaUseCase(vagaId: 'id', placa: 'ABC1234');

          verify(mockedVagaRepository.update(disponivel: true, id: 'id'));
          verifyNever(mockedCreateRegistroUseCase.call(placa: 'ABC1234'));
          expect(result.isLeft(), true);
        });
      });

      group('And CreateRegistroUseCase returns a failure', () {
        test('OpenVagaUseCase should return the left value', () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();
          final CreateRegistroUseCase mockedCreateRegistroUseCase =
              MockCreateRegistroUseCase();

          when(
            mockedVagaRepository.update(disponivel: true, id: 'id'),
          ).thenAnswer((_) async => Right(vaga));

          when(
            mockedCreateRegistroUseCase.call(placa: 'ABC1234'),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          final OpenVagaUseCase openVagaUseCase = OpenVagaUseCase(
              vagaRepository: mockedVagaRepository,
              createRegistroUseCase: mockedCreateRegistroUseCase);

          final result = await openVagaUseCase(vagaId: 'id', placa: 'ABC1234');

          verify(mockedVagaRepository.update(disponivel: true, id: 'id'));
          verify(mockedCreateRegistroUseCase.call(placa: 'ABC1234'));
          expect(result.isLeft(), true);
        });
      });
    });
  });
}
