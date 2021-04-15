import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/components.dart';

// 2021/04/15 added
class BoardDetail extends StatefulWidget {
  @override
  _BoardDetailState createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
              width: size.width,
              child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        MenuBar(),
                        BoardDetailArticle(),
                        Footer(),
                      ]))),
        ],
      ),
    );
  }
}

class BoardDetailArticle extends StatelessWidget {
  const BoardDetailArticle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        padding: marginHorizontal(size.width * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.keyboard_arrow_left_rounded),
                      iconSize: 30,
                      onPressed: () => Navigator.pop(context)),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "뒤로가기",
                    style: bodyTextStyle,
                  )
                ],
              ),
            ),
            Align(
              // TITLE | DATE | VIEW_ WRITER
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // TITLE
                  Text('title', style: h1TextStyle),
                  // DATE | VIEW |_WRITER
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        // DATE | VIEW
                        children: <Widget>[
                          Text('date', style: bodyTextStyle),
                          Text('view', style: bodyTextStyle),
                        ],
                      ),
                      Text('writer', style: bodyTextStyle)
                    ],
                  )
                ],
              ),
            ),
            // ARTICLE
            Align(
              alignment: Alignment.center,
              child: Article(
                false, // no Image condition
                content: "content",
              ),
            )
          ],
        ));
  }
}
