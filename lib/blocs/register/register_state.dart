part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterAddedState extends RegisterState {
  final Status status;

  RegisterAddedState({this.status});
  @override
  List<Object> get props => [status];
}

class RegisterErrorState extends RegisterState {
  final String errorMessage;

  RegisterErrorState({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
