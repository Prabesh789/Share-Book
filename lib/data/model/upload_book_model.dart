import 'dart:io';

class UploadBookModel {
  File bookImage;
  String bookTitle;
  int publishedDate;
  String selectedBookType;
  String shareType;
  String bookDescription;
  double amount;
  UploadBookModel({
    this.bookImage,
    this.bookTitle,
    this.publishedDate,
    this.selectedBookType,
    this.shareType,
    this.bookDescription,
    this.amount,
  });
}
