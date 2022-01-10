part of 'registro_cubit.dart';

abstract class RegistroState {}

class RegistroInitialState extends RegistroState {}

class RegistroLoadingState extends RegistroState {}

class RegistroLoadedState extends RegistroState {
  RegistroLoadedState({required this.registros});

  final List<Registro> registros;
}

class RegistroErrorState extends RegistroState {}
