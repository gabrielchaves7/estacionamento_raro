import 'package:dartz/dartz.dart';
import 'package:domain/estacionamento_raro_entities.dart';
import 'package:domain/estacionamento_raro_errors.dart';
import 'package:domain/estacionamento_raro_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vagas_state.dart';

class VagasCubit extends Cubit<VagasState> {
  VagasCubit({
    required this.getVagasUseCase,
    required this.closeVagaUseCase,
    required this.openVagaUseCase,
  }) : super(VagasInitialState());

  final GetVagasUseCase getVagasUseCase;
  final CloseVagaUseCase closeVagaUseCase;
  final OpenVagaUseCase openVagaUseCase;

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

  Future<void> closeVaga(
      {required String vagaId, required String placa}) async {
    final Either<Failure, Vaga> result =
        await closeVagaUseCase(vagaId: vagaId, placa: placa);

    result.fold((error) {
      emit(VagaClosedErrorState());
    }, (updatedVaga) {
      _vagas[_vagas.indexWhere((v) => v.id == updatedVaga.id)] = updatedVaga;
      emit(VagaClosedState(_vagas, _exibirVagasdisponiveis));
    });
  }

  Future<void> openVaga(
      {required String vagaId, required String registroId}) async {
    final Either<Failure, Vaga> result =
        await openVagaUseCase(vagaId: vagaId, registroId: registroId);

    result.fold((error) {
      emit(VagaOpenedErrorState());
    }, (updatedVaga) {
      _vagas[_vagas.indexWhere((v) => v.id == updatedVaga.id)] = updatedVaga;
      emit(VagaOpenedState(_vagas, _exibirVagasdisponiveis));
    });
  }

  Future<void> changeExibirVagasDisponiveis(
      {required bool exibirVagasDisponiveis}) async {
    _exibirVagasdisponiveis = exibirVagasDisponiveis;
    emit(VagasLoadedState(_vagas, _exibirVagasdisponiveis));
  }
}
