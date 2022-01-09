part of 'vagas_cubit.dart';

abstract class VagasState {}

class VagasInitialState extends VagasState {}

class VagasLoadingState extends VagasState {}

class VagasErrorState extends VagasState {}

class VagasLoadedState extends VagasState {
  VagasLoadedState(this._vagas, this._exibirVagasDisponiveis);

  final List<Vaga> _vagas;
  final bool _exibirVagasDisponiveis;

  List<Vaga> get vagas =>
      _vagas.where((it) => it.disponivel == _exibirVagasDisponiveis).toList();
}

class VagaClosedState extends VagasLoadedState {
  VagaClosedState(vagas, exibirVagasDisponiveis)
      : super(vagas, exibirVagasDisponiveis);
}

class VagaClosedErrorState extends VagasErrorState {}

class VagaOpenedState extends VagasLoadedState {
  VagaOpenedState(vagas, exibirVagasDisponiveis)
      : super(vagas, exibirVagasDisponiveis);
}

class VagaOpenedErrorState extends VagasErrorState {}
