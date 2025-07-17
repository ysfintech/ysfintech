import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:yonsei_financial_tech/components/components.dart';
import 'package:yonsei_financial_tech/model/board.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

// 2021/04/15 added
class BoardDetail extends StatefulWidget {
  final String storage;
  final BoardItem data;
  BoardDetail({
    required this.data,
    required this.storage,
  });

  @override
  _BoardDetailState createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  late final ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                        MenuBarY(),
                        BoardDetailArticle(
                          data: widget.data,
                          storage: widget.storage,
                        ),
                        Footer(),
                      ]))),
        ],
      ),
    );
  }
}

class BoardDetailArticle extends StatefulWidget {
  final BoardItem data;
  final String storage;
  BoardDetailArticle({
    required this.data,
    required this.storage,
  });

  @override
  _BoardDetailArticleState createState() => _BoardDetailArticleState();
}

class _BoardDetailArticleState extends State<BoardDetailArticle> {
  late final BoardItem data;

  late final String storageURL;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    storageURL = "gs://ysfintech-homepage.appspot.com/${widget.storage}/";
  }

  String getOnlyTitle(String imagePath) {
    String res;
    res = imagePath.substring(storageURL.length);
    return res;
  }

  Future<void> downloadFile(String imagePath) async {
    // 1) set url
    String downloadURL = await firebaseStorage.FirebaseStorage.instance
        .ref(imagePath)
        .getDownloadURL();
    // 2) request
    html.AnchorElement anchorElement =
        new html.AnchorElement(href: downloadURL);
    anchorElement.download = downloadURL;
    anchorElement.click();
  }

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.keyboard_arrow_left_rounded),
                      iconSize: 24,
                      onPressed: () => Navigator.pop(context)),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "뒤로가기",
                        style: bodyTextStyle,
                      ),
                      style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent)))
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
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // TITLE
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(data.title, style: h1TextStyle),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 50,
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 20.0,
                          // DATE | VIEW
                          children: <Widget>[
                            Text(
                                '작성일자:  ' +
                                    data.date
                                        .toIso8601String()
                                        .substring(0, 10),
                                style: bodyTextStyle),
                            Text('조회수: ' + data.view.toString(),
                                style: bodyTextStyle),
                            Text('작성자: ' + data.writer, style: bodyTextStyle)
                          ],
                        ))

                    // DATE | VIEW |_WRITER
                  ],
                )),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 100,
                child: divider,
              ),
            ),
            // ARTICLE
            Align(
              alignment: Alignment.center,
              child: Html(
                      data: data.content,
                      onLinkTap: (String? url, Map<String, String> attributes, dom.Element? element) async {
                        print("🔗 링크 클릭됨: $url");  // ← 여기가 안 뜨면 클릭 자체가 안 된 것
                        if (url != null) {
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.platformDefault); // 웹 지원
                          } else {
                            print("🚫 열 수 없음: $url");
                          }
                        }
                      },
                      style: {
                        "a": Style(
                          color: Colors.blue,
                          textDecoration: TextDecoration.underline,
                        ),
                      },
                    ),
            ),
            if (data.imagePath != null)
              Column(
                children: <Align>[
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  Align(
                    // 첨부파일 다운받기
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        if (data.imagePath != null) {
                          downloadFile(data.imagePath!);
                        }
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: paddingH20V20,
                          side: BorderSide(color: lightWhite)),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12.0,
                        children: <Widget>[
                          Icon(Icons.file_download),
                          Text(getOnlyTitle(data.imagePath!),
                              style: bodyTextStyle)
                        ],
                      ),
                    ),
                  ),
                ],
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
  MarkdownContent({
    required this.data,
  });
  @override
  _MarkdownContentState createState() => _MarkdownContentState();
}

class _MarkdownContentState extends State<MarkdownContent> {
  late final ScrollController controller;

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
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                  .copyWith(textScaleFactor: 1.5),
              styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
            )
          ],
        ));
  }
}
