import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';

class GetVagasUseCase {
  GetVagasUseCase({
    required this.vagaRepository,
  });

  final VagaRepository vagaRepository;

  Future<Either<Failure, List<Vaga>>> call() async {
    return await vagaRepository.all();
  }
}
