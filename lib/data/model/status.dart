import 'package:flutter/material.dart';

class Status<T> {
  String message;
  bool isSuccess;
  T data;

  Status({
    @required this.message,
    @required this.isSuccess,
    @required this.data,
  });
}
