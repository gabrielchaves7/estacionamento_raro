import 'package:equatable/equatable.dart';

abstract class Failure with EquatableMixin {}

class UnexpectedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnexpectedValue extends Failure {
  @override
  List<Object?> get props => [];
}
