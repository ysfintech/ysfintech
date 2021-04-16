import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

Future<void> updateDocument(String pathID, String content, String title, BuildContext context) {
  return FirebaseFirestore.instance
      .collection('paper')
      .doc(pathID)
      .update({'content': content, 'title': title}).then(
          (value) => print("project updated")).then((value) => Navigator.pop(context, true));
}

class BoardDetail extends StatefulWidget {
  final String pathID;
  final Board data;
  BoardDetail({this.data, this.pathID});
  @override
  _BoardDetailState createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  TextEditingController title;
  TextEditingController content;

  ScrollController controller = new ScrollController();

  bool _editable = false;

  @override
  void initState() {
    super.initState();
    title = new TextEditingController(text: widget.data.title);
    content = new TextEditingController(text: widget.data.content);
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
                        style: ElevatedButton.styleFrom(
                            primary: !_editable ? themeBlue : Colors.orange),
                        child: Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(_editable
                                    ? Icons.save_alt_rounded
                                    : Icons.edit_rounded),
                                SizedBox(width: 10),
                                Text(_editable ? 'SAVE' : 'EDIT',
                                    style: bodyWhiteTextStyle)
                              ],
                            )),
                        onPressed: () {
                          setState(() {
                            if (_editable) {
                              updateDocument(
                                      widget.pathID, content.text, title.text, context)
                                  .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                              '${widget.data.title}의 내용이 수정되었습니다.'))));
                            }
                            // save to firebase
                            _editable = !_editable;
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
                            !_editable
                                ? Expanded(
                                    flex: 7,
                                    child: Text(widget.data.title,
                                        style: h2TextStyle))
                                : Expanded(
                                    flex: 7,
                                    child: TextFormField(
                                      maxLines: 2,
                                      controller: title,
                                      autofocus: true,
                                      enabled: _editable,
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
                                  'written by ' + widget.data.writer,
                                  style: bodyTextStyle,
                                  textAlign: TextAlign.end,
                                )),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            !_editable
                                ? Expanded(
                                    flex: 7,
                                    child: Text(widget.data.title,
                                        style: h2TextStyle))
                                : Expanded(
                                    flex: 7,
                                    child: TextFormField(
                                      maxLines: 2,
                                      controller: title,
                                      autofocus: true,
                                      enabled: _editable,
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
                                  'written by ' + widget.data.writer,
                                  style: bodyTextStyle,
                                  textAlign: TextAlign.end,
                                )),
                          ],
                        ),
                ),
                SizedBox(height: 5),
                Expanded(
                  // title and writer
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('date ' + widget.data.date, style: bodyTextStyle),
                      SizedBox(width: 10),
                      Text('view ' + widget.data.view.toString(),
                          style: bodyTextStyle),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                    // content
                    flex: 8,
                    child: !_editable
                        ? Markdown(
                            controller: controller,
                            selectable: true,
                            data: widget.data.content,
                          )
                        : TextFormField(
                            maxLines: null,
                            controller: content,
                            autofocus: true,
                            enabled: _editable,
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
