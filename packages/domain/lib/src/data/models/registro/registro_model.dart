import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/domain/entities/registro/registro_entity.dart';

class RegistroModel implements Registro {
  RegistroModel({
    required this.id,
    required this.horarioEntrada,
    this.horarioSaida,
    required this.placa,
  });

  static List<RegistroModel> fromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => RegistroModel(
              id: doc.id,
              horarioEntrada: DateTime.fromMillisecondsSinceEpoch(
                  doc['horario_entrada'].millisecondsSinceEpoch),
              horarioSaida: doc['horario_saida'] != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                      doc['horario_saida'].millisecondsSinceEpoch)
                  : null,
              placa: doc['placa'],
            ))
        .toList();
  }

  @override
  String id;

  @override
  DateTime horarioEntrada;

  @override
  DateTime? horarioSaida;

  @override
  String placa;
}
