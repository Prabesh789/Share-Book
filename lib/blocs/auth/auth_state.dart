part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  final Status status;

  AuthenticatedState({this.status});
  @override
  List<Object> get props => [status];
}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthErrorState extends AuthBloc {
  final String errorMessage;

  AuthErrorState({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
