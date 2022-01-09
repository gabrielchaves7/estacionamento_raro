part of 'vagas_cubit.dart';

abstract class VagasState {}

class VagasInitialState extends VagasState {}

class VagasLoadingState extends VagasState {}

class VagasErrorState extends VagasState {}

class VagaUpdateErrorState extends VagasErrorState {}

class VagasLoadedState extends VagasState {
  VagasLoadedState(this._vagas, this._exibirVagasDisponiveis);

  final List<Vaga> _vagas;
  final bool _exibirVagasDisponiveis;

  List<Vaga> get vagas =>
      _vagas.where((it) => it.disponivel == _exibirVagasDisponiveis).toList();
}

class VagasUpdatedState extends VagasLoadedState {
  VagasUpdatedState(vagas, exibirVagasDisponiveis)
      : super(vagas, exibirVagasDisponiveis);
}
