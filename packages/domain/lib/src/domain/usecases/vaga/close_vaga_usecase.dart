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
    final result = await vagaRepository.update(disponivel: true, id: vagaId);

    return result.fold((exception) {
      return Left(exception);
    }, (vaga) async {
      final registroResult = await createRegistroUseCase.call(placa: placa);

      return registroResult.fold((l) => Left(l), (r) => Right(vaga));
    });
  }
}
