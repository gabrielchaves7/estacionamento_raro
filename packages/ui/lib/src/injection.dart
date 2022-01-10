import 'package:get_it/get_it.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';

import 'bloc/registro/registro_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  //cubit
  if (!getIt.isRegistered<RegistroCubit>()) {
    getIt.registerLazySingleton<RegistroCubit>(
      () => RegistroCubit(getRegistrosUseCase: getIt()),
    );
  }

  if (!getIt.isRegistered<VagasCubit>()) {
    getIt.registerLazySingleton<VagasCubit>(
      () => VagasCubit(
          getVagasUseCase: getIt(),
          closeVagaUseCase: getIt(),
          openVagaUseCase: getIt()),
    );
  }
}
