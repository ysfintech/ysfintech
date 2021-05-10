import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/screens/project/project_detail.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

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

  html.File uploadFile;

  Future<void> uploadImage(html.File data) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('gs://ysfintech-homepage.appspot.com/')
        .child('paper/${data.name}');
    try {
      await ref.putBlob(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadDocument(Board data, BuildContext context) {
    return uploadImage(uploadFile).then((value) => FirebaseFirestore.instance
        .collection('paper')
        .add({
          'content': data.content,
          'date': data.date,
          'title': data.title,
          'view': data.view,
          'writer': data.writer,
          'imagePath': data.imagePath
        })
        .then((value) => print("project updated"))
        .then((value) => Navigator.pop(context, true)));
  }

  String getImagePath(html.File file, String path) =>
      'gs://ysfintech-homepage.appspot.com/' + path + '/' + file.name;

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
    return Container(
        padding: paddingH20V20,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
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
                          date: DateTime.now().year.toString().substring(2, 4) +
                              '.' +
                              (DateTime.now().month.toString().length == 1
                                  ? '0' + DateTime.now().month.toString()
                                  : DateTime.now().month.toString()) +
                              '.' +
                              (DateTime.now().day.toString().length == 1
                                  ? '0' + DateTime.now().day.toString()
                                  : DateTime.now().day.toString()),
                          view: 0,
                          content: '''${content.text}
                            ''',
                          imagePath: getImagePath(this.uploadFile, 'paper'));
                      setState(() {
                        uploadDocument(data, context).then((value) =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: [
                                  Text('새로운 게시글이 등록되었습니다.'),
                                  TextButton.icon(
                                      icon: Icon(Icons.refresh_rounded),
                                      label: Text(
                                        "새로고침해주세요",
                                        style: bodyWhiteTextStyle,
                                      ),
                                      onPressed: () => print('parent refresh needed'))
                                ]))));
                      });
                    },
                  )
                ]),
            SizedBox(height: 50),
            // show title
            Align(
                // title and writer

                child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                TextFormField(
                  maxLines: 2,
                  controller: title,
                  autofocus: true,
                  enabled: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          gapPadding: 16.0,
                          borderSide: BorderSide(color: ligthGray)),
                      filled: true,
                      fillColor: lightWhite,
                      icon: Icon(Icons.title_rounded)),
                ),
                Text(
                  'written by ' + '@auth',
                  style: bodyTextStyle,
                  textAlign: TextAlign.end,
                )
              ],
            )),
            SizedBox(height: 20),
            Align(
                // content
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
            Align(
              // file upload
              child: TextButton(
                onPressed: () async {
                  final _picked =
                      await ImagePickerWeb.getImage(outputType: ImageType.file);
                  try {
                    setState(() {
                      uploadFile = _picked;
                    });
                  } catch (e) {}
                },
                style: TextButton.styleFrom(
                    padding: paddingH20V20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(color: lightWhite)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.upload_rounded),
                    Text(uploadFile == null ? '파일 업로드' : uploadFile.name,
                        style: bodyTextStyle)
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ));
  }
}
