import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sharebook/blocs/upload_book/upload_book_bloc.dart';
import 'package:sharebook/data/model/upload_book_model.dart';
import 'package:sharebook/global/componenets/const.dart';
import 'package:intl/intl.dart';
import 'package:sharebook/utils/di.dart';

class UploadBook extends StatefulWidget {
  final String userId;

  const UploadBook({Key key, @required this.userId}) : super(key: key);
  @override
  _UploadBookState createState() => _UploadBookState();
}

class _UploadBookState extends State<UploadBook> {
  File _bookImage;
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookDescriptionController =
      TextEditingController();
  final TextEditingController bookAddressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    bookNameController.dispose();
    bookDescriptionController.dispose();
    bookAddressController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  var selectedType;
  var shareType;
  List<String> _bookType = <String>[
    'Stories',
    'Novels',
    'College Books',
    'Research Papers',
    'Encyclopedia',
    'Others'
  ];
  List<String> _shareType = <String>['Rent', 'Sale', 'Free', 'Others'];

  int pickedDate;

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      //
    );

    if (_datePicker != null) {
      setState(() {
        pickedDate = _datePicker.microsecondsSinceEpoch;

        dateController.text = DateFormat('MMM dd,yyyy').format(_datePicker);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocConsumer<UploadBookBloc, UploadBookState>(
          cubit: inject<UploadBookBloc>(),
          listener: (context, state) {
            if (state is UploadBookErrorState) {
              Fluttertoast.showToast(
                msg: "Failed to upload book...!",
                backgroundColor: Colors.teal[100],
                textColor: Colors.red,
              );
            }
            if (state is UploadBookAddedState) {
              Fluttertoast.showToast(
                msg: "Successfully uploaded.",
                backgroundColor: Colors.white,
                textColor: Colors.green[300],
              );
              bookNameController.clear();
              bookDescriptionController.clear();
              bookAddressController.clear();
              amountController.clear();
              dateController.clear();
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text(
                  'Upload book Status',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Stack(
                        children: <Widget>[
                          _bookImage != null
                              ? Container(
                                  height: size.height * 0.3 - 20,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 50,
                                        color: kPrimaryColor.withOpacity(0.10),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(File(_bookImage.path)),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: size.height * 0.3 - 20,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 10),
                                        blurRadius: 50,
                                        color: kPrimaryColor.withOpacity(0.10),
                                      ),
                                    ],
                                  ),
                                ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => bottonSheet()));
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Upload Book Image'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: size.height * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: kPrimaryColor.withOpacity(0.10),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: bookNameTextField(bookNameController),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: dateController,
                                  readOnly: true,
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Publish date cannot be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: Colors.teal[300],
                                    ),
                                    contentPadding: EdgeInsets.all(8),
                                    labelText: 'Date of published',
                                    labelStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    suffix: Image.asset(
                                      'assets/images/event.gif',
                                      height: 30,
                                      width: 30,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: DropdownButtonFormField(
                                  items: _bookType
                                      .map((value) => DropdownMenuItem(
                                            child: Text(value),
                                            value: value,
                                          ))
                                      .toList(),
                                  onChanged: (selectedBookType) {
                                    if (mounted)
                                      setState(() {
                                        selectedType = selectedBookType;
                                      });
                                  },
                                  value: selectedType,
                                  isExpanded: false,
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
                                      color: Colors.black,
                                    )),
                                    prefixIcon: Icon(
                                      Icons.insert_emoticon,
                                      color: Colors.teal[400],
                                    ),
                                    labelText: 'Select Book Type',
                                    labelStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: DropdownButtonFormField(
                                  items: _shareType
                                      .map((value) => DropdownMenuItem(
                                            child: Text(value),
                                            value: value,
                                          ))
                                      .toList(),
                                  onChanged: (shareBookType) {
                                    if (mounted)
                                      setState(() {
                                        shareType = shareBookType;
                                      });
                                  },
                                  value: shareType,
                                  isExpanded: false,
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
                                      color: Colors.black,
                                    )),
                                    prefixIcon: Icon(
                                      Icons.share,
                                      color: Colors.teal[400],
                                    ),
                                    labelText: 'Share Type',
                                    labelStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: bookDescriptionTextField(
                                    bookDescriptionController),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: amountTextField(amountController),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.teal[200],
                      child: Text('Upload'),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (_formKey.currentState.validate()) {
                          inject<UploadBookBloc>().add(
                            AddUploadBook(
                              uploadBookModel: UploadBookModel(
                                bookTitle: bookNameController.text.trim(),
                                bookDescription:
                                    bookDescriptionController.text.trim(),
                                bookImage: _bookImage,
                                amount: amountController.text.trim(),
                                publishedDate: dateController.text.trim(),
                                selectedBookType: selectedType,
                                shareType: shareType,
                                uploadedBy: widget.userId,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
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
      _bookImage = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }
}

Widget bookNameTextField(TextEditingController bookNameController) {
  return TextFormField(
    controller: bookNameController,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black12,
        )),
        prefixIcon: Icon(
          Icons.book,
          color: Colors.teal[300],
        ),
        labelText: 'Book Title',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'शिरीषको फूल / Siris Ko Phool'),
    validator: (value) {
      if (value.isEmpty) {
        return 'Book Name is Empty';
      } else {
        return null;
      }
    },
  );
}

Widget bookDescriptionTextField(
    TextEditingController bookDescriptionController) {
  return TextFormField(
    maxLines: 5,
    controller: bookDescriptionController,
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
          Icons.description,
          color: Colors.teal[300],
        ),
        labelText: 'Book Description',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'शिरीषको फूल / Siris Ko Phool ..........'),
    validator: (value) {
      if (value.isEmpty) {
        return 'Book description is Empty';
      } else {
        return null;
      }
    },
  );
}

Widget amountTextField(TextEditingController amountController) {
  return TextFormField(
    controller: amountController,
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
          Icons.money,
          color: Colors.teal[300],
        ),
        labelText: 'Amount',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: '100/-'),
    validator: (value) {
      if (value.isEmpty) {
        return 'Price is empty';
      } else {
        return null;
      }
    },
  );
}
