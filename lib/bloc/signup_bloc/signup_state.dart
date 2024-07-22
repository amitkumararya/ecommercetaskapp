import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String id;

  SignUpSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);

  @override
  List<Object?> get props => [error];
}
