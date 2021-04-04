import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String bookType;
  //final IconData icon;
  //if datatype is widget then, j ne pass grna milxa
  final Widget container;

  const CustomContainer(
      {Key key,
      @required this.bookType,
      // @required this.icon,
      @required this.container})
      : super(key: key);
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
              children: <Widget>[widget.container],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: size.width,
                  height: size.height / 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.teal[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${widget.bookType}",
                          style: TextStyle(fontSize: 18),
                        ),
                        //Icon(widget.icon)
                      ],
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
