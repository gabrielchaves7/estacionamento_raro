// Mocks generated by Mockito 5.0.17 from annotations
// in ui/test/pages/home_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i8;

import 'package:dartz/dartz.dart' as _i3;
import 'package:domain/estacionamento_raro_entities.dart' as _i12;
import 'package:domain/src/domain/entities/registro/registro_entity.dart'
    as _i10;
import 'package:domain/src/domain/errors/failure.dart' as _i9;
import 'package:domain/src/domain/repositories/registro/registro_repository.dart'
    as _i2;
import 'package:domain/src/domain/repositories/vaga/vaga_repository.dart'
    as _i4;
import 'package:domain/src/domain/usecases/registro/create_registro_usecase.dart'
    as _i5;
import 'package:domain/src/domain/usecases/registro/get_registros_usecase.dart'
    as _i7;
import 'package:domain/src/domain/usecases/registro/update_horario_saida_usecase.dart'
    as _i6;
import 'package:domain/src/domain/usecases/vaga/close_vaga_usecase.dart'
    as _i13;
import 'package:domain/src/domain/usecases/vaga/get_vagas_usecase.dart' as _i11;
import 'package:domain/src/domain/usecases/vaga/open_vaga_usecase.dart' as _i14;
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

class _FakeVagaRepository_2 extends _i1.Fake implements _i4.VagaRepository {}

class _FakeCreateRegistroUseCase_3 extends _i1.Fake
    implements _i5.CreateRegistroUseCase {}

class _FakeUpdateHorarioSaidaUseCase_4 extends _i1.Fake
    implements _i6.UpdateHorarioSaidaUseCase {}

/// A class which mocks [GetRegistrosUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRegistrosUseCase extends _i1.Mock
    implements _i7.GetRegistrosUseCase {
  MockGetRegistrosUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RegistroRepository get registroRepository =>
      (super.noSuchMethod(Invocation.getter(#registroRepository),
          returnValue: _FakeRegistroRepository_0()) as _i2.RegistroRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, List<_i10.Registro>>> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
              returnValue:
                  Future<_i3.Either<_i9.Failure, List<_i10.Registro>>>.value(
                      _FakeEither_1<_i9.Failure, List<_i10.Registro>>()))
          as _i8.Future<_i3.Either<_i9.Failure, List<_i10.Registro>>>);
}

/// A class which mocks [GetVagasUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetVagasUseCase extends _i1.Mock implements _i11.GetVagasUseCase {
  MockGetVagasUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.VagaRepository get vagaRepository =>
      (super.noSuchMethod(Invocation.getter(#vagaRepository),
          returnValue: _FakeVagaRepository_2()) as _i4.VagaRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, List<_i12.Vaga>>> call() =>
      (super.noSuchMethod(Invocation.method(#call, []),
          returnValue: Future<_i3.Either<_i9.Failure, List<_i12.Vaga>>>.value(
              _FakeEither_1<_i9.Failure, List<_i12.Vaga>>())) as _i8
          .Future<_i3.Either<_i9.Failure, List<_i12.Vaga>>>);
}

/// A class which mocks [CloseVagaUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCloseVagaUseCase extends _i1.Mock implements _i13.CloseVagaUseCase {
  MockCloseVagaUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.VagaRepository get vagaRepository =>
      (super.noSuchMethod(Invocation.getter(#vagaRepository),
          returnValue: _FakeVagaRepository_2()) as _i4.VagaRepository);
  @override
  _i5.CreateRegistroUseCase get createRegistroUseCase =>
      (super.noSuchMethod(Invocation.getter(#createRegistroUseCase),
              returnValue: _FakeCreateRegistroUseCase_3())
          as _i5.CreateRegistroUseCase);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i12.Vaga>> call(
          {String? vagaId, String? placa}) =>
      (super.noSuchMethod(
              Invocation.method(#call, [], {#vagaId: vagaId, #placa: placa}),
              returnValue: Future<_i3.Either<_i9.Failure, _i12.Vaga>>.value(
                  _FakeEither_1<_i9.Failure, _i12.Vaga>()))
          as _i8.Future<_i3.Either<_i9.Failure, _i12.Vaga>>);
}

/// A class which mocks [OpenVagaUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockOpenVagaUseCase extends _i1.Mock implements _i14.OpenVagaUseCase {
  MockOpenVagaUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.VagaRepository get vagaRepository =>
      (super.noSuchMethod(Invocation.getter(#vagaRepository),
          returnValue: _FakeVagaRepository_2()) as _i4.VagaRepository);
  @override
  _i6.UpdateHorarioSaidaUseCase get updateHorarioSaidaUseCase =>
      (super.noSuchMethod(Invocation.getter(#updateHorarioSaidaUseCase),
              returnValue: _FakeUpdateHorarioSaidaUseCase_4())
          as _i6.UpdateHorarioSaidaUseCase);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i12.Vaga>> call(
          {String? vagaId, String? registroId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #call, [], {#vagaId: vagaId, #registroId: registroId}),
              returnValue: Future<_i3.Either<_i9.Failure, _i12.Vaga>>.value(
                  _FakeEither_1<_i9.Failure, _i12.Vaga>()))
          as _i8.Future<_i3.Either<_i9.Failure, _i12.Vaga>>);
}
