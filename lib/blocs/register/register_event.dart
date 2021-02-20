part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class AddRegister extends RegisterEvent {
  final UserModel userModel;

  AddRegister({this.userModel});
  @override
  List<Object> get props => [userModel];
}
