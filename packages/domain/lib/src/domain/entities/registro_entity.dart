import 'package:cloud_firestore/cloud_firestore.dart';

class Registro {
  Registro({
    required this.id,
    required this.horarioEntrada,
    this.horarioSaida,
    required this.placa,
    required this.vaga_id,
  });

  String id;
  Timestamp horarioEntrada;
  Timestamp? horarioSaida;
  String placa;
  String vaga_id;
}
