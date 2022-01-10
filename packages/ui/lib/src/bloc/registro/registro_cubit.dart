import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:domain/estacionamento_raro_errors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registro_state.dart';

class RegistroCubit extends Cubit<RegistroState> {
  RegistroCubit({
    required this.getRegistrosUseCase,
  }) : super(RegistroInitialState());

  final GetRegistrosUseCase getRegistrosUseCase;

  Future<void> getRegistros() async {
    emit(RegistroLoadingState());

    final Either<Failure, List<Registro>> registros =
        await getRegistrosUseCase();

    registros.fold((error) {
      emit(RegistroErrorState());
    }, (registros) => emit(RegistroLoadedState(registros: registros)));
  }
}
