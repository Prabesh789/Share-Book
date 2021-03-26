import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sharebook/data/model/status.dart';
import 'package:sharebook/data/model/user_model.dart';
import 'package:sharebook/repositories/user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository _shareBookRepository;
  AuthCubit({@required UserRepository shareBookRepository})
      : assert(shareBookRepository != null),
        _shareBookRepository = shareBookRepository,
        super(AuthInitial());

  Future<void> isAuthenticatedEvent() async {
    final response = await _shareBookRepository.isLoggedIn();
    if (response != null) {
      emit(AuthenticatedState(
          status:
              Status(data: response, isSuccess: true, message: "Logged In !")));
    } else {
      emit(UnAuthenticatedState());
    }
  }

  Future<void> loginEvent({UserModel userModel}) async {
    emit(AuthLoadingState());
    final response = await _shareBookRepository.loginUser(userModel: userModel);
    if (response.isSuccess) {
      emit(AuthenticatedState(status: response));
    } else {
      emit(AuthErrorState(errorMessage: response.message));
    }
  }
}
