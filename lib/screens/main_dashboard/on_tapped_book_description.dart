import 'package:flutter/material.dart';

class OnTappedBookDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        
      ),
    );
  }
}
