// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sharebook/global/componenets/const.dart';

// class CustomContainer extends StatefulWidget {
//   final String bookType;
//   final IconData icon;
//   //if datatype is widget then, j ne pass grna milxa
//   final Widget container;

//   const CustomContainer(
//       {Key key,
//       @required this.bookType,
//       @required this.icon,
//       @required this.container})
//       : super(key: key);
//   @override
//   _CustomContainerState createState() => _CustomContainerState();
// }

// class _CustomContainerState extends State<CustomContainer> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
//       child: Container(
//         height: size.height / 2 - 150,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(
//             Radius.circular(10),
//           ),
//           boxShadow: [
//             BoxShadow(
//               offset: Offset(0, 15),
//               blurRadius: 10,
//               spreadRadius: 10,
//               color: Colors.indigo[50].withOpacity(0.4),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 5.0),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: SizedBox(
//                   width: size.width,
//                   height: size.height / 20,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       // color: Colors.teal[200],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           width: 200,
//                           child: Text(
//                             "${widget.bookType}",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 100),
//                         Expanded(
//                           child: Icon(widget.icon),
//                         )
//                         //Icon(widget.icon)
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             Container(
//               height: size.height / 3 - 66,
//               // color: Colors.green,
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("books")
//                     .where("selectedBookType", isEqualTo: widget.bookType)
//                     .snapshots(),
//                 builder: (context, snapshots) {
//                   return ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: snapshots.data.documents.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(left: 4.0, bottom: 4),
//                         child: Container(
//                           height: size.height * 0.8,
//                           width: size.width * 0.43,
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(6),
//                             // boxShadow: [
//                             //   BoxShadow(
//                             //     offset: Offset(0, 15),
//                             //     blurRadius: 22,
//                             //     color: kPrimaryColor.withOpacity(0.22),
//                             //   ),
//                             //   BoxShadow(
//                             //     offset: Offset(-15, -15),
//                             //     blurRadius: 20,
//                             //     color: Colors.white,
//                             //   ),
//                             // ],
//                           ),
//                           child: Column(
//                             children: <Widget>[
//                               SizedBox(height: 147),
//                               // Image.asset(snapshots.data['bookImage']),
//                               Container(
//                                 padding: EdgeInsets.all(kDefaultPadding / 2),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10),
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       offset: Offset(0, 10),
//                                       blurRadius: 50,
//                                       color: kPrimaryColor.withOpacity(0.10),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Row(
//                                   children: <Widget>[
//                                     RichText(
//                                       text: TextSpan(
//                                           // children: [
//                                           //   TextSpan(
//                                           //       text: "$title\n".toUpperCase(),
//                                           //       style: Theme.of(context).textTheme.button),
//                                           //   TextSpan(
//                                           //     text: "$country".toUpperCase(),
//                                           //     style: TextStyle(
//                                           //       color: kPrimaryColor.withOpacity(0.5),
//                                           //     ),
//                                           //   ),
//                                           // ],
//                                           ),
//                                     ),
//                                     Spacer(),
//                                     // Text(
//                                     //   '\$$price',
//                                     //   style: Theme.of(context)
//                                     //       .textTheme
//                                     //       .button
//                                     //       .copyWith(color: kPrimaryColor),
//                                     // )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             // ListView(
//             //   scrollDirection: Axis.horizontal,
//             //   children: <Widget>[widget.container],
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
