import 'package:dartz/dartz.dart';
import 'package:domain/src/data/datasource/registro/registro_datasource_impl.dart';
import 'package:domain/src/domain/entities/registro/registro_entity.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/registro/registro_repository.dart';

class RegistroRepositoryImpl implements RegistroRepository {
  RegistroRepositoryImpl({
    required this.registroDataSource,
  });

  final RegistroDataSource registroDataSource;

  @override
  Future<Either<Failure, List<Registro>>> all() async {
    try {
      List<Registro>? registros = await registroDataSource.all();

      if (registros != null) {
        return Right(registros);
      }

      return Left(UnexpectedValue());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Registro>> create({required String placa}) async {
    try {
      final Registro registro = await registroDataSource.create(placa: placa);

      return Right(registro);
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Registro>> updateHorarioSaida(
      {required String id}) async {
    try {
      final Registro registro =
          await registroDataSource.updateHorarioSaida(id: id);

      return Right(registro);
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
