import 'package:flutter/material.dart';
import 'package:ysfintech_admin/screens/dashboard/dashboard.dart';
import 'package:ysfintech_admin/screens/forms/form.dart';
import 'package:ysfintech_admin/screens/hero/hero_screen.dart';
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
    tabController = new TabController(vsync: this, length: 3, initialIndex: 0)
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
                child: Text("YSFINTECH Admin ", style: h1WhiteTextStyle),
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
              ? Container(
                  height: 40,
                  color: Colors.red,
                )
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
                Dashboard(),
                FormMaterial(),
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
        TextButton(
          style: TextButton.styleFrom(
            primary: tabController.index == 0 ? ligthGray : Colors.white,
          ),
          onPressed: () {
            tabController.animateTo(0);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.dashboard,
                  size: 24,
                  color: tabController.index == 0 ? Colors.black : ligthGray,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Dashboard",
                  style: tabController.index == 0 ? h2TextStyle : h3TextStyle,
                ),
              ]),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: tabController.index == 1 ? ligthGray : Colors.white,
          ),
          onPressed: () {
            print(tabController.index);
            tabController.animateTo(1);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.format_bold_rounded,
                  size: 24,
                  color: tabController.index == 1 ? Colors.black : ligthGray,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Forms",
                  style: tabController.index == 1 ? h2TextStyle : h3TextStyle,
                ),
              ]),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: tabController.index == 2 ? ligthGray : Colors.white,
          ),
          onPressed: () {
            tabController.animateTo(2);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.category_rounded,
                  size: 24,
                  color: tabController.index == 2 ? Colors.black : ligthGray,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Hero",
                  style: tabController.index == 2 ? h2TextStyle : h3TextStyle,
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
