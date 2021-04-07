import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// extension
import 'package:yonsei_financial_tech/extensions/hover.dart';
// components
import 'package:yonsei_financial_tech/components/color.dart';
import 'package:yonsei_financial_tech/components/spacing.dart';
import 'package:yonsei_financial_tech/components/text.dart';
import 'package:yonsei_financial_tech/components/typography.dart';
// route
import 'package:yonsei_financial_tech/routes.dart';

const Widget divider = Divider(color: Color(0xFFEEEEEE), thickness: 1);

class Footer extends StatelessWidget {
  // TODO Add additional footer components (i.e. about, links, logos).
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Align(
        alignment: Alignment.center,
        child: TextBody(text: "Copyright © 2020 Seunghwanly Kim-kwan-woo"),
      ),
    );
  }
}

// ignore: slash_for_doc_comments
/**
 * Menu/Navigation Bar
 *
 * A top menu bar with a text or image logo and
 * navigation links. Navigation links collapse into
 * a hamburger menu on screens smaller than 400px.
 */
class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              // color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName)),
                    child: Image(
                      image: AssetImage('images/yonsei.jpg'),
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        spacing: 30,
                        children: <Widget>[
                          TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.home),
                              child: Text(
                                "Introduction",
                                style: buttonTextStyle,
                              ),
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent))),
                          TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.education),
                              child: Text(
                                "Education",
                                style: buttonTextStyle,
                              ),
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent))),
                          TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.people),
                              child: Text(
                                "People",
                                style: buttonTextStyle,
                              ),
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent))),
                          TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.project),
                              child: Text(
                                "Project",
                                style: buttonTextStyle,
                              ),
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent))),
                          TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.paper),
                              child: Text(
                                "Working Paper",
                                style: buttonTextStyle,
                              ),
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent))),
                          TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.publish),
                              child: Text(
                                "Publication",
                                style: buttonTextStyle,
                              ),
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent)))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                // under line bar
                height: 1,
                // margin: EdgeInsets.only(bottom: 30),
                color: Color(0xFFEEEEEE)),
          ],
        ));
  }
}

// Article
class Article extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String imageDesc;
  final String content;
  final String title;
  final bool isImageRight;

  Article(this.isImageRight,
      {this.title,
      this.backgroundColor,
      this.imagePath,
      this.content,
      this.imageDesc});

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context).size;
    if (imagePath != null) {
      return Container(
          color: backgroundColor != null ? backgroundColor : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: md.width,
                height: 100,
              ),
              Container(
                width: md.width,
                height: 80,
                margin: marginHorizontal(md.width),
                child: Text(title, style: headlineTextStyle),
              ),
              md.width > 1200
                  ? Container(
                      margin: marginHorizontal(md.width),
                      child: isImageRight
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    content,
                                    style: bodyTextStyle,
                                  ),
                                ),
                                Expanded(child: SizedBox(), flex: 1),
                                Expanded(
                                    flex: 4,
                                    child: ClipRect(
                                        child: Container(
                                      child: Image(
                                          image: AssetImage(imagePath),
                                          fit: BoxFit.cover),
                                    )))
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: ClipRect(
                                        child: Container(
                                      child: Image(
                                          image: AssetImage(imagePath),
                                          fit: BoxFit.cover),
                                    ))),
                                Expanded(child: SizedBox(), flex: 1),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    content,
                                    style: bodyTextStyle,
                                  ),
                                ),
                              ],
                            ))
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: marginHorizontal(md.width),
                            child: Text(
                              content,
                              style: bodyTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: md.width * 0.4,
                            height: md.width * 0.4,
                            child: Image(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover),
                          ),
                        )
                      ],
                    ),
              SizedBox(
                width: md.width,
                height: 100,
              ),
            ],
          ));
    }
    // image path is not null
    else {
      return Container(
          color: backgroundColor != null ? backgroundColor : Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: md.width,
                  height: 100,
                ),
                Container(
                  width: md.width,
                  height: 80,
                  margin: marginHorizontal(md.width),
                  child: Text(title,
                      style: backgroundColor != null
                          ? headlineWhiteTextStyle
                          : headlineTextStyle),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: marginHorizontal(md.width),
                    child: Text(
                      content,
                      style: backgroundColor != null
                          ? bodyWhiteTextStyle
                          : bodyTextStyle,
                    ),
                  ),
                ),
                SizedBox(
                  width: md.width,
                  height: 100,
                ),
              ]));
    }
  }
}

