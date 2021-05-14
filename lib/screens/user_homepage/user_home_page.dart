import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharebook/global/app_colors.dart';

import 'package:sharebook/screens/main_dashboard/on_tapped_book_description.dart';

class UserHomePage extends StatefulWidget {
  final String userId;

  const UserHomePage({Key key, this.userId}) : super(key: key);
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Your Upload",
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
        stream: FirebaseFirestore.instance
            .collection('books')
            .where("uploadedBy", isEqualTo: widget.userId)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.data == null) {
            return Center(
              child: Text("Loading"),
            );
          } else if (snapshots.data.documents.length <= 0) {
            return Center(
              child: Text("No Books"),
            );
          } else {
            // return Text("data");
            return ListView.builder(
              itemCount: snapshots.data.documents.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 15),
                        blurRadius: 22,
                        color: kPrimaryColor.withOpacity(0.22),
                      ),
                      BoxShadow(
                        offset: Offset(-15, -15),
                        blurRadius: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OnTappedBookDescription(
                                docId: snapshots.data.docs[index].documentID,
                              )));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: size.height / 3.4,
                          width: size.width,
                          child: CachedNetworkImage(
                            imageUrl: snapshots.data.docs[index]['bookImage'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: kPrimaryColor.withOpacity(0.10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Book Title: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        snapshots.data.docs[index]['bookTitle']
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        "Published Date: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        snapshots.data.docs[index]
                                            ['publishedDate'],
                                        style: TextStyle(
                                          color: Colors.teal[700],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    snapshots.data.docs[index]['shareType'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    snapshots.data.docs[index]['amount'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
