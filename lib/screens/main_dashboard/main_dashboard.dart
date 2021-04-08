import 'package:flutter/material.dart';
import 'package:sharebook/screens/main_dashboard/my_widget.dart';
import 'package:sharebook/screens/main_dashboard/nav_bar.dart';
import 'package:sharebook/screens/upload_books/upload_books.dart';

class MainDashboard extends StatefulWidget {
  final String userId;

  const MainDashboard({Key key, @required this.userId}) : super(key: key);
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.teal[300]),
        // leading: Image.asset("assets/images/birdSwipe.gif"),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Avaiable Books',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.upload_outlined,
              color: Colors.black,
              semanticLabel: 'Upload Book',
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadBook(
                    userId: widget.userId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 20, top: 10),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      MyWidget(
                        textColor: Colors.white,
                        height: size.height / 21,
                        width: size.width / 4,
                        title: "Story Books",
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 10),
                      MyWidget(
                        textColor: Colors.white,
                        height: size.height / 21,
                        width: size.width / 3 - 10,
                        title: "Nobel Books",
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 10),
                      MyWidget(
                        textColor: Colors.white,
                        height: size.height / 21,
                        width: size.width / 3 - 20,
                        title: "Encyclopedia",
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 10),
                      MyWidget(
                        textColor: Colors.white,
                        height: size.height / 21,
                        width: size.width / 3,
                        title: "College Books",
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 10),
                      MyWidget(
                        textColor: Colors.white,
                        height: size.height / 21,
                        width: size.width / 3,
                        title: "Research Papers",
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 10),
                      MyWidget(
                        textColor: Colors.white,
                        height: size.height / 21,
                        width: size.width / 4,
                        title: "Others",
                        backgroundColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
