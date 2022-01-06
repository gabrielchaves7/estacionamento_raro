import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/domain/entities/registro_entity.dart';

class RegistroModel implements Registro {
  RegistroModel({
    required this.id,
    required this.horarioEntrada,
    this.horarioSaida,
    required this.placa,
    required this.vaga_id,
  });

  static List<RegistroModel> fromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => RegistroModel(
              id: doc.id,
              horarioEntrada: doc['horario_entrada'],
              horarioSaida: doc['horario_saida'],
              placa: doc['placa'],
              vaga_id: doc['vaga'].id,
            ))
        .toList();
  }

  @override
  String id;

  @override
  Timestamp horarioEntrada;

  @override
  Timestamp? horarioSaida;

  @override
  String placa;

  @override
  String vaga_id;
}
