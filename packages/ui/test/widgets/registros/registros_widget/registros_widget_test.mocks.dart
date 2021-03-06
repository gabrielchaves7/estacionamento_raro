// Mocks generated by Mockito 5.0.17 from annotations
// in ui/test/widgets/registros/registros_widget_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:domain/src/domain/entities/registro/registro_entity.dart'
    as _i7;
import 'package:domain/src/domain/errors/failure.dart' as _i6;
import 'package:domain/src/domain/repositories/registro/registro_repository.dart'
    as _i2;
import 'package:domain/src/domain/usecases/registro/get_registros_usecase.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeRegistroRepository_0 extends _i1.Fake
    implements _i2.RegistroRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetRegistrosUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRegistrosUseCase extends _i1.Mock
    implements _i4.GetRegistrosUseCase {
  MockGetRegistrosUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RegistroRepository get registroRepository =>
      (super.noSuchMethod(Invocation.getter(#registroRepository),
          returnValue: _FakeRegistroRepository_0()) as _i2.RegistroRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Registro>>> call() => (super
          .noSuchMethod(Invocation.method(#call, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.Registro>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.Registro>>()))
      as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Registro>>>);
}
