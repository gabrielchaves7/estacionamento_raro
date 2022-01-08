part of 'vagas_cubit.dart';

abstract class VagasState {}

class VagasInitialState extends VagasState {}

class VagasLoadingState extends VagasState {}

class VagasLoadedState extends VagasState {
  VagasLoadedState({required this.vagas});

  final List<Vaga> vagas;
}

class VagasErrorState extends VagasState {}
