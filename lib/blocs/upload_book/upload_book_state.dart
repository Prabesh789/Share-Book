part of 'upload_book_bloc.dart';

abstract class UploadBookState extends Equatable {
  const UploadBookState();

  @override
  List<Object> get props => [];
}

class UploadBookInitial extends UploadBookState {
  @override
  List<Object> get props => [];
}

class UploadBookLoadingState extends UploadBookState {
  @override
  List<Object> get props => [];
}

class UploadBookAddedState extends UploadBookState {
  final Status status;

  UploadBookAddedState({this.status});
  @override
  List<Object> get props => [status];
}

class UploadBookErrorState extends UploadBookState {
  final String errorMessage;

  UploadBookErrorState({this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
