part of 'login_auth_bloc.dart';

abstract class LoginAuthEvent extends Equatable {}

class LoginSuccess extends LoginAuthEvent {
  final UserModel userModel;

  LoginSuccess({this.userModel});

  @override
  List<Object> get props => [];
}
