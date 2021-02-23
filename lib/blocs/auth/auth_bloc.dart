import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sharebook/data/model/status.dart';
import 'package:sharebook/data/model/user_model.dart';
import 'package:sharebook/repositories/share_book_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ShareBookRepositoryImpl _shareBookRepository;
  AuthBloc({@required ShareBookRepositoryImpl shareBookRepository})
      : assert(shareBookRepository != null),
        _shareBookRepository = shareBookRepository,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is IsAuthenticatedEvent) {
      final response = await _shareBookRepository.isLoggedIn();
      if (response) {
        yield AuthenticatedState();
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
        AuthErrorState(errorMessage: "Failed to login !");
      }
    }
  }
}
