import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/data/datasource/vaga/vaga_datasource_impl.dart';
import 'package:domain/src/data/models/vaga/vaga_model.dart';
import 'package:domain/src/enum/tipo_vaga_enum.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> insertRegistros(CollectionReference registrosCollection) async {
  await registrosCollection.doc("registro1").set({
    'horario_entrada': Timestamp.fromMillisecondsSinceEpoch(1641516678000),
    'placa': 'ABCDEFG',
    'horario_saida': Timestamp.fromMillisecondsSinceEpoch(1641516695000)
  });

  await registrosCollection.doc("registro2").set({
    'horario_entrada': Timestamp.fromMillisecondsSinceEpoch(1641516678000),
    'placa': 'ABCDEFGH',
    'horario_saida': null
  });
}

Future<void> insertVagas(CollectionReference vagasCollection,
    CollectionReference registrosCollection) async {
  await vagasCollection.doc("id1").set({
    'disponivel': true,
    'tipo_vaga': 'moto',
    'numero': 1,
    'registro_id': null
  });

  await vagasCollection.doc("id2").set({
    'disponivel': false,
    'tipo_vaga': 'carro',
    'numero': 2,
    'registro_id': 'registro2'
  });
}

void main() {
  late FirebaseFirestore mockedFirestore;
  late CollectionReference vagasCollection;
  late CollectionReference registrosCollection;

  setUpAll(() async {
    mockedFirestore = FakeFirebaseFirestore();
    registrosCollection = mockedFirestore.collection('registros');
    vagasCollection = mockedFirestore.collection('vagas');
    await insertRegistros(registrosCollection);
    await insertVagas(vagasCollection, registrosCollection);
  });

  group('VagaDataSource', () {
    group('When VagaDataSource.all is called', () {
      test(
          'VagaDataSource should call FirebaseFirestore.collection("vagas") and return the result properly',
          () async {
        final VagaDataSource vagaDataSource =
            VagaDataSourceImpl(firestore: mockedFirestore);

        final result = await vagaDataSource.all();

        expect(result!.length, 2);

        expect(result.first.id, 'id1');
        expect(result.first.disponivel, true);
        expect(result.first.tipoVaga, TipoVagaEnum.moto);
        expect(result.first.numero, 1);
        expect(result.first.registroId, null);

        expect(result.last.id, 'id2');
        expect(result.last.disponivel, false);
        expect(result.last.tipoVaga, TipoVagaEnum.carro);
        expect(result.last.numero, 2);
        expect(result.last.registroId, 'registro2');
      });
    });

    group('When VagaDataSource.update is called', () {
      test(
          'VagaDataSource should call .update for the right doc id and return a VagaModel',
          () async {
        final VagaDataSource vagaDataSource =
            VagaDataSourceImpl(firestore: mockedFirestore);

        final VagaModel vaga = await vagaDataSource.closeVaga(
            disponivel: false, id: 'id1', registroId: 'registro1');

        expect(vaga.id, 'id1');
        expect(vaga.disponivel, false);
        expect(vaga.tipoVaga, TipoVagaEnum.moto);
        expect(vaga.registroId, 'registro1');
      });
    });
  });
}
