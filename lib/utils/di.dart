import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sharebook/blocs/auth/auth_bloc.dart';
import 'package:sharebook/blocs/register/register_bloc.dart';
import 'package:sharebook/blocs/upload_book/upload_book_bloc.dart';
import 'package:sharebook/repositories/user_repository.dart';

final GetIt inject = GetIt.instance;

Future<void> initDependencyInjection() async {
  WidgetsFlutterBinding.ensureInitialized();

  _registerRepository();
  _registerBlocs();
  _userAuth();
  _uploadBook();
}

void _registerRepository() {
  inject.registerLazySingleton(() => UserRepository());
}

void _registerBlocs() {
  inject
      .registerLazySingleton(() => RegisterBloc(shareBookRepository: inject()));
}

void _userAuth() {
  inject.registerLazySingleton(() => AuthBloc(shareBookRepository: inject()));
}

void _uploadBook() {
  inject.registerLazySingleton(
      () => UploadBookBloc(shareBookRepository: inject()));
}
