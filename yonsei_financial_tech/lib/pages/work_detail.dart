// import 'dart:html' as html;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
// import 'package:yonsei_financial_tech/components/components.dart';
// import 'package:yonsei_financial_tech/model/board.dart';

// // 2021/04/15 added
// class WorkDetail extends StatefulWidget {
//   final BoardItem data;
//   WorkDetail({@required this.data});

//   @override
//   _WorkDetailState createState() => _WorkDetailState();
// }

// class _WorkDetailState extends State<WorkDetail> {
//   ScrollController scrollController;
//   @override
//   void initState() {
//     super.initState();
//     scrollController = new ScrollController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: <Widget>[
//           SizedBox(
//               width: size.width,
//               child: SingleChildScrollView(
//                   controller: scrollController,
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: <Widget>[
//                         MenuBar(),
//                         WorkDetailArticle(data: widget.data),
//                         Footer(),
//                       ]))),
//         ],
//       ),
//     );
//   }
// }

// class WorkDetailArticle extends StatefulWidget {
//   final WorkItem data;
//   WorkDetailArticle({@required this.data});

//   @override
//   _WorkDetailArticleState createState() => _WorkDetailArticleState();
// }

// class _WorkDetailArticleState extends State<WorkDetailArticle> {
//   WorkItem data;

//   final String storageURL = "gs://ysfintech-homepage.appspot.com/work/";

//   @override
//   void initState() {
//     super.initState();
//     data = widget.data;
//   }

//   //String getOnlyTitle(String imagePath) {
//   //  String res;
//   // res = imagePath
//   //      .substring('gs://ysfintech-homepage.appspot.com/work/'.length);
//   //  return res;
//   //}

//   //Future<void> downloadFile(String imagePath) async {
//     // 1) set url
//   //  String downloadURL = await firebaseStorage.FirebaseStorage.instance
//   //      .ref(imagePath)
//   //      .getDownloadURL();
//     // 2) request
//   //  html.AnchorElement anchorElement =
//   //      new html.AnchorElement(href: downloadURL);
//   //  anchorElement.download = downloadURL;
//   //  anchorElement.click();
//   //}

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//         width: size.width,
//         color: Colors.white,
//         padding: marginHorizontal(size.width * 0.5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Align(
//               alignment: Alignment.center,
//               child: SizedBox(
//                 height: 100,
//               ),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   IconButton(
//                       icon: Icon(Icons.keyboard_arrow_left_rounded),
//                       iconSize: 24,
//                       onPressed: () => Navigator.pop(context)),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: Text(
//                         "뒤로가기",
//                         style: bodyTextStyle,
//                       ),
//                       style: ButtonStyle(
//                           overlayColor: MaterialStateColor.resolveWith(
//                               (states) => Colors.transparent))
//                   )
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: SizedBox(
//                 height: 100,
//               ),
//             ),
//             Align(
//                 // TITLE | DATE | VIEW_ WRITER
//                 alignment: Alignment.centerLeft,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     // TITLE
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(data.title, style: h1TextStyle),
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: SizedBox(
//                         height: 50,
//                       ),
//                     ),
//                     Align(
//                         alignment: Alignment.centerRight,
//                         child: Wrap(
//                           alignment: WrapAlignment.end,
//                           crossAxisAlignment: WrapCrossAlignment.center,
//                           spacing: 20.0,
//                           // DATE | VIEW
//                           children: <Widget>[
//                             Text('작성일자:  ' + data.date, style: bodyTextStyle),
//                             Text('조회수: ' + data.view.toString(),
//                                 style: bodyTextStyle),
//                             Text('작성자: ' + data.writer, style: bodyTextStyle)
//                           ],
//                         ))

//                     // DATE | VIEW |_WRITER
//                   ],
//                 )),
//             Align(
//               alignment: Alignment.center,
//               child: SizedBox(
//                 height: 100,
//                 child: divider,
//               ),
//             ),
//             // ARTICLE
//             Align(
//               alignment: Alignment.centerLeft,
//               // child: Article(
//               //   false, // no Image condition
//               //   content: "content",
//               //   backgroundColor: Colors.white,
//               // ),
//               //child: MarkdownContent(data: data.content)
//               child: Text(
//                 data.content, style: bodyTextStyle
//               )
//             ),
//             //data.imagePath != null
//             //    ? Column(
//             //        children: <Align>[
//             //          Align(
//             //            alignment: Alignment.center,
//             //            child: SizedBox(
//             //              height: 20,
//             //            ),
//             //          ),
//             //          Align(
//             //            // 첨부파일 다운받기
//             //            alignment: Alignment.centerRight,
//             //            child: TextButton(
//             //              onPressed: () => downloadFile(data.imagePath),
//             //              style: TextButton.styleFrom(
//             //                  shape: RoundedRectangleBorder(
//             //                      borderRadius: BorderRadius.circular(12)),
//             //                  padding: paddingH20V20,
//             //                  side: BorderSide(color: lightWhite)),
//             //              child: Wrap(
//             //                alignment: WrapAlignment.spaceBetween,
//             //                crossAxisAlignment: WrapCrossAlignment.center,
//             //                spacing: 12.0,
//             //                children: <Widget>[
//             //                  Icon(Icons.file_download),
//             //                  Text(getOnlyTitle(data.imagePath),
//             //                      style: bodyTextStyle)
//             //                ],
//             //              ),
//             //            ),
//             //          ),
//             //        ],
//             //      )
//             //    : SizedBox(),
//             Align(
//               alignment: Alignment.center,
//               child: SizedBox(
//                 height: 100,
//               ),
//             ),
//           ],
//         ));
//   }
// }

// class MarkdownContent extends StatefulWidget {
//   final String data;
//   MarkdownContent({@required this.data});
//   @override
//   _MarkdownContentState createState() => _MarkdownContentState();
// }

// class _MarkdownContentState extends State<MarkdownContent> {
//   ScrollController controller;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       controller = new ScrollController();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//         width: size.width,
//         color: Colors.white,
//         child: Column(
//           children: <Widget>[
//             Markdown(
//               controller: controller,
//               selectable: true,
//               shrinkWrap: true,
//               data: widget.data,
//               styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(textScaleFactor: 1.5),
//               styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
//             )
//           ],
//         ));
//   }
// }
