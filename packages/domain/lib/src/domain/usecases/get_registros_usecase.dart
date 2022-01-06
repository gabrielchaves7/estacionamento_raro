import 'package:dartz/dartz.dart';
import 'package:domain/src/domain/entities/registro_entity.dart';
import 'package:domain/src/domain/repositories/registro_repository.dart';

class GetRegistrosUseCase {
  GetRegistrosUseCase({
    required this.registroRepository,
  });

  final RegistroRepository registroRepository;

  Future<Either<Exception, List<Registro>>> call() async {
    return await registroRepository.all();
  }
}
