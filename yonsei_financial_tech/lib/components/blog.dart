import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Align(
        alignment: Alignment.center,
        child: TextBody(text: "Copyright © 2021–2022 연세대학교 금융기술센터"),
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
    final size = MediaQuery.of(context).size;
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
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.popUntil(context,
                          ModalRoute.withName(Navigator.defaultRouteName)),
                      child: Container(
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/yonsei_logo.svg",
                                width: 50, height: 50),
                            //Image.asset("assets/yonsei_logo.jpg",
                            //width: 50, height: 50),
                            SizedBox(
                              width: 10,
                            ),
                            size.width > 600
                                ? Text(
                                    "연세대학교 금융기술센터",
                                    style: GoogleFonts.notoSans(
                                        color: themeBlue,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "금융기술센터",
                                    style: GoogleFonts.notoSans(
                                        color: themeBlue,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      spacing: 20,
                      children: <Widget>[
                        TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, Routes.home),
                            child: Text(
                              "Home",
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
                        //TextButton(
                        //    onPressed: () =>
                        //        Navigator.pushNamed(context, Routes.publish),
                        //    child: Text(
                        //      "Publication",
                        //      style: buttonTextStyle,
                        //    ),
                        //    style: ButtonStyle(
                        //        overlayColor: MaterialStateColor.resolveWith(
                        //            (states) => Colors.transparent))),
                        TextButton(
                            onPressed: () async {
                              var dest =
                                  'https://orcid.org/0000-0003-3611-183X';
                              await canLaunch(dest)
                                  .then((value) => launch(dest))
                                  // ignore: return_of_invalid_type_from_catch_error
                                  .catchError(
                                      (err) => print('could not launch'));
                            },
                            child: Text(
                              "Publication",
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
                                Navigator.pushNamed(context, Routes.work),
                            child: Text(
                              "Collaboration",
                              style: buttonTextStyle,
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent))),
                        TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, Routes.seminar),
                            child: Text(
                              "Seminar",
                              style: buttonTextStyle,
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent))),
                        TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, Routes.conference),
                            child: Text(
                              "Conference",
                              style: buttonTextStyle,
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent))),
                        TextButton(
                            onPressed: () async {
                              var dest =
                                  'https://www.facebook.com/groups/ahn.yonsei/';
                              await canLaunch(dest)
                                  .then((value) => launch(dest))
                                  // ignore: return_of_invalid_type_from_catch_error
                                  .catchError(
                                      (err) => print('could not launch'));
                            },
                            child: Text(
                              "Facebook",
                              style: buttonTextStyle,
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent))),
                        TextButton(
                            onPressed: () async {
                              var dest = 'http://ahn.yonsei.ac.kr/';
                              await canLaunch(dest)
                                  .then((value) => launch(dest))
                                  // ignore: return_of_invalid_type_from_catch_error
                                  .catchError(
                                      (err) => print('could not launch'));
                            },
                            child: Text(
                              "Lab",
                              style: buttonTextStyle,
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent))),
                      ],
                    ),
                  ))
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
  final Color? backgroundColor;
  final Image? image;
  final String? imageDesc;
  final String? period;
  final String? from;
  final String content;
  final String? title;

  Article({
    this.title,
    this.period,
    this.from,
    this.backgroundColor,
    this.image,
    required this.content,
    this.imageDesc,
  });

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
                          ? title!.length > 40
                              ? (title!.length - 40) * 4.0
                              : 40
                          : title!.length * 3.0,
                      margin: marginHorizontal(md.width),
                      child: Text(title!,
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
                      child: Text(period! + ', ' + from!,
                          style: backgroundColor == Colors.white
                              ? h3TextStyle
                              : h3WhiteTextStyle))
                  : SizedBox(),
              // image and image description to center
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
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
                        ClipRect(
                            child: Container(
                          child: image,
                        )),
                        SizedBox(height: 20),
                        Container(
                          width: md.width,
                          height: md.width * 0.15,
                          margin: marginHorizontal(md.width),
                          child: Text(
                            imageDesc ?? '',
                            style: backgroundColor == Colors.white
                                ? bodyTextStyle
                                : bodyWhiteTextStyle,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]))
                ],
              )
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
                        height: title!.length > 40
                            ? (title!.length - 40) * 4.0
                            : 40,
                        margin: marginHorizontal(md.width),
                        child: Text(title!,
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

// ArticleB
class ArticleB extends StatelessWidget {
  final Color? backgroundColor;
  final Image? image;
  final String? name;
  final String? role;
  final String content;
  final String? title;

  ArticleB(
      {this.title,
      this.name,
      this.role,
      this.backgroundColor,
      this.image,
      required this.content});

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

              // image and image description to center
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
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
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Column(children: <Widget>[
                        ClipRect(
                            child: Container(
                          child: image,
                        )),
                        SizedBox(height: 20),
                        Container(
                            width: md.width,
                            height: md.width * 0.15,
                            margin: marginHorizontal(md.width),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Text>[
                                Text(
                                  name ?? '',
                                  style: backgroundColor == Colors.white
                                      ? bodyTextStyle
                                      : bodyWhiteTextStyle,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  role ?? '',
                                  style: backgroundColor == Colors.white
                                      ? bodyTextStyle
                                      : bodyWhiteTextStyle,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ))
                      ]))
                ],
              )
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
  return Stack(
    alignment: Alignment.centerLeft,
    children: <Widget>[
      Container(
          // height: md.height * 0.5,
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('introBackground.jpeg'),
            fit: BoxFit.cover,
          ))),
      Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              backgroundBlendMode: BlendMode.darken),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
              horizontal: md.width > 540 ? 100 : 0, vertical: 20),
          width: md.width,
          height: 300,
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Welcome to',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: lightWhite)),
              TextSpan(
                  text: '\nYonsei FinTech Center',
                  style: titleIntroductionTextStyle),
            ]),
          )),
    ],
  );
}

