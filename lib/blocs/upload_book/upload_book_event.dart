part of 'upload_book_bloc.dart';

abstract class UploadBookEvent extends Equatable {
  const UploadBookEvent();

  @override
  List<Object> get props => [];
}

class AddUploadBook extends UploadBookEvent {
  final UploadBookModel uploadBookModel;

  AddUploadBook({this.uploadBookModel});

  @override
  List<Object> get props => [];
}
