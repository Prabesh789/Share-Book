import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sharebook/global/componenets/const.dart';
import 'package:sharebook/screens/upload_books/upload_books.dart';

class UserMainDashboard extends StatefulWidget {
  @override
  _UserMainDashboardState createState() => _UserMainDashboardState();
}

class _UserMainDashboardState extends State<UserMainDashboard> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal[200],
                  Colors.white,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              width: 200,
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: null,
                        ),
                        SizedBox(height: 10),
                        Text('User Name')
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.home),
                          title: Text('Home'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.person),
                          title: Text('Profile'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.logout),
                          title: Text('Log out'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: value),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            builder: (_, double val, __) {
              return (Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val)
                  ..rotateY(
                      (pi / 6) * val), //this allow to transform the screen
                child: MainDashboard(),
              ));
            },
          ),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },

            // onTap: () {
            //   setState(() {
            //     value == 0 ? value = 1 : value = 0;
            //   });
            // },
          )
        ],
      ),
    );
  }
}

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Avaiable Books',
          style: TextStyle(color: Colors.black),
        ),
        leading: SizedBox(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.upload_outlined,
              color: Colors.black,
              semanticLabel: 'Upload Book',
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UploadBook()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.only(left: 140),
            //   child: Image(
            //     image: AssetImage('assets/images/birdSwipe.gif'),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                //bottom: 36 + kDefaultPadding,
              ),
              height: size.height * 0.2 - 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    "Swipe me right  ...",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Image.asset("assets/images/birdSwipe.gif")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
