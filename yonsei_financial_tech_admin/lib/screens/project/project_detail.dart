import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

Future<void> updateDocument(String pathID, Project data) {
  return FirebaseFirestore.instance.collection('project').doc(pathID).update({
    'content': data.content,
    'from': data.from,
    'imageDesc': data.imageDesc,
    'period': data.period,
    'title': data.title
  }).then((value) => print("project updated"));
}

Future<void> uploadImage(html.File data, int id) async {
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref('gs://ysfintech-homepage.appspot.com/')
      .child('project/$id.png');

  final metadata = firebase_storage.SettableMetadata(contentType: 'image/png');

  try {
    await ref.putBlob(data, metadata);
  } catch (e) {
    print(e);
  }
}

class ProjectDetail extends StatefulWidget {
  final ScrollController controller;
  final String pathID;
  final Project data;
  ProjectDetail({this.data, this.pathID, this.controller});
  @override
  _ProjectDetailState createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  TextEditingController title;
  TextEditingController content;
  TextEditingController from;
  TextEditingController period;
  TextEditingController imageDesc;
  int _id;

  bool _editable = false;
  // image file to be selected
  html.File _file;

  Future<String> downloadURL(path) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(path)
        .getDownloadURL();
    return downloadURL;
  }

  @override
  void initState() {
    super.initState();
    title = new TextEditingController(text: widget.data.title);
    content = new TextEditingController(text: widget.data.content);
    from = new TextEditingController(text: widget.data.from);
    period = new TextEditingController(text: widget.data.period);
    imageDesc = new TextEditingController(text: widget.data.imageDesc);
    _id = widget.data.id;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: paddingH20V20,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        controller: widget.controller,
        children: <Widget>[
          Row(children: <Widget>[
            Icon(
              Icons.tag,
            ),
            SizedBox(
              width: 5,
            ),
            Text(_id.toString())
          ]),
          TextFormField(
              // title
              autofocus: true,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: lightWhite,
                  icon: Icon(Icons.title_rounded)),
              controller: title,
              enabled: _editable),
          SizedBox(height: 10),
          TextFormField(
              // period
              autofocus: true,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: lightWhite,
                  icon: Icon(Icons.date_range_rounded)),
              controller: period,
              enabled: _editable),
          SizedBox(height: 10),
          TextFormField(
              // from
              autofocus: true,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: lightWhite,
                  icon: Icon(Icons.place_rounded)),
              controller: from,
              enabled: _editable),
          SizedBox(height: 10),
          TextFormField(
              //content
              autofocus: true,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: lightWhite,
                  icon: Icon(Icons.article_rounded)),
              controller: content,
              enabled: _editable),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: FutureBuilder(
              future: downloadURL(widget.data.imagePath),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(snapshot.data.toString(),
                        width: size.width * 0.17,
                        height: size.width * 0.17,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error_outline_rounded)),
                  );
                } else
                  return CircularProgressIndicator();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _editable
              ? Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(_file == null ? '이미지 업로드 및 수정' : _file.name,
                          style: bodyTextStyle),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: themeBlue),
                        onPressed: () async {
                          // 사진을 선택하는 ImagePickerWeb -> html.File 로 전환
                          final _picked = await ImagePickerWeb.getImage(
                              outputType: ImageType.file);
                          setState(() {
                            _file = _picked;
                          });
                        },
                        child: Text(" 파일 선택 ", style: bodyWhiteTextStyle),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                        onPressed: () {
                          return uploadImage(_file, _id).then((value) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '${title.text}의 이미지가 수정되었습니다.'))));
                        },
                        child: Text(" 저장 ", style: bodyWhiteTextStyle),
                      )
                    ],
                  ))
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              //imageDesc
              autofocus: true,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: lightWhite,
                  icon: Icon(Icons.description_rounded)),
              controller: imageDesc,
              enabled: _editable),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: themeBlue),
            child: Container(
                width: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(_editable
                        ? Icons.save_alt_rounded
                        : Icons.edit_rounded),
                    SizedBox(width: 10),
                    Text(_editable ? 'SAVE' : 'EDIT', style: bodyWhiteTextStyle)
                  ],
                )),
            onPressed: () {
              setState(() {
                // save to firebase
                if (_editable) {
                  updateDocument(widget.pathID, new Project(
                    title: title.text,
                    content: content.text,
                    from: from.text,
                    period: period.text,
                    imageDesc: imageDesc.text
                  )).then((value) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('${title.text}의 내용이 수정되었습니다.'))));
                }
                _editable = !_editable;
              });
            },
          ),
          SizedBox(
            height: 10,
            child: divider,
          ),
        ],
      ),
    );
  }
}
