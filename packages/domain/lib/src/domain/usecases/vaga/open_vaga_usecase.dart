import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';
import 'package:domain/src/domain/usecases/registro/update_horario_saida_usecase.dart';

class OpenVagaUseCase {
  OpenVagaUseCase({
    required this.vagaRepository,
    required this.updateHorarioSaidaUseCase,
  });

  final VagaRepository vagaRepository;
  final UpdateHorarioSaidaUseCase updateHorarioSaidaUseCase;

  Future<Either<Failure, Vaga>> call(
      {required String vagaId, required String registroId}) async {
    final registroResult = await updateHorarioSaidaUseCase(id: registroId);

    return registroResult.fold((registroException) => Left(registroException),
        (registro) async {
      final vagaResult = await vagaRepository.openVaga(id: vagaId);

      return vagaResult.fold(
          (vagaException) => Left(vagaException), (vaga) => Right(vaga));
    });
  }
}
