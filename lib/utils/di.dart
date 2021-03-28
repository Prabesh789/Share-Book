import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sharebook/blocs/auth/auth_bloc.dart';
import 'package:sharebook/blocs/register/register_bloc.dart';
import 'package:sharebook/repositories/share_book_impl.dart';

final GetIt inject = GetIt.instance;

Future<void> initDependencyInjection() async {
  WidgetsFlutterBinding.ensureInitialized();

  _registerRepository();
  _registerBlocs();
  _userAuth();
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
