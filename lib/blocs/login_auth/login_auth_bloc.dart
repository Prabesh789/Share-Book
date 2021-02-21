import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sharebook/data/model/status.dart';
import 'package:sharebook/data/model/user_model.dart';

part 'login_auth_event.dart';
part 'login_auth_state.dart';

class LoginAuthBloc extends Bloc<LoginAuthEvent, LoginAuthState> {
  LoginAuthBloc() : super(LoginAuthInitial());

  @override
  Stream<LoginAuthState> mapEventToState(
    LoginAuthEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
