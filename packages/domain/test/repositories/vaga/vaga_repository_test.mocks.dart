// Mocks generated by Mockito 5.0.17 from annotations
// in domain/test/repositories/vaga/vaga_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:domain/src/data/datasource/vaga/vaga_datasource_impl.dart'
    as _i3;
import 'package:domain/src/data/models/vaga/vaga_model.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeVagaModel_0 extends _i1.Fake implements _i2.VagaModel {}

/// A class which mocks [VagaDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockVagaDataSource extends _i1.Mock implements _i3.VagaDataSource {
  MockVagaDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.VagaModel>?> all() =>
      (super.noSuchMethod(Invocation.method(#all, []),
              returnValue: Future<List<_i2.VagaModel>?>.value())
          as _i4.Future<List<_i2.VagaModel>?>);
  @override
  _i4.Future<_i2.VagaModel> update(
          {String? id, bool? disponivel, String? registroId}) =>
      (super.noSuchMethod(
              Invocation.method(#update, [],
                  {#id: id, #disponivel: disponivel, #registroId: registroId}),
              returnValue: Future<_i2.VagaModel>.value(_FakeVagaModel_0()))
          as _i4.Future<_i2.VagaModel>);
}
