import 'dart:math';
import 'package:flutter/material.dart';

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
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    title: Text(
                      'Avaiable Books',
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.upload_outlined,
                          color: Colors.black,
                          semanticLabel: 'Upload Book',
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  body: Center(
                    child: Text('Swipe Right'),
                  ),
                ),
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
