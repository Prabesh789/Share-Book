import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharebook/cubits/cubit/auth_cubit.dart';
import 'package:sharebook/global/componenets/const.dart';
import 'package:sharebook/screens/login_screen/login_page.dart';
import 'package:sharebook/screens/user_homepage/user_home_page.dart';
import 'package:sharebook/screens/user_main_dashboard/user_main_dashboard.dart';
import 'package:sharebook/utils/di.dart';
import 'package:sharebook/utils/init.dart';

void main() async {
  await AppInit.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    inject<AuthCubit>().isAuthenticatedEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocConsumer<AuthCubit, AuthState>(
        cubit: inject<AuthCubit>(),
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthenticatedState) {
            return UserMainDashboard(
              userId: state.status.data,
            );
          } else if (state is UnAuthenticatedState) {
            return LoginPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
