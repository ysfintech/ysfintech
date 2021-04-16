import 'package:flutter/material.dart';
import 'package:ysfintech_admin/screens/board/paper_screen.dart';
import 'package:ysfintech_admin/screens/dashboard/dashboard.dart';
import 'package:ysfintech_admin/screens/forms/form.dart';
import 'package:ysfintech_admin/screens/hero/hero_screen.dart';
import 'package:ysfintech_admin/screens/info/info_screen.dart';
import 'package:ysfintech_admin/screens/project/project_screen.dart';
import 'package:ysfintech_admin/screens/info/info.dart';
import 'package:ysfintech_admin/screens/people/people.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/typography.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int active = 0;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 5, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width < 1300 ? true : false,
        title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 32),
                child: Text("YSFINTECH Admin ", style: h2WhiteTextStyle),
              ),
            ]),
        actions: <Widget>[
          Container(
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.exit_to_app_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(width: 32),
        ],
        backgroundColor: themeBlue,
        // automaticallyImplyLeading: false,
      ),
      body: Row(
        children: <Widget>[
          MediaQuery.of(context).size.width < 1300
              ? Container()
              : Card(
                  elevation: 2.0,
                  child: Container(
                      margin: EdgeInsets.all(0),
                      height: MediaQuery.of(context).size.height,
                      width: 300,
                      color: Colors.white,
                      child: listDrawerItems(false)),
                ),
          Container(
            width: MediaQuery.of(context).size.width < 1300
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 310,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                IntroPage(),
                PeoplePage(),
                ProjectScreen(),
                PaperScreen(),
                HeroAnimation(),
              ],
            ),
          )
        ],
      ),
      drawer: Padding(
          padding: EdgeInsets.only(top: 56),
          child: Drawer(child: listDrawerItems(true))),
    );
  }

  Widget listDrawerItems(bool drawerStatus) {
    return ListView(
      children: <Widget>[
        listItemNavigator(drawerStatus,
            pageIndex: 0,
            title: "Introduction &\n Education",
            icon: Icons.info_rounded),
        listItemNavigator(drawerStatus,
            pageIndex: 1, title: "People", icon: Icons.people_alt_rounded),
        listItemNavigator(drawerStatus,
            pageIndex: 2, title: "Project", icon: Icons.science_rounded),
        listItemNavigator(drawerStatus,
            pageIndex: 3,
            title: "Working Paper",
            icon: Icons.library_books_rounded),
        listItemNavigator(drawerStatus,
            pageIndex: 4, title: "Publication", icon: Icons.storage_rounded),
      ],
    );
  }

  TextButton listItemNavigator(bool drawerStatus,
      {@required int pageIndex, @required String title, IconData icon}) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: tabController.index == pageIndex ? ligthGray : Colors.white,
      ),
      onPressed: () {
        print(tabController.index);
        tabController.animateTo(pageIndex);
        drawerStatus ? Navigator.pop(context) : print("");
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(
              icon != null ? icon : Icons.description_rounded,
              size: 24,
              color:
                  tabController.index == pageIndex ? Colors.black : ligthGray,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: tabController.index == pageIndex
                  ? h3TextStyle
                  : bodyTextStyle,
            ),
          ]),
        ),
      ),
    );
  }
}
