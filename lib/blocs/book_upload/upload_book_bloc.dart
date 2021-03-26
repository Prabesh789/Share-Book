import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sharebook/data/model/status.dart';
import 'package:sharebook/data/model/upload_book_model.dart';

part 'upload_book_event.dart';
part 'upload_book_state.dart';

class UploadBookBloc extends Bloc<UploadBookEvent, UploadBookState> {
  UploadBookBloc() : super(UploadBookInitial());

  @override
  Stream<UploadBookState> mapEventToState(
    UploadBookEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
