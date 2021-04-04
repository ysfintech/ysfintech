import 'package:flutter/material.dart';

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {

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
                
                // IMAGE BACKGROUND - NAME -------------------------------------------
                searchTab(context),
                // Board  ------------------------------------------------------------
                board(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Container searchTab(BuildContext context) {
  var md = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text("search Tab"),
  );
}

Container board(BuildContext context) {

  var md = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text("Board"),
  );
}