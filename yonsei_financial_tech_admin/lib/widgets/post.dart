import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

Future<void> updateDocument(Board data, BuildContext context) {
  return FirebaseFirestore.instance
      .collection('paper')
      .add(
        {
          'content': data.content,
          'date':data.date,
          'id':data.id,
          'title':data.title,
          'view':data.view,
          'writer':data.writer
        }
      )
      .then((value) => print("project updated"))
      .then((value) => Navigator.pop(context, true));
}

class Post extends StatefulWidget {
  final int id;
  Post({@required this.id});
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  TextEditingController title;
  TextEditingController content;

  ScrollController controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    title = new TextEditingController();
    content = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
        color: Colors.black.withOpacity(0.5),
        child: Container(
            margin: marginH40V40,
            padding: paddingH20V20,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                // buttons
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: Colors.black),
                        label: SizedBox(),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                        child: Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.post_add_rounded),
                                SizedBox(width: 10),
                                Text('POST', style: bodyWhiteTextStyle)
                              ],
                            )),
                        onPressed: () {
                          Board data = new Board(
                            title: title.text,
                            writer: '@auth',
                            date: DateTime.now().year.toString().substring(2,4) + '.' + (DateTime.now().month.toString().length == 1 ? '0'+DateTime.now().month.toString() : DateTime.now().month.toString()) +'.'+ (DateTime.now().day.toString().length == 1 ? '0'+DateTime.now().day.toString() : DateTime.now().day.toString()) ,
                            id: widget.id,
                            view: 0,
                            content: '''
                            ${content.text}
                            '''
                          );
                          setState(() {
                            updateDocument(data, context)
                            .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                              '새로운 게시글이 등록되었습니다.'))));
                          });
                        },
                      )
                    ]),
                // show title
                Expanded(
                  // title and writer
                  flex: 1,
                  child: size.width > 800
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                flex: 7,
                                child: TextFormField(
                                  maxLines: 2,
                                  controller: title,
                                  autofocus: true,
                                  enabled: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          gapPadding: 16.0,
                                          borderSide:
                                              BorderSide(color: ligthGray)),
                                      filled: true,
                                      fillColor: lightWhite,
                                      icon: Icon(Icons.title_rounded)),
                                )),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  'written by ' + '@auth',
                                  style: bodyTextStyle,
                                  textAlign: TextAlign.end,
                                )),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            Expanded(
                                flex: 7,
                                child: TextFormField(
                                  maxLines: 2,
                                  controller: title,
                                  autofocus: true,
                                  enabled: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          gapPadding: 16.0,
                                          borderSide:
                                              BorderSide(color: ligthGray)),
                                      filled: true,
                                      fillColor: lightWhite,
                                      icon: Icon(Icons.title_rounded)),
                                )),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  'written by ' + '@auth',
                                  style: bodyTextStyle,
                                  textAlign: TextAlign.end,
                                )),
                          ],
                        ),
                ),
                SizedBox(height: 10),
                Expanded(
                    // content
                    flex: 8,
                    child: TextFormField(
                      maxLines: null,
                      controller: content,
                      autofocus: true,
                      enabled: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              gapPadding: 16.0,
                              borderSide: BorderSide(color: ligthGray)),
                          filled: true,
                          fillColor: lightWhite,
                          icon: Icon(Icons.article_rounded)),
                    )),
                SizedBox(height: 20),
              ],
            )));
  }
}
