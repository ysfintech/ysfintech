import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:yonsei_financial_tech/components/components.dart';
import 'package:yonsei_financial_tech/model/board.dart';

// 2021/04/15 added
class BoardDetail extends StatefulWidget {
  final BoardItem data;
  BoardDetail({@required this.data});

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
                        BoardDetailArticle(data: widget.data),
                        Footer(),
                      ]))),
        ],
      ),
    );
  }
}

class BoardDetailArticle extends StatelessWidget {
  final BoardItem data;
  BoardDetailArticle({@required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        color: Colors.white,
        padding: marginHorizontal(size.width * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 100,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.keyboard_arrow_left_rounded),
                      iconSize: 30,
                      onPressed: () => Navigator.pop(context)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "뒤로가기",
                    style: bodyTextStyle,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 100,
              ),
            ),
            Align(
              // TITLE | DATE | VIEW_ WRITER
              alignment: Alignment.center,
              child: size.width > 800
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // TITLE
                        Text(data.title, style: h1TextStyle),
                        // DATE | VIEW |_WRITER
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              // DATE | VIEW
                              children: <Widget>[
                                Text('작성일자  ' + data.date,
                                    style: bodyTextStyle),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('조회수 ' + data.view.toString(),
                                    style: bodyTextStyle),
                              ],
                            ),
                            Text('작성자 ' + data.writer, style: bodyTextStyle)
                          ],
                        )
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // TITLE
                        Text(data.title, style: h1TextStyle),
                        SizedBox(height: 50,),
                        // DATE | VIEW |_WRITER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // DATE | VIEW
                          children: <Widget>[
                            Text('작성일자  ' + data.date, style: bodyTextStyle),
                            SizedBox(
                              width: 10,
                            ),
                            Text('작성자 ' + data.writer, style: bodyTextStyle),
                            SizedBox(
                              width: 10,
                            ),
                            Text('조회수 ' + data.view.toString(),
                                style: bodyTextStyle),
                          ],
                        ),
                      ],
                    ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 100,
              ),
            ),
            // ARTICLE
            Align(
              alignment: Alignment.center,
              // child: Article(
              //   false, // no Image condition
              //   content: "content",
              //   backgroundColor: Colors.white,
              // ),
              child: MarkdownContent(data: data.content),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 100,
              ),
            ),
          ],
        ));
  }
}

class MarkdownContent extends StatefulWidget {
  final String data;
  MarkdownContent({@required this.data});
  @override
  _MarkdownContentState createState() => _MarkdownContentState();
}

class _MarkdownContentState extends State<MarkdownContent> {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = new ScrollController();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Markdown(
              controller: controller,
              selectable: true,
              shrinkWrap: true,
              data: widget.data,
              styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
            )
          ],
        ));
  }
}
