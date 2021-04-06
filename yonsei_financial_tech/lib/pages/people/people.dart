import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';
import 'package:yonsei_financial_tech/components/color.dart';
import 'package:yonsei_financial_tech/components/components.dart';

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // MENU BAR ----------------------------------------------------------
                MenuBar(),
                // IMAGE BACKGROUND - NAME -------------------------------------------
                backImage(context),
                // About Us - INTRODUCTION -------------------------------------------
                yonseiPeople(context),
                // Meet Our People ---------------------------------------------------
                acaExPeople(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Container backImage(BuildContext context) {
  return Container(
    height: 600,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/yonsei_campus.png'),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Container yonseiPeople(BuildContext context) {
  var md = MediaQuery.of(context).size;
  return Container(
    color: themeBlue,
    padding: marginHorizontal(md.width * 0.6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("People", style: articleTitleTextStyle()),
        SizedBox(
          height: 80,
        ),
        Text("참여 교원", style: subtitleTextStyle),
      ],
    ),
  );
}

Container acaExPeople(BuildContext context) {
  var md = MediaQuery.of(context).size;

  return Container(
    //margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text(
      "People",
      style: articleTitleTextStyle(color: themeBlue),
    ),
  );
}

Container indusExPeople(BuildContext context) {
  var md = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text("Subtitle2"),
  );
}
