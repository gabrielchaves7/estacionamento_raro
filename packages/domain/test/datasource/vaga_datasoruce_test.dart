import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/src/data/datasource/vaga/vaga_datasource_impl.dart';
import 'package:domain/src/enum/tipo_vaga_enum.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> createVagasCollection(FirebaseFirestore mockedFirestore) async {
  await mockedFirestore
      .collection("vagas")
      .doc("id1")
      .set({'disponivel': true, 'tipo_vaga': 'moto'});

  await mockedFirestore
      .collection("vagas")
      .doc("id2")
      .set({'disponivel': false, 'tipo_vaga': 'carro'});
}

void main() {
  group('VagaDataSource', () {
    group('When VagaDataSource.all is called', () {
      test(
          'VagaDataSource should call FirebaseFirestore.collection("vagas") and return the result properly',
          () async {
        final mockedFirestore = FakeFirebaseFirestore();

        await createVagasCollection(mockedFirestore);

        final VagaDataSource vagaDataSource =
            VagaDataSourceImpl(firestore: mockedFirestore);

        final result = await vagaDataSource.all();

        expect(result!.length, 2);

        expect(result.first.id, 'id1');
        expect(result.first.disponivel, true);
        expect(result.first.tipoVaga, TipoVagaEnum.moto);

        expect(result.last.id, 'id2');
        expect(result.last.disponivel, false);
        expect(result.last.tipoVaga, TipoVagaEnum.carro);
      });
    });
  });
}
