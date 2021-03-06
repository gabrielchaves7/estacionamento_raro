import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/data/models/vaga/vaga_model.dart';

abstract class VagaDataSource {
  Future<List<VagaModel>?> all();
  Future<VagaModel> update(
      {required String id,
      required bool disponivel,
      String? registroId,
      String? placa});
}

class VagaDataSourceImpl implements VagaDataSource {
  VagaDataSourceImpl({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<List<VagaModel>?> all() async {
    CollectionReference vagas = firestore.collection('vagas');
    QuerySnapshot snapshot = await vagas.get();

    return VagaModel.fromSnapshot(snapshot);
  }

  @override
  Future<VagaModel> update({
    required bool disponivel,
    required String id,
    String? registroId,
    String? placa,
  }) async {
    final DocumentReference documentReference =
        firestore.collection('vagas').doc(id);

    await documentReference.update(
        {'disponivel': disponivel, 'registro_id': registroId, 'placa': placa});

    final DocumentSnapshot vagaSnapshot = await documentReference.get();

    return VagaModel.fromDocumentSnapshot(vagaSnapshot);
  }
}
