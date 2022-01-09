// Mocks generated by Mockito 5.0.17 from annotations
// in ui/test/widgets/vagas/ocupar_vaga_dialog_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:domain/estacionamento_raro_entities.dart' as _i7;
import 'package:domain/src/domain/errors/failure.dart' as _i6;
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart'
    as _i2;
import 'package:domain/src/domain/usecases/vaga/close_vaga_usecase.dart' as _i8;
import 'package:domain/src/domain/usecases/vaga/get_vagas_usecase.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeVagaRepository_0 extends _i1.Fake implements _i2.VagaRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetVagasUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetVagasUseCase extends _i1.Mock implements _i4.GetVagasUseCase {
  MockGetVagasUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.VagaRepository get vagaRepository =>
      (super.noSuchMethod(Invocation.getter(#vagaRepository),
          returnValue: _FakeVagaRepository_0()) as _i2.VagaRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Vaga>>> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.Vaga>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Vaga>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Vaga>>>);
}

/// A class which mocks [CloseVagaUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCloseVagaUseCase extends _i1.Mock implements _i8.CloseVagaUseCase {
  MockCloseVagaUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.VagaRepository get vagaRepository =>
      (super.noSuchMethod(Invocation.getter(#vagaRepository),
          returnValue: _FakeVagaRepository_0()) as _i2.VagaRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Vaga>> call({String? id}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#id: id}),
              returnValue: Future<_i3.Either<_i6.Failure, _i7.Vaga>>.value(
                  _FakeEither_1<_i6.Failure, _i7.Vaga>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.Vaga>>);
}
