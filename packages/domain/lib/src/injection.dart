import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/data/datasource/registro/registro_datasource_impl.dart';
import 'package:domain/src/domain/usecases/registro/get_registros_usecase.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories/registro/registro_repository_impl.dart';
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

  //datasources
  if (!getIt.isRegistered<RegistroDataSource>()) {
    getIt.registerLazySingleton<RegistroDataSource>(
      () => RegistroDataSourceImpl(firestore: getIt()),
    );
  }

  //usecases
  if (!getIt.isRegistered<GetRegistrosUseCase>()) {
    getIt.registerLazySingleton<GetRegistrosUseCase>(
      () => GetRegistrosUseCase(registroRepository: getIt()),
    );
  }
}
