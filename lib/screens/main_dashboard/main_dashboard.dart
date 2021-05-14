import 'package:flutter/material.dart';
import 'package:sharebook/global/app_strings.dart';
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
  List<bool> isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> categories = [
    'Stories',
    'Novels',
    'College Books',
    'Research Papers',
    'Encyclopedia',
    'Others'
  ];
  String categoryType;
  // RefreshController refreshController = RefreshController();
  // onRefresh() {
  //   refreshController.requestRefresh();
  //   refreshController.refreshCompleted();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavBar(userId: widget.userId),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        // leading: Image.asset("assets/images/birdSwipe.gif"),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          AppTexts.avaiablebooks,
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
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Padding(
            //     padding: const EdgeInsets.all(4),
            //     child: ToggleButtons(
            //       isSelected: isSelected,
            //       fillColor: Colors.teal[200],
            //       selectedColor: Colors.black,
            //       renderBorder: true,
            //       color: Colors.black,
            //       children: categories.map((e) {
            //         return Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(e),
            //         );
            //       }).toList(),
            //       onPressed: (int newIndex) {
            //         setState(
            //           () {
            //             for (int index = 0;
            //                 index < isSelected.length;
            //                 index++) {
            //               if (index == newIndex) {
            //                 isSelected[index] = true;

            //                 categoryType = categories[index];
            //               } else {
            //                 isSelected[index] = false;
            //               }
            //             }
            //           },
            //         );
            //       },
            //     ),
            //   ),
            // ),
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
                    // textColor: Colors.white,
                    height: size.height / 21,
                    width: size.width / 4,
                    title: categories[index],
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
