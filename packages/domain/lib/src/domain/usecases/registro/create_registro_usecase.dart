import 'package:dartz/dartz.dart';
import 'package:domain/src/domain/entities/registro/registro_entity.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/registro/registro_repository.dart';

class CreateRegistroUseCase {
  CreateRegistroUseCase({
    required this.registroRepository,
  });

  final RegistroRepository registroRepository;

  Future<Either<Failure, Registro>> call(
      {required DateTime horarioEntrada, required String placa}) async {
    return await registroRepository.create(
        horarioEntrada: horarioEntrada, placa: placa);
  }
}
