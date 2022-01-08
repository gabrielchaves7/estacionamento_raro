class Registro {
  Registro({
    required this.id,
    required this.horarioEntrada,
    this.horarioSaida,
    required this.placa,
    required this.vagaId,
  });

  String id;
  DateTime horarioEntrada;
  DateTime? horarioSaida;
  String placa;
  String vagaId;
}
