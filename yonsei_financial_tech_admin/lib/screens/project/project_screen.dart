import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/screens/project/project_detail.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:html' as html;

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  // firebase firestore
  CollectionReference project =
      FirebaseFirestore.instance.collection('project');

  Future<void> uploadImage(html.File data, int id) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('gs://ysfintech-homepage.appspot.com/')
        .child('project/$id.png');

    final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/png');

    try {
      await ref.putBlob(data, metadata);
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadFirestore(
      {String title,
      String period,
      String from,
      String content,
      String imageDesc,
      int id,
      html.File file}) async {
    return await uploadImage(file, id)
        .then((value) => {
              FirebaseFirestore.instance
                  .collection('project')
                  .add({
                    'id': id,
                    'title': title,
                    'period': period,
                    'from': from,
                    'imageDesc': imageDesc,
                    'imagePath':
                        'gs://ysfintech-homepage.appspot.com/project/$id.png',
                    'content': content
                  })
                  .then((value) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("새로운 Project가 Post되었습니다."),
                      )))
                  .catchError((err) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("포스팅 실패하였습니다."),
                      )))
            })
        .catchError(
            // ignore: return_of_invalid_type_from_catch_error
            (err) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("이미지가 올바르지 않습니다."),
                )));
  }

  // data fetched
  Future<QuerySnapshot> projectData;

  ScrollController _controller = ScrollController();

  // File
  html.File _file;

  @override
  void initState() {
    super.initState();
    projectData = project.orderBy('id').get();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: projectData,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('ERROR - 500'));
        } else if (!snapshot.hasData) {
          return Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()));
        } else {
          return SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          margin: EdgeInsets.only(right: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: themeBlue),
                            child: Container(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.post_add_rounded),
                                    SizedBox(width: 10),
                                    Text('Post new Project',
                                        style: bodyWhiteTextStyle)
                                  ],
                                )),
                            onPressed: () => postDialog(
                                context, snapshot.data.docs.length + 1),
                          ))),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    controller: _controller,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4 / 3,
                        crossAxisCount: 1),
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return ProjectDetail(
                        controller: _controller,
                        data: new Project(
                          id: snapshot.data.docs[index].data()['id'],
                          title: snapshot.data.docs[index].data()['title'],
                          content: snapshot.data.docs[index].data()['content'],
                          from: snapshot.data.docs[index].data()['from'],
                          imageDesc:
                              snapshot.data.docs[index].data()['imageDesc'],
                          period: snapshot.data.docs[index].data()['period'],
                          imagePath:
                              snapshot.data.docs[index].data()['imagePath'],
                        ),
                        pathID: snapshot.data.docs[index].id,
                      );
                    },
                  )
                ],
              ));
        }
      },
    );
  }

  void postDialog(@required BuildContext context, int newpostID) {
    ScrollController controller = new ScrollController();

    // controller
    TextEditingController titleController = new TextEditingController();
    TextEditingController periodController = new TextEditingController();
    TextEditingController fromController = new TextEditingController();
    TextEditingController contentController = new TextEditingController();
    TextEditingController imageDescController = new TextEditingController();

    showBottomSheet(
        backgroundColor: Colors.black45,
        context: context,
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return Container(
            color: Colors.white,
            height: size.height,
            width: size.width,
            padding: paddingH20V20,
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // save and exit
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <TextButton>[
                        TextButton.icon(
                            onPressed: () => uploadFirestore(
                              id: newpostID,
                              title: titleController.text,
                              period: periodController.text,
                              from: fromController.text,
                              content: contentController.text,
                              imageDesc: imageDescController.text,
                              file: _file
                            ).then((value) => Navigator.pop(context)),
                            icon: Icon(
                              Icons.post_add_rounded,
                              size: 30,
                            ),
                            label: Text("저장하기")),
                        TextButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              size: 30,
                            ),
                            label: Text("취소하기")),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // title
                  Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: titleController,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: lightWhite,
                            icon: Icon(Icons.title_rounded)),
                      )),
                  SizedBox(height: 20),
                  // period
                  Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: periodController,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: lightWhite,
                            icon: Icon(Icons.calendar_today_rounded)),
                      )),
                  SizedBox(height: 20),
                  // from
                  Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: fromController,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: lightWhite,
                            icon: Icon(Icons.location_on_rounded)),
                      )),
                  SizedBox(height: 20),
                  // description
                  Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: contentController,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: lightWhite,
                            icon: Icon(Icons.article_rounded)),
                      )),
                  SizedBox(height: 20),
                  // file upload
                  Align(
                      alignment: Alignment.center,
                      child: StatefulBuilder(
                          builder: (context, setState) => Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                        _file == null
                                            ? '이미지 업로드 및 수정'
                                            : _file.name,
                                        style: bodyTextStyle),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: themeBlue),
                                      onPressed: () async {
                                        // 사진을 선택하는 ImagePickerWeb -> html.File 로 전환
                                        final _picked =
                                            await ImagePickerWeb.getImage(
                                                outputType: ImageType.file);
                                        setState(() {
                                          _file = _picked;
                                        });
                                        print(_file.name);
                                      },
                                      child: Text(" 파일 선택 ",
                                          style: bodyWhiteTextStyle),
                                    ),
                                  ]))),
                  SizedBox(height: 20),
                  // image desc
                  Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: imageDescController,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: lightWhite,
                            icon: Icon(Icons.description_rounded)),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
