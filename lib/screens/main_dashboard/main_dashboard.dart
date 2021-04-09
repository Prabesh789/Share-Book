import 'package:flutter/material.dart';
import 'package:sharebook/screens/main_dashboard/custom_container.dart';
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
  List<String> categories = [
    'Stories',
    'Novels',
    'College Books',
    'Research Papers',
    'Encyclopedia',
    'Others'
  ];
  String categoryType;

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
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return MyWidget(
                    pressed: () {
                      setState(() {
                        categoryType = categories[index];
                      });
                    },
                    toggle: false,
                    textColor: Colors.white,
                    height: size.height / 21,
                    width: size.width / 4,
                    title: categories[index],
                    // backgroundColor: Colors.white,
                  );
                },
              ),
            ),
            Expanded(
              child: CustomContainer(
                bookType: categoryType ?? categories[0],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
