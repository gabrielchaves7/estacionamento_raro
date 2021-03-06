import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/domain/entities/vaga/vaga_entity.dart';
import 'package:domain/src/enum/tipo_vaga_enum.dart';

class VagaModel implements Vaga {
  VagaModel(
      {required this.id,
      required this.disponivel,
      required this.tipoVaga,
      required this.numero,
      this.registroId,
      this.placa});

  static List<VagaModel> fromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => VagaModel.fromDocumentSnapshot(doc))
        .toList();
  }

  static VagaModel fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return VagaModel(
        id: documentSnapshot.id,
        disponivel: documentSnapshot['disponivel'],
        tipoVaga: TipoVagaEnum.values.firstWhere((e) =>
            e.toString().split('.').last == documentSnapshot['tipo_vaga']),
        numero: documentSnapshot['numero'],
        registroId: documentSnapshot['registro_id'],
        placa: documentSnapshot['placa']);
  }

  @override
  String id;

  @override
  bool disponivel;

  @override
  TipoVagaEnum tipoVaga;

  @override
  int numero;

  @override
  String? registroId;

  @override
  String? placa;
}