Stack title(BuildContext context) {
  var md = MediaQuery.of(context).size;
  // margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
  return Stack(
    alignment: AlignmentDirectional.centerStart,
    children: <Widget>[
      Container(
          // height: md.height * 0.58,
          height: 400,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/introBackground.jpeg'),
            fit: BoxFit.cover,
          ))),
      Positioned(
        left: md.width > 700 ? 150 : 0,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: themeBlue,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset.fromDirection(3.0),
                      blurRadius: 10.0,
                      spreadRadius: 3.0)
                ]),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: md.width > 540 ? 25 : 0, vertical: 60),
            width: md.width > 450 ? 520 : 400,
            height: md.height > 400 ? 300 : 240,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '연세대학교 금융기술센터', style: titleIntroductionTextStyle),
                TextSpan(
                    text: '\n에 오신 것을 환영합니다',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: lightWhite)),
              ]),
            )),
      ),
    ],
  );
}

class BoardArticle extends StatefulWidget {
  final List<Map<String, dynamic>> board;

  BoardArticle({this.board});

  @override
  _BoardArticleState createState() => _BoardArticleState();
}

class _BoardArticleState extends State<BoardArticle> {
/*
 *  Board -> List<BoardItem> list;
 *  BoardItem {
 *    int number
 *    String title
 *    String writer
 *    String date
 *    int views
 *    String contentPath
 *  }
 */

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            // head space
            width: md.width,
            height: 100,
          ),
          // Board ------------------------------------------------
          Container(
            width: md.width,
            height: 80,
            margin: marginHorizontal(md.width * 0.5),
            child: Text('Board', style: headlineTextStyle),
          ),

          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.board.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: themeBlue,
                    margin: marginHorizontal(md.width * 0.5),
                    padding: paddingH20V20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // no
                        Expanded(
                            flex: 1,
                            child: Text(
                              '번호',
                              style: subtitleWhiteTextStyle,
                              textAlign: TextAlign.center,
                            )),
                        // title
                        Expanded(
                            flex: 3,
                            child: Text(
                              '제목',
                              style: subtitleWhiteTextStyle,
                              textAlign: TextAlign.center,
                            )),
                        // writer
                        Expanded(
                            flex: 1,
                            child: Text(
                              '작성자',
                              style: subtitleWhiteTextStyle,
                              textAlign: TextAlign.center,
                            )),
                        // date
                        Expanded(
                            flex: 1,
                            child: Text(
                              '날짜',
                              style: subtitleWhiteTextStyle,
                              textAlign: TextAlign.center,
                            )),
                        // view
                        Expanded(
                            flex: 1,
                            child: Text(
                              '조회수',
                              style: subtitleWhiteTextStyle,
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  ),
                );
              }
              // posts
              return Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    // post
                    Container(
                      margin: marginHorizontal(md.width * 0.5),
                      padding: paddingH20V20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // no
                          Expanded(
                              flex: 1,
                              child: Text(
                                widget.board[index - 1]['number'].toString(),
                                style: bodyTextStyle,
                                textAlign: TextAlign.center,
                              )),
                          // title -> only clickable
                          Expanded(
                              flex: 3,
                              child: Hover(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (_) =>
                                          AlertDialog(title: Text("OK!"))),
                                  child: Text(
                                    widget.board[index - 1]['title'].toString(),
                                    style: bodyTextStyle,
                                    textAlign: TextAlign.center,
                                  ))),
                          // writer
                          Expanded(
                              flex: 1,
                              child: Text(
                                widget.board[index - 1]['writer'].toString(),
                                style: bodyTextStyle,
                                textAlign: TextAlign.center,
                              )),
                          // date
                          Expanded(
                              flex: 1,
                              child: Text(
                                widget.board[index - 1]['date'].toString(),
                                style: bodyTextStyle,
                                textAlign: TextAlign.center,
                              )),
                          // view
                          Expanded(
                              flex: 1,
                              child: Text(
                                widget.board[index - 1]['view'].toString(),
                                style: bodyTextStyle,
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    ),
                    // divider
                    Container(
                      margin: marginHorizontal(md.width),
                      child: divider,
                    )
                  ],
                ),
              );
            },
          ),
          SizedBox(
            // footer space
            width: md.width,
            height: 100,
          ),
        ],
      ),
    );
  }
}
