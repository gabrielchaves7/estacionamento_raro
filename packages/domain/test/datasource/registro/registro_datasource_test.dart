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

Future<void> insertDocument(CollectionReference registrosCollection) async {
  await registrosCollection.doc("id1").set({
    'horario_entrada': Timestamp.fromMillisecondsSinceEpoch(1641516678000),
    'placa': 'ABCDEFG',
    'horario_saida': Timestamp.fromMillisecondsSinceEpoch(1641516695000)
  });
}

void main() {
  late FirebaseFirestore mockedFirestore;
  late CollectionReference registrosCollection;

  setUpAll(() {
    mockedFirestore = FakeFirebaseFirestore();
    registrosCollection = mockedFirestore.collection('registros');
  });

  group('RegistroDataSource', () {
    group('When RegistroDataSource.all is called', () {
      test(
          'RegistroDataSource should call FirebaseFirestore.collection("registros") and return the result properly',
          () async {
        await insertDocument(registrosCollection);

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

    group('When RegistroDataSource.create is called', () {
      //Horario entrada: 08/01/2022 17:13
      final DateTime horarioEntrada =
          DateTime.fromMillisecondsSinceEpoch(1641672790000);
      test(
          'RegistroDataSource should call FirebaseFirestore.collection("registros").add(), create the new doc and return the result properly',
          () async {
        final RegistroDataSource registroDataSource =
            RegistroDataSourceImpl(firestore: mockedFirestore);

        final result = await registroDataSource.create(
            horarioEntrada: horarioEntrada, placa: 'ABCDEFG');

        expect(result.placa, 'ABCDEFG');
        expect(result.horarioEntrada.millisecondsSinceEpoch,
            horarioEntrada.millisecondsSinceEpoch);
      });
    });
  });
}
