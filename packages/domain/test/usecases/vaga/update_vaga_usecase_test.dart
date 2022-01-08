import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';
import 'package:domain/src/domain/usecases/vaga/update_vaga_usecase.dart';
import 'package:domain/src/enum/tipo_vaga_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './update_vaga_usecase_test.mocks.dart';

final Vaga vaga =
    Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1);

@GenerateMocks([VagaRepository])
void main() {
  group('UpdateVagaUseCase', () {
    group('When UpdateVagaUseCase is called', () {
      group('And VagaRepository returns a vaga', () {
        test(
            'UpdateVagaUseCase should call vagaRepository.update() and return the updated vaga',
            () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();

          when(
            mockedVagaRepository.update(disponivel: false, id: 'id'),
          ).thenAnswer((_) async => Right(vaga));

          final UpdateVagaUseCase updateVagasUseCase =
              UpdateVagaUseCase(vagaRepository: mockedVagaRepository);

          final result = await updateVagasUseCase(disponivel: false, id: 'id');

          verify(mockedVagaRepository.update(disponivel: false, id: 'id'));
          expect(result.isRight(), true);
          result.fold((exception) => {}, (vaga) => {expect(vaga.id, 'id')});
        });
      });

      group('And VagaRepository returns a failure', () {
        test('UpdateVagaUseCase should return the left value', () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();

          when(
            mockedVagaRepository.update(disponivel: false, id: 'id'),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          final UpdateVagaUseCase updateVagasUseCase =
              UpdateVagaUseCase(vagaRepository: mockedVagaRepository);

          final result = await updateVagasUseCase(disponivel: false, id: 'id');

          verify(mockedVagaRepository.update(disponivel: false, id: 'id'));
          expect(result.isLeft(), true);
        });
      });
    });
  });
}
