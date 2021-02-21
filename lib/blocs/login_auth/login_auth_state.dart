part of 'login_auth_bloc.dart';

abstract class LoginAuthState extends Equatable {}

class LoginAuthInitial extends LoginAuthState {
  @override
  List<Object> get props => [];
}

class LoginAuthLoadingState extends LoginAuthState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginAuthState {
  final Status status;

  LoginSuccessState({this.status});
  @override
  List<Object> get props => [status];
}

class LoginAuthArrorState extends LoginAuthState {
  final String errorMessage;

  LoginAuthArrorState({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
