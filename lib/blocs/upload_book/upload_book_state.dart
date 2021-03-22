part of 'upload_book_bloc.dart';

abstract class UploadBookState extends Equatable {
  const UploadBookState();
  
  @override
  List<Object> get props => [];
}

class UploadBookInitial extends UploadBookState {}
