import 'package:dartz/dartz.dart';
import 'package:domain/src/data/datasource/registro_datasource_impl.dart';
import 'package:domain/src/domain/entities/registro_entity.dart';
import 'package:domain/src/domain/repositories/registro_repository.dart';

class RegistroRepositoryImpl implements RegistroRepository {
  RegistroRepositoryImpl({
    required this.registroDataSource,
  });

  final RegistroDataSource registroDataSource;

  @override
  Future<Either<Exception, List<Registro>>> all() async {
    List<Registro> registros = await registroDataSource.all();

    return Right(registros);
  }
}
