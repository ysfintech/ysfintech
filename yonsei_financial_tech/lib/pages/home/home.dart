import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                title(context),
                // About Us - INTRODUCTION -------------------------------------------
                aboutUs(context),
                // Meet Our People ---------------------------------------------------
                meetOutPeople(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Container title(BuildContext context) {
  var md = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text("images and Title"),
  );
}

Container aboutUs(BuildContext context) {

  var md = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text("About Us"),
  );
}

Container meetOutPeople(BuildContext context) {
  var md = MediaQuery.of(context).size; 

  return Container(
    margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text("Meet Out People"),
  );
}