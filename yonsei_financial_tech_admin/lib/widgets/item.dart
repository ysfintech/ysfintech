import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ysfintech_admin/model/introduction.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/typography.dart';

class ItemEditor extends StatefulWidget {
  final onPressed;
  final String id;
  final Information data;
  final bool editable;
  ItemEditor({this.data, this.editable, this.id, this.onPressed});
  @override
  _ItemEditorState createState() => _ItemEditorState();
}

class _ItemEditorState extends State<ItemEditor> {
  TextEditingController _titleController;
  TextEditingController _contentController;

  bool _editable;

  // firebase
  // firebase firestore
  CollectionReference intro =
      FirebaseFirestore.instance.collection('introduction');
  CollectionReference edu = FirebaseFirestore.instance.collection('education');

  // data update
  Future<void> updateDocument(String collection, String id,
      {String title, String content}) {
    if (collection == 'Introduction') {
      // print('update introduction');
      return intro.doc(id).update({'content': content}).then(
          (value) => print("introduction updated"));
    } else {
      // print('update education');
      return edu.doc(id).update({'content': content}).then(
          (value) => print("introduction updated"));
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController = new TextEditingController(text: widget.data.title);
    _contentController = new TextEditingController(text: widget.data.content);
    _editable = widget.editable;
  }

  @override
  Widget build(BuildContext context) {
    print(_titleController.text);
    return Container(
      child: Column(
        children: <Widget>[
          // title
          TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: lightWhite,
                  icon: Icon(Icons.title_rounded)),
              controller: _titleController,
              enabled: false),
          SizedBox(height: 20),
          // content
          TextFormField(
              autofocus: true,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: lightWhite,
                  icon: Icon(Icons.article_rounded)),
              controller: _contentController,
              enabled: _editable),
          _editable
              ? Text("줄 바꿈을 하실 위치에 <br> 를 써주세요.", style: imageDescTextStyle)
              : SizedBox(),
          SizedBox(height: 20),
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
                  print(_titleController.text);
                  updateDocument(_titleController.text, widget.id,
                          content: _contentController.text)
                      .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${_titleController.text}의 내용이 수정되었습니다.'))));
                }
                _editable = !_editable;
              });
            },
          )
        ],
      ),
    );
  }
}
