import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/util/textify.dart';
// pages
import '../body/home/home.dart' as home;

class Header extends StatefulWidget {
  Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  int pageIndex = 0;

  Widget gotoPage(int idx) {
    switch (idx) {
      case 0:
        return home.Home();
        break;
      default:
        return home.Home();
    }
  }

  Widget topBar(BuildContext c) {
    return Container(
      width: MediaQuery.of(c).size.width,
      height: MediaQuery.of(c).size.height * 0.1,
      padding: EdgeInsets.only(
          left: MediaQuery.of(c).size.width * 0.014,
          right: MediaQuery.of(c).size.width * 0.028),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // image
          Expanded(
            flex: 1,
            child: Image(
              image: AssetImage('images/yonsei.jpg'),
            ),
          ),
          // space
          Expanded(
            flex: 4,
            child: SizedBox(),
          ),
          // group of tabs
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // tab : intro
                TextButton(
                    onPressed: () => AlertDialog(
                          title: Text('Introduction'),
                        ),
                    child: Container(
                        width: MediaQuery.of(c).size.width * 0.083,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: makeSmallTitle('Introduction', c),
                            ),
                            Expanded(
                              flex: 2,
                              child: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black
                                  // size: MediaQuery.of(c).size.width * 0.017,
                                  ),
                            )
                          ],
                        ))),
                // tab : People
                TextButton(
                    onPressed: () => AlertDialog(
                          title: Text('People'),
                        ),
                    child: Container(
                        width: MediaQuery.of(c).size.width * 0.083,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: makeSmallTitle('People', c),
                            ),
                            Expanded(
                              flex: 2,
                              child: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black
                                  // size: MediaQuery.of(c).size.width * 0.017,
                                  ),
                            )
                          ],
                        ))),
                // tab : Content
                TextButton(
                    onPressed: () => AlertDialog(
                          title: Text('Content'),
                        ),
                    child: Container(
                        width: MediaQuery.of(c).size.width * 0.083,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: makeSmallTitle('Content', c),
                            ),
                            Expanded(
                              flex: 2,
                              child: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black
                                  // size: MediaQuery.of(c).size.width * 0.017,
                                  ),
                            )
                          ],
                        ))),
                // tab : Working paper
                TextButton(
                    onPressed: () => AlertDialog(
                          title: Text('Working paper'),
                        ),
                    child: Container(
                        width: MediaQuery.of(c).size.width * 0.083,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: makeSmallTitle('Working Paper', c),
                            ),
                            Expanded(
                              flex: 2,
                              child: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black
                                  // size: MediaQuery.of(c).size.width * 0.017,
                                  ),
                            )
                          ],
                        ))),
                // tab : publishment
                TextButton(
                    onPressed: () => AlertDialog(
                          title: Text('Publishment'),
                        ),
                    child: Container(
                        width: MediaQuery.of(c).size.width * 0.083,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: makeSmallTitle('Publishment', c),
                            ),
                            Expanded(
                              flex: 2,
                              child: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black
                                  // size: MediaQuery.of(c).size.width * 0.017,
                                  ),
                            )
                          ],
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: topBar(context),
        elevation: 0.0,
      ),
      body: Center(
        child: gotoPage(pageIndex),
      ),
    );
  }
}
