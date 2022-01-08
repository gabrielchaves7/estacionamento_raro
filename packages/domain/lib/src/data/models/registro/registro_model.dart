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
        .map((doc) => RegistroModel.fromDocumentSnapshot(doc))
        .toList();
  }

  static RegistroModel fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return RegistroModel(
      id: documentSnapshot.id,
      horarioEntrada: DateTime.fromMillisecondsSinceEpoch(
          documentSnapshot['horario_entrada'].millisecondsSinceEpoch),
      horarioSaida: documentSnapshot['horario_saida'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              documentSnapshot['horario_saida'].millisecondsSinceEpoch)
          : null,
      placa: documentSnapshot['placa'],
    );
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
