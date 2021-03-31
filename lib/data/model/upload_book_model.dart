import 'dart:io';

class UploadBookModel {
  final File bookImage;
  final String bookTitle;
  final String publishedDate;
  final String selectedBookType;
  final String shareType;
  final String bookDescription;
  final String amount;
  final String uploadedBy;
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
