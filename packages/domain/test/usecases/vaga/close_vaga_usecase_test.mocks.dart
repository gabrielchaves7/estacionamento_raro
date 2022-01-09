// Mocks generated by Mockito 5.0.17 from annotations
// in domain/test/usecases/vaga/close_vaga_usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i2;
import 'package:domain/src/domain/entities/registro/registro_entity.dart'
    as _i9;
import 'package:domain/src/domain/entities/vaga/vaga_entity.dart' as _i7;
import 'package:domain/src/domain/errors/failure.dart' as _i6;
import 'package:domain/src/domain/repositories/registro/registro_repository.dart'
    as _i3;
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart'
    as _i4;
import 'package:domain/src/domain/usecases/registro/create_registro_usecase.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeRegistroRepository_1 extends _i1.Fake
    implements _i3.RegistroRepository {}

/// A class which mocks [VagaRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockVagaRepository extends _i1.Mock implements _i4.VagaRepository {
  MockVagaRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Vaga>>> all() =>
      (super.noSuchMethod(Invocation.method(#all, []),
          returnValue: Future<_i2.Either<_i6.Failure, List<_i7.Vaga>>>.value(
              _FakeEither_0<_i6.Failure, List<_i7.Vaga>>())) as _i5
          .Future<_i2.Either<_i6.Failure, List<_i7.Vaga>>>);
  @override
  _i5.Future<_i2.Either<_i6.Failure, _i7.Vaga>> update(
          {String? id, bool? disponivel}) =>
      (super.noSuchMethod(
          Invocation.method(#update, [], {#id: id, #disponivel: disponivel}),
          returnValue: Future<_i2.Either<_i6.Failure, _i7.Vaga>>.value(
              _FakeEither_0<_i6.Failure, _i7.Vaga>())) as _i5
          .Future<_i2.Either<_i6.Failure, _i7.Vaga>>);
}

/// A class which mocks [CreateRegistroUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreateRegistroUseCase extends _i1.Mock
    implements _i8.CreateRegistroUseCase {
  MockCreateRegistroUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.RegistroRepository get registroRepository =>
      (super.noSuchMethod(Invocation.getter(#registroRepository),
          returnValue: _FakeRegistroRepository_1()) as _i3.RegistroRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, _i9.Registro>> call({String? placa}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#placa: placa}),
              returnValue: Future<_i2.Either<_i6.Failure, _i9.Registro>>.value(
                  _FakeEither_0<_i6.Failure, _i9.Registro>()))
          as _i5.Future<_i2.Either<_i6.Failure, _i9.Registro>>);
}
