import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/data/models/vaga/vaga_model.dart';

abstract class VagaDataSource {
  Future<List<VagaModel>?> all();
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
}
