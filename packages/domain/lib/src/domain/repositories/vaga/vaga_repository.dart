import 'package:dartz/dartz.dart';
import 'package:domain/src/domain/entities/vaga/vaga_entity.dart';
import 'package:domain/src/domain/errors/failure.dart';

abstract class VagaRepository {
  Future<Either<Failure, List<Vaga>>> all();
}
