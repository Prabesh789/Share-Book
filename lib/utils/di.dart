import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sharebook/blocs/register/register_bloc.dart';
import 'package:sharebook/repositories/share_book_impl.dart';

final GetIt inject = GetIt.instance;

Future<void> initDependencyInjection() async {
  WidgetsFlutterBinding.ensureInitialized();

  _registerRepository();
  _registerBlocs();
}

void _registerRepository() {
  inject.registerLazySingleton(() => ShareBookRepositoryImpl());
}

void _registerBlocs() {
  inject
      .registerLazySingleton(() => RegisterBloc(shareBookRepository: inject()));
}
