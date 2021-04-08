import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  // final Function onTab;

  const MyWidget(
      {Key key,
      @required this.height,
      // @required this.onTab,
      @required this.width,
      @required this.title,
      @required this.backgroundColor,
      @required this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (context) => this.onTab()));
      // },
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Center(
          child: Text(
            "$title",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(
                10,
                15,
              ),
              blurRadius: 10,
              spreadRadius: 10,
              color: Colors.indigo[50].withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}
