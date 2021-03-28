import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sharebook/data/model/status.dart';
import 'package:sharebook/data/model/upload_book_model.dart';
import 'package:sharebook/repositories/user_repository.dart';

part 'upload_book_event.dart';
part 'upload_book_state.dart';

class UploadBookBloc extends Bloc<UploadBookEvent, UploadBookState> {
  final UserRepository _shareBookRepository;
  UploadBookBloc({@required UserRepository shareBookRepository})
      : assert(shareBookRepository != null),
        _shareBookRepository = shareBookRepository,
        super(UploadBookInitial());

  @override
  Stream<UploadBookState> mapEventToState(
    UploadBookEvent event,
  ) async* {}
}
