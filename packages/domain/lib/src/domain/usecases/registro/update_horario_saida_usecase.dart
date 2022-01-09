import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/registro/registro_repository.dart';

class UpdateHorarioSaidaUseCase {
  UpdateHorarioSaidaUseCase({
    required this.registroRepository,
  });

  final RegistroRepository registroRepository;

  Future<Either<Failure, Registro>> call({required String id}) async {
    return await registroRepository.updateHorarioSaida(id: id);
  }
}
