part of 'is_logged_in_cubit.dart';

abstract class IsLoggedInState extends Equatable {
  const IsLoggedInState();

  @override
  List<Object> get props => [];
}

class IsLoggedInInitial extends IsLoggedInState {}

class AuthLoadingState extends IsLoggedInState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends IsLoggedInState {
  final Status status;

  AuthenticatedState({this.status});
  @override
  List<Object> get props => [status];
}

class UnAuthenticatedState extends IsLoggedInState {
  @override
  List<Object> get props => [];
}

class AuthErrorState extends IsLoggedInState {
  final String errorMessage;

  AuthErrorState({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
