import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  final bool toggle;
  final double height;
  final double width;
  final String title;
  // final Color backgroundColor;
  final Color textColor;
  final VoidCallback pressed;

  const MyWidget(
      {Key key,
      @required this.height,
      @required this.pressed,
      @required this.toggle,
      @required this.width,
      @required this.title,
      // @required this.backgroundColor,
      @required this.textColor})
      : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool toggled = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.pressed();
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Center(
          child: Text(
            "${widget.title}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: widget.toggle ? Colors.teal[500] : Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.teal[100],
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
      ),
    );
  }
}
