import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yonsei_financial_tech/components/color.dart';
import 'package:yonsei_financial_tech/components/spacing.dart';
import 'package:yonsei_financial_tech/components/text.dart';
import 'package:yonsei_financial_tech/components/typography.dart';
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
                              onPressed: () => Navigator.popUntil(
                                  context,
                                  ModalRoute.withName(
                                      Navigator.defaultRouteName)),
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
              child: Text('Introduction', style: headlineTextStyle),
            ),
            md.width > 1600
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
                    :
                    Row(
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
                    )
                    )
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
                          width: md.width * 0.5,
                          height: md.width * 0.5,
                          child: Image(
                              image: AssetImage(imagePath), fit: BoxFit.cover),
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

    // return Container(
    //   width: double.infinity,
    //   height: 800,
    //   padding: EdgeInsets.symmetric(
    //       horizontal: md.width > 700 ? md.width * 0.3 : md.width * 0.1,
    //       vertical: md.height > 600 ? 100 : md.height * 0.146),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       Text(
    //         title,
    //         style: articleTitleTextStyle(color: Colors.black),
    //       ),
    //       isImageRight
    //           ? Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 // article left
    //                 Expanded(
    //                     flex: 4,
    //                     child: Text(
    //                       content,
    //                       style: articleContentTextStyle(),
    //                     )),
    //                 Expanded(
    //                   flex: 1,
    //                   child: SizedBox(),
    //                 ),
    //                 // image right
    //                 Expanded(
    //                   flex: 4,
    //                   child: imageDesc != null
    //                       ? Column(
    //                           children: [
    //                             ClipRect(
    //                               child: Container(
    //                                 width: 500,
    //                                 height: 500,
    //                                 child: Image.asset(imagePath),
    //                               ),
    //                             ),
    //                             Text(
    //                               imageDesc,
    //                               style: imageDescTextStyle,
    //                             ),
    //                           ],
    //                         )
    //                       : ClipRect(
    //                           child: Container(
    //                             width: 500,
    //                             height: 500,
    //                             child: Image(
    //                                 image: AssetImage(imagePath),
    //                                 fit: BoxFit.cover),
    //                           ),
    //                         ),
    //                 )
    //               ],
    //             )
    //           : Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 // image right
    //                 Expanded(
    //                   flex: 4,
    //                   child: imageDesc != null
    //                       ? Column(
    //                           children: [
    //                             ClipRect(
    //                               child: Container(
    //                                 width: 500,
    //                                 height: 500,
    //                                 child: Image.asset(imagePath),
    //                               ),
    //                             ),
    //                             Text(
    //                               imageDesc,
    //                               style: imageDescTextStyle,
    //                             ),
    //                           ],
    //                         )
    //                       : ClipRect(
    //                           child: Container(
    //                             width: 500,
    //                             height: 500,
    //                             child: Image.asset(imagePath),
    //                           ),
    //                         ),
    //                 ),
    //                 Expanded(
    //                   flex: 1,
    //                   child: SizedBox(),
    //                 ),
    //                 // article right
    //                 Expanded(
    //                     flex: 4,
    //                     child: Text(
    //                       content,
    //                       style: articleContentTextStyle(),
    //                     )),
    //               ],
    //             )
    //     ],
    //   ),
    // );
  }
}
