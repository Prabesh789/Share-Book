import 'dart:io';

class UploadBookModel {
  File bookImage;
  String bookTitle;
  String publishedDate;
  String selectedBookType;
  String shareType;
  String bookDescription;
  String amount;
  String uploadedBy;
  UploadBookModel({
    this.bookImage,
    this.bookTitle,
    this.publishedDate,
    this.selectedBookType,
    this.shareType,
    this.bookDescription,
    this.amount,
    this.uploadedBy,
  });
}
