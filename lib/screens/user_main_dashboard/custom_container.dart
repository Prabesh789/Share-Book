import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String bookType;

  const CustomContainer({Key key, @required this.bookType}) : super(key: key);
  @override
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
      child: Container(
        height: size.height / 2 - 195,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 10,
              spreadRadius: 10,
              color: Colors.indigo[50].withOpacity(0.4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[Container()],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: size.width / 2,
                  height: size.height / 20,
                  child: Container(
                    child: Text(
                      "${widget.bookType}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
