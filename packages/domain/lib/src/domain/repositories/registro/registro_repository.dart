import 'package:dartz/dartz.dart';
import 'package:domain/src/domain/entities/registro/registro_entity.dart';
import 'package:domain/src/domain/errors/failure.dart';

abstract class RegistroRepository {
  Future<Either<Failure, List<Registro>>> all();
  Future<Either<Failure, Registro>> create({required String placa});
  Future<Either<Failure, Registro>> updateHorarioSaida({required String id});
}
