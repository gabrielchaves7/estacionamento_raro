class Registro {
  Registro({
    required this.id,
    required this.horarioEntrada,
    this.horarioSaida,
    required this.placa,
  });

  String id;
  DateTime horarioEntrada;
  DateTime? horarioSaida;
  String placa;
}
