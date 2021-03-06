import 'package:dartz/dartz.dart';
import 'package:domain/src/data/datasource/vaga/vaga_datasource_impl.dart';
import 'package:domain/src/domain/entities/vaga/vaga_entity.dart';
import 'package:domain/src/domain/errors/failure.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';

class VagaRepositoryImpl implements VagaRepository {
  VagaRepositoryImpl({
    required this.vagaDataSource,
  });

  final VagaDataSource vagaDataSource;

  @override
  Future<Either<Failure, List<Vaga>>> all() async {
    try {
      List<Vaga>? vagas = await vagaDataSource.all();

      if (vagas != null && vagas.isNotEmpty) {
        vagas.sort((a, b) => a.numero.compareTo(b.numero));
        return Right(vagas);
      }

      return Left(UnexpectedValue());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Vaga>> closeVaga(
      {required String id,
      required String registroId,
      required String placa}) async {
    try {
      Vaga vaga = await vagaDataSource.update(
          disponivel: false, id: id, registroId: registroId, placa: placa);

      return Right(vaga);
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Vaga>> openVaga({required String id}) async {
    try {
      Vaga vaga = await vagaDataSource.update(disponivel: true, id: id);

      return Right(vaga);
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
