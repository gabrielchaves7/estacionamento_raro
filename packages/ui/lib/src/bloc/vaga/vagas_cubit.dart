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

  List<Vaga> _vagas = [];

  List<Vaga> get vagasDisponiveis =>
      _vagas.where((vaga) => vaga.disponivel == true).toList();

  Future<void> getVagas() async {
    emit(VagasLoadingState());

    final Either<Failure, List<Vaga>> vagas = await getVagasUseCase();

    vagas.fold((error) {
      emit(VagasErrorState());
    }, (vagas) {
      _vagas = vagas;
      emit(VagasLoadedState(vagas: vagas));
    });
  }
}
