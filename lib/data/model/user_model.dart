import 'dart:io';

class UserModel {
  final File image;
  final String fullName;
  final String password;
  final String contact;
  final String email;

  UserModel({
    this.image,
    this.password,
    this.fullName,
    this.contact,
    this.email,
  });
}
