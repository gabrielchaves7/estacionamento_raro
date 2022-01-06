import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/data/models/registro_model.dart';

abstract class RegistroDataSource {
  Future<List<RegistroModel>> all();
}

class RegistroDataSourceImpl implements RegistroDataSource {
  RegistroDataSourceImpl({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<List<RegistroModel>> all() async {
    CollectionReference registros = firestore.collection('registros');
    QuerySnapshot snapshot = await registros.get();
    var result = RegistroModel.fromSnapshot(snapshot);
    return result;
  }
}
