import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sharebook/data/model/status.dart';
import 'package:sharebook/data/model/user_model.dart';
import 'package:sharebook/repositories/share_book_impl.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ShareBookRepositoryImpl _shareBookRepository;
  RegisterBloc({@required ShareBookRepositoryImpl shareBookRepository})
      : assert(shareBookRepository != null),
        _shareBookRepository = shareBookRepository,
        super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is AddRegister) {
      yield RegisterLoadingState();

      final response =
          await _shareBookRepository.addShareBook(userModel: event.userModel);
      if (response.isSuccess) {
        yield RegisterAddedState(status: response);
      } else {
        yield RegisterErrorState(errorMessage: response.message);
      }
    }
  }
}
