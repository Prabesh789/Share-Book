import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharebook/global/app_colors.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String uid;
  bool isEdit = false; //To edit Bio
  var focusNode = FocusNode(); //Enable focused for Bio field
  TextEditingController contactcontroller = TextEditingController();
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user != null) {
        setState(() {
          uid = user.uid;
        });
      }
    });
    super.initState();
  }

  void updateContact() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'bio': contactcontroller.text.trim()});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Your Profile",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 40),
                child: Container(
                  height: size.height / 1.2,
                  width: size.width - 50,
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
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            CachedNetworkImageProvider(snapshot.data['image']),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full Name",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${snapshot.data['fullName']}',
                              style: TextStyle(fontSize: 15),
                            ),
                            Divider(),
                            Text(
                              "Contact",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${snapshot.data['contact']} ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Divider(),
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${snapshot.data['email']} ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
