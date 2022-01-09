import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_errors.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vagas_state.dart';

class VagasCubit extends Cubit<VagasState> {
  VagasCubit({
    required this.getVagasUseCase,
    required this.updateVagaUseCase,
  }) : super(VagasInitialState());

  final GetVagasUseCase getVagasUseCase;
  final UpdateVagaUseCase updateVagaUseCase;

  bool _exibirVagasdisponiveis = true;
  List<Vaga> _vagas = [];

  get exibirVagasDisponiveis => _exibirVagasdisponiveis;

  Future<void> getVagas() async {
    emit(VagasLoadingState());

    final Either<Failure, List<Vaga>> vagas = await getVagasUseCase();

    vagas.fold((error) {
      emit(VagasErrorState());
    }, (vagas) {
      _vagas = vagas;
      emit(VagasLoadedState(_vagas, _exibirVagasdisponiveis));
    });
  }

  Future<void> updateVaga(
      {required bool disponivel, required String id}) async {
    final Either<Failure, Vaga> result =
        await updateVagaUseCase(disponivel: disponivel, id: id);

    result.fold((error) {
      emit(VagaUpdateErrorState());
    }, (updatedVaga) {
      _vagas[_vagas.indexWhere((v) => v.id == updatedVaga.id)] = updatedVaga;
      emit(VagasUpdatedState(_vagas, _exibirVagasdisponiveis));
    });
  }

  Future<void> changeExibirVagasDisponiveis(
      {required bool exibirVagasDisponiveis}) async {
    _exibirVagasdisponiveis = exibirVagasDisponiveis;
    emit(VagasLoadedState(_vagas, _exibirVagasdisponiveis));
  }
}
