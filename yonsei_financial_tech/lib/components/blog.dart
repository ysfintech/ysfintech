import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
// extension
import 'package:yonsei_financial_tech/extensions/hover.dart';
// components
import 'package:yonsei_financial_tech/components/color.dart';
import 'package:yonsei_financial_tech/components/spacing.dart';
import 'package:yonsei_financial_tech/components/text.dart';
import 'package:yonsei_financial_tech/components/typography.dart';
import 'package:yonsei_financial_tech/model/board.dart';
import 'package:yonsei_financial_tech/pages/board_detail.dart';
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
        child: TextBody(text: "Copyright © 2021 Seunghwanly Kim-kwan-woo"),
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
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.home),
                              child: Text(
                                "Introduction",
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
  final Image image;
  final String imageDesc;
  final String period;
  final String from;
  final String content;
  final String title;
  final bool isImageRight;

  Article(this.isImageRight,
      {this.title,
      this.period,
      this.from,
      this.backgroundColor,
      this.image,
      @required this.content,
      this.imageDesc});

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context).size;
    if (image != null) {
      return Container(
          color: backgroundColor != null ? backgroundColor : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: md.width,
                height: 100,
              ),
              title != null
                  ? Container(
                      width: md.width,
                      height: md.width > 800
                          ? title.length > 40
                              ? (title.length - 40) * 4.0
                              : 40
                          : title.length * 3.0,
                      margin: marginHorizontal(md.width),
                      child: Text(title,
                          style: backgroundColor == Colors.white
                              ? h2TextStyle
                              : h2WhiteTextStyle,
                          softWrap: true),
                    )
                  : SizedBox(),
              period != null && from != null
                  ? Container(
                      width: md.width,
                      height: 80,
                      margin: marginHorizontal(md.width),
                      child: md.width > 1200
                          ? Row(
                              children: <Text>[
                                Text(period,
                                    style: backgroundColor == Colors.white
                                        ? h3TextStyle
                                        : h3WhiteTextStyle),
                                Text(
                                  ",  " + from,
                                  style: backgroundColor == Colors.white
                                      ? h3TextStyle
                                      : h3WhiteTextStyle,
                                  softWrap: true,
                                )
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Text>[
                                Text(period,
                                    style: backgroundColor == Colors.white
                                        ? h3TextStyle
                                        : h3WhiteTextStyle),
                                Text(
                                  ",  " + from,
                                  style: backgroundColor == Colors.white
                                      ? h3TextStyle
                                      : h3WhiteTextStyle,
                                  softWrap: true,
                                )
                              ],
                            ))
                  : SizedBox(),
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
                                    style: backgroundColor == Colors.white
                                        ? bodyTextStyle
                                        : bodyWhiteTextStyle,
                                  ),
                                ),
                                Expanded(child: SizedBox(), flex: 1),
                                Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: <Widget>[
                                        ClipRect(
                                            child: Container(
                                          child: image,
                                        )),
                                        SizedBox(height: 20),
                                        Text(imageDesc,
                                            style:
                                                backgroundColor == Colors.white
                                                    ? imageDescTextStyle
                                                    : imageDescTexWhitetStyle,
                                            softWrap: true)
                                      ],
                                    ))
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: <Widget>[
                                        ClipRect(
                                            child: Container(
                                          child: image,
                                        )),
                                        SizedBox(height: 20),
                                        Text(imageDesc,
                                            style:
                                                backgroundColor == Colors.white
                                                    ? imageDescTextStyle
                                                    : imageDescTexWhitetStyle,
                                            softWrap: true)
                                      ],
                                    )),
                                Expanded(child: SizedBox(), flex: 1),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    content,
                                    style: backgroundColor == Colors.white
                                        ? bodyTextStyle
                                        : bodyWhiteTextStyle,
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
                              style: backgroundColor == Colors.white
                                  ? bodyTextStyle
                                  : bodyWhiteTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Column(children: <Widget>[
                              Container(
                                width: md.width * 0.4,
                                height: md.width * 0.4,
                                child: image,
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: md.width * 0.4,
                                height: md.width * 0.4,
                                child: Text(
                                  imageDesc,
                                  style: backgroundColor == Colors.white
                                      ? imageDescTextStyle
                                      : imageDescTexWhitetStyle,
                                  softWrap: true,
                                ),
                              ),
                            ]))
                      ],
                    ),
              SizedBox(
                width: md.width,
                height: 100,
              ),
            ],
          ));
    }
    // image path is null : below
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
                title != null
                    ? Container(
                        width: md.width,
                        height:
                            title.length > 40 ? (title.length - 40) * 4.0 : 40,
                        margin: marginHorizontal(md.width),
                        child: Text(title,
                            style: backgroundColor != null
                                ? h2WhiteTextStyle
                                : h2TextStyle),
                      )
                    : SizedBox(),
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
    alignment: AlignmentDirectional.center,
    children: <Widget>[
      Container(
          // height: md.height * 0.58,
          height: 600,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/introBackground.jpeg'),
            fit: BoxFit.cover,
          ))),
      Positioned(
        // left: md.width > 700 ? 150 : 0,
        left: md.width > 800
            ? md.width / 2 - 520
            : md.width > 450
                ? 0
                : md.width / 2 - 400,
        child: Container(
            decoration: BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
  int selectedPageIndex = 1;
  /*
   *  Range to show in list = [ selectedPageIndex * 10, selectedPageIndex * 10 + 1, ... , selectedPageIndex * 10 + 9 ]
   *  10 items in row
   *  onPageChanged () => change range of index 
   *    [ selectedPageIndex * 10 + 0 to selectedPageIndex * 10 + 9 ]
   * 
   *  widget.board.length / 10 => page index max
   */
  // page index list
  List<List<int>> pageList = [];
  int pageListRow = 0;

  @override
  void initState() {
    super.initState();
    print(widget.board.length / 10);
    // set widget.board.length -> page index
    int maxPage =
        widget.board.length / 10 > 1 ? (widget.board.length / 10).ceil() : 1;

    List<int> temp = [];
    for (int i = 1; i <= maxPage; ++i) {
      if (i % 5 == 1 && i > 1) {
        pageList.add(temp);
        temp = [];
      }
      temp.add(i);
    }
    pageList.add(temp);
    print(pageList);
  }

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
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
            child: Text('Board', style: h1TextStyle),
          ),
          Align(
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
                        style: h3WhiteTextStyle,
                        textAlign: TextAlign.center,
                      )),
                  // title
                  Expanded(
                      flex: 3,
                      child: Text(
                        '제목',
                        style: h3WhiteTextStyle,
                        textAlign: TextAlign.center,
                      )),
                  // writer
                  Expanded(
                      flex: 1,
                      child: Text(
                        '작성자',
                        style: h3WhiteTextStyle,
                        textAlign: TextAlign.center,
                      )),
                  // date
                  Expanded(
                      flex: 1,
                      child: Text(
                        '날짜',
                        style: h3WhiteTextStyle,
                        textAlign: TextAlign.center,
                      )),
                  // view
                  Expanded(
                      flex: 1,
                      child: Text(
                        '조회수',
                        style: h3WhiteTextStyle,
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
          ),
          widget.board.length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    if ((selectedPageIndex - 1) * 10 + (index + 1) <=
                        widget.board.length) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // no
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        widget.board[
                                                (selectedPageIndex - 1) * 10 +
                                                    (index)]['id']
                                            .toString(),
                                        style: bodyTextStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                  // title -> only clickable
                                  Expanded(
                                      flex: 3,
                                      child: Hover(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BoardDetail(
                                                        data: BoardItem(
                                                            title: widget.board[(selectedPageIndex - 1) * 10 + (index)]
                                                                ['title'],
                                                            writer: widget.board[(selectedPageIndex - 1) * 10 + (index)]
                                                                ['writer'],
                                                            number: widget.board[
                                                                    (selectedPageIndex - 1) * 10 +
                                                                        (index)]
                                                                ['number'],
                                                            date: widget.board[(selectedPageIndex - 1) * 10 + (index)]
                                                                ['date'],
                                                            view: widget.board[(selectedPageIndex - 1) * 10 + (index)]
                                                                ['view'],
                                                            content:
                                                                widget.board[(selectedPageIndex - 1) * 10 + (index)]
                                                                    ['content']),
                                                      ))),
                                          child: Text(
                                            widget.board[
                                                    (selectedPageIndex - 1) *
                                                            10 +
                                                        (index)]['title']
                                                .toString(),
                                            style: bodyTextStyle,
                                            textAlign: TextAlign.center,
                                          ))),
                                  // writer
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        widget.board[
                                                (selectedPageIndex - 1) * 10 +
                                                    (index)]['writer']
                                            .toString(),
                                        style: bodyTextStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                  // date
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        widget.board[
                                                (selectedPageIndex - 1) * 10 +
                                                    (index)]['date']
                                            .toString(),
                                        style: bodyTextStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                  // view
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        widget.board[
                                                (selectedPageIndex - 1) * 10 +
                                                    (index)]['view']
                                            .toString(),
                                        style: bodyTextStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                ],
                              ),
                            ),
                            // divider
                            Container(
                              margin: marginHorizontal(md.width * 0.5),
                              child: divider,
                            )
                          ],
                        ),
                      );
                    }
                  },
                )
              : Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Text('정보가 없습니다.', style: h2TextStyle),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
          // page Index
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 400,
              padding: paddingH20V20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // left
                  TextButton(
                    child: Icon(
                      Icons.arrow_left_rounded,
                      size: 24,
                      color: ligthGray,
                    ),
                    onPressed: () {
                      if (pageListRow > 0) {
                        setState(() {
                          pageListRow -= 1;
                          print(pageListRow);
                          selectedPageIndex = pageList[pageListRow]
                              [pageList[pageListRow].length - 1];
                        });
                      }
                    },
                  ),
                  // page index
                  Container(
                      width: 200,
                      height: 50,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: new NeverScrollableScrollPhysics(),
                        itemCount: pageList[pageListRow].length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 40,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedPageIndex =
                                      pageList[pageListRow][index];
                                });
                              },
                              child: Text(
                                pageList[pageListRow][index].toString(),
                                style: TextStyle(
                                    color: pageList[pageListRow][index] ==
                                            selectedPageIndex
                                        ? themeBlue
                                        : ligthGray,
                                    fontWeight: pageList[pageListRow][index] ==
                                            selectedPageIndex
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ),
                          );
                        },
                      )),
                  // right
                  TextButton(
                    child: Icon(Icons.arrow_right_rounded,
                        size: 24, color: ligthGray),
                    onPressed: () {
                      if (pageListRow < pageList.length) {
                        setState(() {
                          pageListRow += 1;
                          selectedPageIndex = pageList[pageListRow][0];
                        });
                      }
                    },
                  )
                ],
              ),
            ),
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
