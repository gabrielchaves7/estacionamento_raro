import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/domain/entities/vaga/vaga_entity.dart';
import 'package:domain/src/enum/tipo_vaga_enum.dart';

class VagaModel implements Vaga {
  VagaModel(
      {required this.id,
      required this.disponivel,
      required this.tipoVaga,
      required this.numero});

  static List<VagaModel> fromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => VagaModel(
            id: doc.id,
            disponivel: doc['disponivel'],
            tipoVaga: TipoVagaEnum.values.firstWhere(
                (e) => e.toString().split('.').last == doc['tipo_vaga']),
            numero: doc['numero']))
        .toList();
  }

  @override
  String id;

  @override
  bool disponivel;

  @override
  TipoVagaEnum tipoVaga;

  @override
  int numero;
}
