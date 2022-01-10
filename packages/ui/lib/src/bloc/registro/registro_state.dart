part of 'registro_cubit.dart';

abstract class RegistroState {}

class RegistroInitialState extends RegistroState {}

class RegistroLoadingState extends RegistroState {}

class RegistroLoadedState extends RegistroState {
  RegistroLoadedState(this._registros, this.dateFilter);

  final List<Registro> _registros;
  final DateFilterEnum dateFilter;

  List<Registro> get registros {
    final DateTime now = DateTime.now();
    DateTime result;

    if (dateFilter == DateFilterEnum.oneDay) {
      result = now.subtract(const Duration(days: 1));
    } else if (dateFilter == DateFilterEnum.threeDays) {
      result = now.subtract(const Duration(days: 3));
    } else if (dateFilter == DateFilterEnum.sevenDays) {
      result = now.subtract(const Duration(days: 7));
    } else {
      result = now.subtract(const Duration(days: 30));
    }

    return _registros.where((it) {
      return it.horarioSaida == null ? true : it.horarioSaida!.isAfter(result);
    }).toList();
  }
}

class RegistroErrorState extends RegistroState {}
