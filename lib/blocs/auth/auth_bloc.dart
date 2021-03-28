import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sharebook/data/model/status.dart';
import 'package:sharebook/data/model/user_model.dart';
import 'package:sharebook/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _shareBookRepository;
  AuthBloc({@required UserRepository shareBookRepository})
      : assert(shareBookRepository != null),
        _shareBookRepository = shareBookRepository,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is IsAuthenticatedEvent) {
      final response = await _shareBookRepository.isLoggedIn();
      if (response != null) {
        yield AuthenticatedState(
            status: Status(
                data: response, isSuccess: true, message: "Logged In !"));
      } else {
        yield UnAuthenticatedState();
      }
    }
    if (event is LoginEvent) {
      yield AuthLoadingState();
      final response =
          await _shareBookRepository.loginUser(userModel: event.userModel);
      if (response.isSuccess) {
        yield AuthenticatedState(status: response);
      } else {
        yield AuthErrorState(errorMessage: response.message);
      }
    }
  }
}
