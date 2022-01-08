import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_errors.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vagas_state.dart';

class VagasCubit extends Cubit<VagasState> {
  VagasCubit({
    required this.getVagasUseCase,
  }) : super(VagasInitialState());

  final GetVagasUseCase getVagasUseCase;

  Future<void> getVagas() async {
    emit(VagasLoadingState());

    final Either<Failure, List<Vaga>> vagas = await getVagasUseCase();

    vagas.fold((error) {
      emit(VagasErrorState());
    }, (vagas) => emit(VagasLoadedState(vagas: vagas)));
  }
}
