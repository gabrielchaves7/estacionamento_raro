import 'package:get_it/get_it.dart';

import 'bloc/registro_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  //cubit
  if (!getIt.isRegistered<RegistroCubit>()) {
    getIt.registerLazySingleton<RegistroCubit>(
      () => RegistroCubit(getRegistrosUseCase: getIt()),
    );
  }
}