class BoardArticle extends StatefulWidget {
  final List<Map<String, dynamic>> board;
  final String storage;
  final VoidCallback onRefresh;

  BoardArticle({
    required this.board,
    required this.storage,
    required this.onRefresh,
  });

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
 *    DateTime date
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

  // firebase
  late final CollectionReference papers;

  Future<void> updateView(String docID, int updatedView) {
    return papers
        .doc(docID)
        .update({'view': updatedView})
        .then((value) => print('view updated'))
        .catchError((onError) => print('view update failed : $onError'));
  }

  @override
  void initState() {
    super.initState();

    /// init [FirebaseFirestore]
    /// [widget] can be only initialized in `initState`
    papers = FirebaseFirestore.instance.collection(widget.storage);
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
    // print(pageList);
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
          Align(
            alignment: Alignment.center,
            child: Container(
              color: themeBlue,
              margin: marginHorizontal(md.width),
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
                        style: bodyWhiteTextStyle,
                        textAlign: TextAlign.center,
                      )),
                  // title
                  Expanded(
                      flex: 3,
                      child: Text(
                        '제목',
                        style: bodyWhiteTextStyle,
                        textAlign: TextAlign.center,
                      )),
                  // writer
                  Expanded(
                      flex: 1,
                      child: Text(
                        '작성자',
                        style: bodyWhiteTextStyle,
                        textAlign: TextAlign.center,
                      )),
                  // date
                  Expanded(
                      flex: 1,
                      child: Text(
                        '날짜',
                        style: bodyWhiteTextStyle,
                        textAlign: TextAlign.center,
                      )),
                  // view
                  Expanded(
                      flex: 1,
                      child: Text(
                        '조회수',
                        style: bodyWhiteTextStyle,
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
          ),
          widget.board.length != 0
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  // ignore: missing_return
                  itemBuilder: (BuildContext context, int index) {
                    if ((selectedPageIndex - 1) * 10 + (index + 1) <=
                        widget.board.length) {
                      /// set index to below
                      /// every item follows below [listIndex]
                      int listIndex = (selectedPageIndex - 1) * 10 + index;
                      // posts
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            // post
                            Container(
                              margin: marginHorizontal(md.width),
                              padding: paddingH20V20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  /// Expanded Widget for [Number]
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        widget.board[listIndex]['id']
                                            .toString(),
                                        style: bodyTextStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                  // title -> only clickable
                                  Expanded(
                                      flex: 3,
                                      child: Hover(
                                          onTap: () {
                                            // page route
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BoardDetail(
                                                  storage: widget.storage,
                                                  data: BoardItem(
                                                    title:
                                                        widget.board[listIndex]
                                                            ['title'],
                                                    writer:
                                                        widget.board[listIndex]
                                                            ['writer'],
                                                    number: widget
                                                        .board[listIndex]['id'],
                                                    date:
                                                        (widget.board[listIndex]
                                                                    ['date']
                                                                as Timestamp)
                                                            .toDate(),
                                                    view:
                                                        widget.board[listIndex]
                                                            ['view'],
                                                    content:
                                                        widget.board[listIndex]
                                                            ['content'],
                                                    imagePath:
                                                        widget.board[listIndex]
                                                            ['imagePath'],
                                                  ),
                                                ),
                                              ),
                                            ).then(
                                              (value) =>
                                                  this.widget.onRefresh(),
                                            );

                                            // increase view
                                            updateView(
                                              widget.board[
                                                  (selectedPageIndex - 1) * 10 +
                                                      (index)]['docID'],
                                              widget.board[
                                                      (selectedPageIndex - 1) *
                                                              10 +
                                                          (index)]['view'] +
                                                  1,
                                            );
                                          },
                                          child: Text(
                                            widget.board[listIndex]['title']
                                                .toString(),
                                            style: bodyTextStyle,
                                            textAlign: TextAlign.left,
                                          ))),
                                  // writer
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        widget.board[listIndex]['writer']
                                            .toString(),
                                        style: bodyTextStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                  // date
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        (widget.board[listIndex]['date']
                                                as Timestamp)
                                            .toDate()
                                            .toIso8601String()
                                            .substring(0, 10),
                                        style: bodyTextStyle,
                                        textAlign: TextAlign.center,
                                      )),
                                  // view
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        widget.board[listIndex]['view']
                                            .toString(),
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
                    }
                    return SizedBox();
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
