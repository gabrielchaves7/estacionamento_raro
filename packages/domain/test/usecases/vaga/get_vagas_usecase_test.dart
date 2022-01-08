import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';
import 'package:domain/src/domain/usecases/vaga/get_vagas_usecase.dart';
import 'package:domain/src/enum/tipo_vaga_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './get_vagas_usecase_test.mocks.dart';

final List<Vaga> vagas = [
  Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.moto, numero: 1),
  Vaga(id: 'id', disponivel: false, tipoVaga: TipoVagaEnum.carro, numero: 2),
  Vaga(id: 'id', disponivel: true, tipoVaga: TipoVagaEnum.caminhao, numero: 3),
];

@GenerateMocks([VagaRepository])
void main() {
  group('GetVagasUseCase', () {
    group('When GetVagasUseCase is called', () {
      group('And VagaRepository returns an array of vagas', () {
        test(
            'GetVagasUseCase should call vagaRepository.all() and return the right array',
            () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();

          when(
            mockedVagaRepository.all(),
          ).thenAnswer((_) async => Right(vagas));

          final GetVagasUseCase getVagasUseCase =
              GetVagasUseCase(vagaRepository: mockedVagaRepository);

          final result = await getVagasUseCase();

          verify(mockedVagaRepository.all());
          expect(result.isRight(), true);
          result.fold((exception) => {}, (vagas) => {expect(vagas.length, 3)});
        });
      });

      group('And VagaRepository returns a failure', () {
        test('GetVagasUseCase should return the left value', () async {
          final VagaRepository mockedVagaRepository = MockVagaRepository();

          when(
            mockedVagaRepository.all(),
          ).thenAnswer((_) async => Left(UnexpectedFailure()));

          final GetVagasUseCase getVagasUseCase =
              GetVagasUseCase(vagaRepository: mockedVagaRepository);

          final result = await getVagasUseCase();

          verify(mockedVagaRepository.all());
          expect(result.isLeft(), true);
        });
      });
    });
  });
}
