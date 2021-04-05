import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {

  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: <Widget>[
                // MENU BAR ----------------------------------------------------------
                MenuBar(),
                // IMAGE BACKGROUND - NAME -------------------------------------------
                ourMission(context),
                // About Us - INTRODUCTION -------------------------------------------
                articleShort(context),
                // Meet Our People ---------------------------------------------------
                articleLong(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Container ourMission(BuildContext context) {
  var md = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text("Our Mission"),
  );
}

Container articleShort(BuildContext context) {

  var md = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text("Subtitle1"),
  );
}

Container articleLong(BuildContext context) {
  var md = MediaQuery.of(context).size; 

  return Container(
    margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text("Subtitle2"),
  );
}