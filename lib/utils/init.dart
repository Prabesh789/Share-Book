import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sharebook/cubits/cubit/auth_cubit.dart';
import 'package:sharebook/utils/di.dart';

class AppInit {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    await initDependencyInjection();
  }
}
