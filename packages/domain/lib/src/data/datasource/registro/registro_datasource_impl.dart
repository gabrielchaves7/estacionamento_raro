import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/data/models/registro/registro_model.dart';

abstract class RegistroDataSource {
  Future<List<RegistroModel>?> all();
  Future<RegistroModel> create({required String placa});
  Future<RegistroModel> updateHorarioSaida({required String id});
}

class RegistroDataSourceImpl implements RegistroDataSource {
  RegistroDataSourceImpl({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<List<RegistroModel>?> all() async {
    CollectionReference registros = firestore.collection('registros');
    QuerySnapshot snapshot = await registros.get();

    return RegistroModel.fromSnapshot(snapshot);
  }

  @override
  Future<RegistroModel> create({required String placa}) async {
    CollectionReference registros = firestore.collection('registros');

    DocumentReference documentReference = await registros.add({
      'horario_entrada': Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch), // John Doe
      'horario_saida': null, // Stokes and Sons
      'placa': placa // 42
    });

    final DocumentSnapshot registroSnapshot = await documentReference.get();

    return RegistroModel.fromDocumentSnapshot(registroSnapshot);
  }

  @override
  Future<RegistroModel> updateHorarioSaida({required String id}) async {
    final DocumentReference documentReference =
        firestore.collection('registros').doc(id);

    await documentReference.update({
      'horario_saida': Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch)
    });

    final DocumentSnapshot registroSnapshot = await documentReference.get();

    return RegistroModel.fromDocumentSnapshot(registroSnapshot);
  }
}
