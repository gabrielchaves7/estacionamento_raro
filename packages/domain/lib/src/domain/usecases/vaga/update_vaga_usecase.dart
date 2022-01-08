import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';

class UpdateVagaUseCase {
  UpdateVagaUseCase({
    required this.vagaRepository,
  });

  final VagaRepository vagaRepository;

  Future<Either<Failure, Vaga>> call(
      {required String id, required bool disponivel}) async {
    return await vagaRepository.update(disponivel: disponivel, id: id);
  }
}
