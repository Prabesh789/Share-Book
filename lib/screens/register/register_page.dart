import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharebook/blocs/register/register_bloc.dart';
import 'package:sharebook/data/model/user_model.dart';
import 'package:sharebook/global/componenets/const.dart';
import 'package:sharebook/utils/di.dart';
import 'package:validators/validators.dart' as validator;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  bool _obscureText = true;

  void dspose() {
    fullNameController.dispose();
    contactController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showPassword() {
    if (mounted) if (mounted)
      setState(() {
        _obscureText = !_obscureText;
      });
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<RegisterBloc, RegisterState>(
      cubit: inject<RegisterBloc>(),
      listener: (context, state) {
        if (state is RegisterErrorState) {
          Fluttertoast.showToast(
            msg: state.errorMessage,
            backgroundColor: Colors.white,
            textColor: Colors.red,
          );
        }
        if (state is RegisterAddedState) {
          Fluttertoast.showToast(
            msg: state.status.message,
            backgroundColor: Colors.white,
            textColor: Colors.green,
          );
          fullNameController.clear();
          passwordController.clear();
          contactController.clear();
          emailController.clear();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldkey,
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Image(
                            image: AssetImage('assets/images/register.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formkey,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: size.height * 0.5 + 60,
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
                            SizedBox(height: 8),
                            Text(
                              'Please Register',
                              style: TextStyle(
                                fontSize: 18,
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 60.0,
                                    backgroundColor: Colors.teal[100],
                                    backgroundImage: _imageFile == null
                                        ? AssetImage("assets/images/user.png")
                                        : FileImage(File(_imageFile.path)),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    right: 20,
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) =>
                                                bottonSheet()));
                                      },
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              padding: EdgeInsets.all(4),
                              child: fullNameTextField(fullNameController),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              padding: EdgeInsets.all(4),
                              child: contactTextField(contactController),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              padding: EdgeInsets.all(4),
                              child: emailTextField(emailController),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                obscureText: _obscureText,
                                controller: passwordController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.teal,
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black12,
                                    )),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.teal[300],
                                    ),
                                    suffixIcon: FlatButton(
                                        onPressed: _showPassword,
                                        child: new Text(
                                            _obscureText ? "Show" : "Hide")),
                                    labelText: 'Create Password',
                                    labelStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                    hintText: 'Password'),
                                validator: (value) {
                                  if (value.length < 6) {
                                    return "Legnth must be min 6 character";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(Icons.arrow_back_ios),
                                ),
                                SizedBox(width: 100),
                                RaisedButton(
                                  elevation: 7,
                                  child: Text('SignUp'),
                                  color: Colors.teal[200],
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    if (_formkey.currentState.validate()) {
                                      inject<RegisterBloc>().add(
                                        AddRegister(
                                          userModel: UserModel(
                                            fullName:
                                                fullNameController.text.trim(),
                                            contact:
                                                contactController.text.trim(),
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                          ),
                                        ),
                                      );
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: 'Invalid details',
                                        backgroundColor: Colors.white,
                                        textColor: Colors.red,
                                      );
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

//Container after clicking on camera icon
  Widget bottonSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose profile photo",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

//taking a picture from camera or gallery
  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
    Navigator.of(context).pop();
  }
}

Widget fullNameTextField(TextEditingController fullNameController) {
  return TextFormField(
    controller: fullNameController,
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
        labelText: 'Full Name',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'Jackie Chan'),
    validator: (value) {
      if (value.isEmpty) {
        return 'Please enter your name.';
      }
      return null;
    },
  );
}

Widget contactTextField(TextEditingController contactController) {
  return TextFormField(
    keyboardType: TextInputType.phone,
    controller: contactController,
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
          Icons.phone_android,
          color: Colors.teal[300],
        ),
        labelText: 'Contact Number',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: '+977 9863775501'),
    validator: (value) {
      if (value.isEmpty) {
        return 'Enter your contact number';
      }
      return null;
    },
  );
}

Widget emailTextField(TextEditingController emailController) {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    controller: emailController,
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
          Icons.email,
          color: Colors.teal[300],
        ),
        labelText: 'Email Address',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'rai@gmail.com'),
    validator: (String value) {
      if (!validator.isEmail(value)) {
        return 'Please enter valid email';
      }
      return null;
    },
  );
}
