import 'package:dartz/dartz.dart';
import 'package:domain/src/domain/entities/registro_entity.dart';
import 'package:domain/src/domain/errors/failure.dart';

abstract class RegistroRepository {
  Future<Either<Failure, List<Registro>>> all();
}
