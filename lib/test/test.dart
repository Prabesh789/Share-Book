// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sharebook/global/componenets/const.dart';

// class OnTappedBookDescription extends StatefulWidget {
//   final String docId;
//   OnTappedBookDescription({@required this.docId});
//   @override
//   _OnTappedBookDescriptionState createState() =>
//       _OnTappedBookDescriptionState();
// }

// class _OnTappedBookDescriptionState extends State<OnTappedBookDescription> {
//   String docId;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         // leading: Image.asset("assets/images/birdSwipe.gif"),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           'Books Details',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Container(
//           height: size.height / 1.5,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 offset: Offset(0, 10),
//                 blurRadius: 50,
//                 color: kPrimaryColor.withOpacity(0.28),
//               ),
//             ],
//           ),
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection("books")
//                 .doc(widget.docId)
//                 .snapshots(),
//             builder: (context, snapshots) {
//               if (snapshots.data == null) {
//                 return CircularProgressIndicator(
//                   backgroundColor: Colors.teal[200],
//                 );
//               } else {
//                 final data = snapshots.data;
//                 final userId = data['uploadedBy'];
//                 return StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(userId)
//                       .snapshots(),
//                   builder: (context, ds) {
//                     if (ds.data == null) {
//                       return Container();
//                     } else {
//                       return SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CachedNetworkImage(imageUrl: data['bookImage']),
//                               Divider(thickness: 1),
//                               Text(
//                                 "Uploaded By : ${ds.data['fullName']}"
//                                     .toUpperCase(),
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Divider(thickness: 1),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Book Title: ",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   Text(
//                                     "${data['bookTitle']}".toUpperCase(),
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Divider(thickness: 1),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Share Type: ",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   Text("${data['selectedBookType']}"),
//                                 ],
//                               ),
//                               Divider(thickness: 1),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Amount: ",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   Text("${data['amount']}"),
//                                 ],
//                               ),
//                               Divider(thickness: 1),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Description: ",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   Text("${data['bookDescription']}"),
//                                 ],
//                               ),
//                               Divider(thickness: 1),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Published Date: ",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   Text("${data['publishedDate']}"),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
