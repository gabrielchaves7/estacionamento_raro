import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/data/datasource/registro/registro_datasource_impl.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
/*
Future<void> createVagasCollection(FirebaseFirestore mockedFirestore) async {
  await mockedFirestore
      .collection("vagas")
      .doc("123lkmsa")
      .set({'disponivel': true, 'tipo_vaga': 'carro'});
}*/

Future<void> createRegistrosCollection(
    FirebaseFirestore mockedFirestore) async {
  await mockedFirestore.collection("registros").doc("id1").set({
    'horario_entrada': Timestamp.fromMillisecondsSinceEpoch(1641516678000),
    'placa': 'ABCDEFG',
    'vaga': mockedFirestore.doc('vagas/123lkmsa'),
    'horario_saida': Timestamp.fromMillisecondsSinceEpoch(1641516695000)
  });
}

void main() {
  group('RegistroDataSource', () {
    group('When RegistroDataSource.all is called', () {
      test(
          'RegistroDataSource should call FirebaseFirestore.collection("registros") and return the result properly',
          () async {
        final mockedFirestore = FakeFirebaseFirestore();

        await createRegistrosCollection(mockedFirestore);

        final RegistroDataSource registroDataSource =
            RegistroDataSourceImpl(firestore: mockedFirestore);

        final result = await registroDataSource.all();

        expect(result!.length, 1);

        expect(result.first.id, 'id1');
        expect(
            result.first.horarioEntrada.millisecondsSinceEpoch, 1641516678000);
        expect(
            result.first.horarioSaida!.millisecondsSinceEpoch, 1641516695000);
        expect(result.first.placa, 'ABCDEFG');
      });
    });
  });
}
