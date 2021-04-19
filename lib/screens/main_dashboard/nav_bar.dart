import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharebook/screens/login_screen/login_page.dart';
import 'package:sharebook/screens/user_homepage/user_home_page.dart';
import 'package:sharebook/screens/user_profile/user_profile.dart';

class NavBar extends StatefulWidget {
  final String userId;

  const NavBar({Key key, this.userId}) : super(key: key);
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double value = 0;
  // String uid;

  // @override
  // void initState() {
  //   FirebaseAuth.instance.authStateChanges().listen((User user) async {
  //     if (user != null) {
  //       setState(() {
  //         uid = user.uid;
  //       });
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          print(snapshot);
          if (!snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1572061486195-d811e12d0a10?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1351&q=80",
                      ),
                    ),
                  ),
                  child: DrawerHeader(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.teal[50],
                            backgroundImage: CachedNetworkImageProvider(
                                snapshot.data['image']),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${snapshot.data['fullName']}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${snapshot.data['email']}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserHomePage(
                                  userId: widget.userId,
                                )));
                  },
                  leading: Icon(Icons.home),
                  title: Text('My Books'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserProfile()));
                  },
                  leading: Icon(Icons.person),
                  title: Text('My details'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                ListTile(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut().then((value) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (contect) => LoginPage()));
                    });
                  },
                  leading: Icon(Icons.logout),
                  title: Text('Log out'),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
