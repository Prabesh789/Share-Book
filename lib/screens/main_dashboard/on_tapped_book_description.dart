import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharebook/global/componenets/const.dart';

class OnTappedBookDescription extends StatefulWidget {
  final String docId;
  OnTappedBookDescription({@required this.docId});
  @override
  _OnTappedBookDescriptionState createState() =>
      _OnTappedBookDescriptionState();
}

class _OnTappedBookDescriptionState extends State<OnTappedBookDescription> {
  String docId;

  // @override
  // void initState() {
  //   FirebaseFirestore.instance.collection('books').doc(docId).get();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.teal[300]),
        // leading: Image.asset("assets/images/birdSwipe.gif"),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Books Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("books")
            .doc(widget.docId)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.data == null) {
            return CircularProgressIndicator(
              backgroundColor: Colors.teal[200],
            );
          } else {
            final data = snapshots.data;
            final userId = data['uploadedBy'];
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .snapshots(),
              builder: (context, ds) {
                if (ds.data == null) {
                  return Container();
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("${data['bookTitle']}"),
                        Text("${data['amount']}"),
                        Text("${data['bookDescription']}"),
                        Text("${data['publishedDate']}"),
                        Text("${data['selectedBookType']}"),
                        CachedNetworkImage(imageUrl: data['bookImage']),
                        Container(
                          child: Text("Uploaded By :${ds.data['fullName']}"),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
