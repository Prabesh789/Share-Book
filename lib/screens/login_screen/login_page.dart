import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sharebook/blocs/auth/auth_bloc.dart';
import 'package:sharebook/data/model/user_model.dart';
import 'package:sharebook/global/componenets/const.dart';
import 'package:sharebook/screens/main_dashboard/main_dashboard.dart';
import 'package:sharebook/screens/register/register_page.dart';
import 'package:sharebook/utils/di.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthBloc, AuthState>(
      cubit: inject<AuthBloc>(),
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Fluttertoast.showToast(
            msg: state.status.message,
            backgroundColor: Colors.white,
            textColor: Colors.green,
          );
          userEmailController.clear();
          passwordController.clear();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => MainDashboard(
                userId: state.status.data,
              ),
            ),
          );
        }
        if (state is AuthErrorState) {
          Fluttertoast.showToast(
            msg: state.errorMessage,
            backgroundColor: Colors.white,
            textColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formkey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                                image:
                                    AssetImage('assets/images/book read.png')),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "'' Books are a uniquely portable magic ''",
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      height: size.height * 0.4 - 45,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(36),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimaryColor.withOpacity(0.28),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10),
                            Text(
                              "Please Login",
                              style: TextStyle(
                                fontSize: 18,
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: userNameTextField(userEmailController),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: passwoerdTextField(passwordController),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 350),
                                decoration: BoxDecoration(
                                  color: Colors.teal[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 50,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 350),
                                  child: (state is AuthLoadingState)
                                      ? Center(
                                          child: SpinKitRing(
                                            size: 20,
                                            lineWidth: 4,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Center(
                                          child: InkWell(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 50,
                                              child: Text(
                                                "Login",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              if (!_formkey.currentState
                                                  .validate()) {
                                                Fluttertoast.showToast(
                                                  msg: 'Invalid details',
                                                  backgroundColor: Colors.white,
                                                  textColor: Colors.red,
                                                );
                                              } else {
                                                inject<AuthBloc>().add(
                                                  LoginEvent(
                                                    userModel: UserModel(
                                                      email: userEmailController
                                                          .text
                                                          .trim(),
                                                      password:
                                                          passwordController
                                                              .text
                                                              .trim(),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            // RaisedButton(
                            //   elevation: 5,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10.0)),
                            //   color: Colors.teal[200],
                            //   child: Text(
                            //     "Login",
                            //     style: TextStyle(fontSize: 16),
                            //   ),
                            //   onPressed: () {
                            //     if (!_formkey.currentState.validate()) {
                            //       Fluttertoast.showToast(
                            //         msg: 'Invalid details',
                            //         backgroundColor: Colors.white,
                            //         textColor: Colors.red,
                            //       );
                            //     } else {
                            //       inject<AuthBloc>().add(
                            //         LoginEvent(
                            //           userModel: UserModel(
                            //             email: userEmailController.text.trim(),
                            //             password:
                            //                 passwordController.text.trim(),
                            //           ),
                            //         ),
                            //       );
                            //     }
                            //   },
                            // ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Don\'t Have Account.',
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: 'Get Started',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget userNameTextField(TextEditingController userEmailController) {
  return TextFormField(
    controller: userEmailController,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black12,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.teal[300],
        ),
        labelText: 'User Email',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'Jackie_Chan'),
    validator: (value) {
      if (value.isEmpty) {
        return 'User Email Can not be empty';
      } else {
        return null;
      }
    },
  );
}

Widget passwoerdTextField(TextEditingController passwordController) {
  return TextFormField(
    controller: passwordController,
    validator: (value) {
      if (value.length < 6) {
        return "Legnth must be min 6 character";
      }
      return null;
    },
    obscureText: true,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.teal[300],
        ),
        labelText: 'Password',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'Password'),
    keyboardType: TextInputType.emailAddress,
  );
}
