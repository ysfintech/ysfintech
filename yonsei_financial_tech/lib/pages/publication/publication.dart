import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPageState createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
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

Stack title(BuildContext context) {
  var md = MediaQuery.of(context).size;
  // margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
  return Stack(
    children: <Widget>[
      Container(
          height: md.height * 0.58,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/introBackground.jpeg'),
            fit: BoxFit.cover,
          ))),
      Positioned(
        left: md.width * 0.07,
        top: md.width * 0.035,
        child: Container(
          width: md.width * 0.4,
          height: md.height * 0.4,
          child: Text("intro"),
        ),
      )
    ],
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
