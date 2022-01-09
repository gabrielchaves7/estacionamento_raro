import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';
import 'package:domain/src/domain/usecases/registro/create_registro_usecase.dart';

class CloseVagaUseCase {
  CloseVagaUseCase({
    required this.vagaRepository,
    required this.createRegistroUseCase,
  });

  final VagaRepository vagaRepository;
  final CreateRegistroUseCase createRegistroUseCase;

  Future<Either<Failure, Vaga>> call(
      {required String vagaId, required String placa}) async {
    final registroResult = await createRegistroUseCase.call(placa: placa);

    return registroResult.fold((registroException) => Left(registroException),
        (registro) async {
      final vagaResult =
          await vagaRepository.closeVaga(id: vagaId, registroId: registro.id);

      return vagaResult.fold((vagaException) => Left(vagaException), (vaga) {
        return Right(vaga);
      });
    });
  }
}
