import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:domain/src/data/datasource/registro/registro_datasource_impl.dart';
import 'package:domain/src/data/datasource/vaga/vaga_datasource_impl.dart';
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart';
import 'package:domain/src/domain/usecases/registro/get_registros_usecase.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories/registro/registro_repository_impl.dart';
import 'data/repositories/vaga/vaga_repository_impl.dart';
import 'domain/repositories/registro/registro_repository.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  //firebase
  if (!getIt.isRegistered<FirebaseFirestore>()) {
    getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  }

  //repositories
  if (!getIt.isRegistered<RegistroRepository>()) {
    getIt.registerLazySingleton<RegistroRepository>(
      () => RegistroRepositoryImpl(registroDataSource: getIt()),
    );
  }

  if (!getIt.isRegistered<VagaRepository>()) {
    getIt.registerLazySingleton<VagaRepository>(
      () => VagaRepositoryImpl(vagaDataSource: getIt()),
    );
  }

  //datasources
  if (!getIt.isRegistered<RegistroDataSource>()) {
    getIt.registerLazySingleton<RegistroDataSource>(
      () => RegistroDataSourceImpl(firestore: getIt()),
    );
  }

  if (!getIt.isRegistered<VagaDataSource>()) {
    getIt.registerLazySingleton<VagaDataSource>(
      () => VagaDataSourceImpl(firestore: getIt()),
    );
  }

  //usecases
  if (!getIt.isRegistered<GetRegistrosUseCase>()) {
    getIt.registerLazySingleton<GetRegistrosUseCase>(
      () => GetRegistrosUseCase(registroRepository: getIt()),
    );
  }

  if (!getIt.isRegistered<GetVagasUseCase>()) {
    getIt.registerLazySingleton<GetVagasUseCase>(
      () => GetVagasUseCase(vagaRepository: getIt()),
    );
  }
}
