import 'dart:async';
import 'dart:html' as html;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart'; // NetworkImage
import 'package:image_whisperer/image_whisperer.dart'; // BlobImage
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ysfintech_admin/model/person.dart';
import 'package:ysfintech_admin/screens/home/home_screen.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/typography.dart';

class AddPerson extends StatefulWidget {
  final List<int> people_num;
  AddPerson({Key key, @required this.people_num}) : super(key: key);
  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final isSelected = <bool>[false, false, false];

  Person _person = new Person();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _majorController = new TextEditingController();
  TextEditingController _fieldController = new TextEditingController();

  var pickImage = null;
  var blobImage = null;
  String _imageInfo = '';

  Future<void> _getImgFile() async {
    html.File pickImage_a =
        await ImagePickerWeb.getImage(outputType: ImageType.file);
    setState(() {
      pickImage = pickImage_a;
      blobImage = new BlobImage(pickImage_a, name: pickImage.name);
      _imageInfo = '${pickImage_a.name}\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Add New Person", style: h2TextStyle),
              SizedBox(width: 20.0),
              ElevatedButton.icon(
                onPressed: () {
                  _person.name = _nameController.text;
                  _person.major = _majorController.text;
                  _person.field = _fieldController.text;
                  if (isSelected[0] == true) {
                    _person.number = widget.people_num[0] + 1;
                  } else if (isSelected[1] == true) {
                    _person.number = widget.people_num[1] + 1;
                  } else if (isSelected[2] == true) {
                    _person.number = widget.people_num[2] + 1;
                  }

                  if (_person.name == null ||
                      _person.major == null ||
                      _person.field == null ||
                      _person.number == null ||
                      pickImage == null) {
                    _showError();
                  } else {
                    _showAddDialog(_person);
                  }
                },
                icon: Icon(Icons.add, size: 18),
                label: Text('Add new person'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return themeBlue;
                      return themeBlue; // Use the component's default.
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Text("소속 그룹 선택", style: bodyTextStyle),
          SizedBox(height: 15.0),
          selectGroup(),
          SizedBox(height: 20.0),
          Text("신규 등록 정보 입력", style: bodyTextStyle),
          SizedBox(height: 15.0),
          writeInfo(),
          SizedBox(height: 20.0),
          Text("사진 불러오기", style: bodyTextStyle),
          SizedBox(height: 15.0),
          selectImage(),
        ],
      ),
    ));
  }

//소속 그룹 선택
  Widget selectGroup() {
    return ToggleButtons(
      color: Colors.black.withOpacity(0.60),
      selectedColor: themeBlue,
      selectedBorderColor: themeBlue,
      fillColor: themeBlue.withOpacity(0.08),
      splashColor: themeBlue.withOpacity(0.12),
      hoverColor: themeBlue.withOpacity(0.04),
      borderRadius: BorderRadius.circular(4.0),
      constraints: BoxConstraints(minHeight: 36.0),
      isSelected: isSelected,
      onPressed: (index) {
        // Respond to button selection
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            if (i == index) {
              isSelected[i] = true;
            } else {
              isSelected[i] = false;
            }
          }
        });
      },
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('참여 전임교원'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('외부 전문가-학계'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('외부 전문가-산업계'),
        ),
      ],
    );
  }

  //텍스트 입력 위젯
  Widget writeInfo() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            labelText: "이름",
            border: InputBorder.none,
            filled: true,
            fillColor: lightWhite,
          ),
          controller: _nameController,
          enabled: true,
        ),
        SizedBox(
          height: 15.0,
        ),
        TextFormField(
            decoration: InputDecoration(
              labelText: "소속",
              border: InputBorder.none,
              filled: true,
              fillColor: lightWhite,
            ),
            controller: _majorController,
            enabled: true),
        SizedBox(
          height: 15.0,
        ),
        TextFormField(
            decoration: InputDecoration(
              labelText: "전문분야",
              border: InputBorder.none,
              filled: true,
              fillColor: lightWhite,
            ),
            controller: _fieldController,
            enabled: true),
      ],
    );
  }

  //이미지 선택
  Widget selectImage() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _getImgFile, //_pickImage,
                icon: Icon(Icons.check, size: 18),
                label: Text('Select Image'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return themeBlue;
                      return themeBlue; // Use the component's default.
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(_imageInfo, overflow: TextOverflow.ellipsis),
            ],
          ),
          SizedBox(height: 15.0),
          Wrap(children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              child: SizedBox(
                width: 500,
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: pickImage != null
                        ? (context, index) => Image.network(blobImage.url)
                        : (context, index) => Container()),
              ),
            ),
          ]),
        ]);
  }

  void _showAddDialog(Person _person) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Add new Person"),
              content: new Text("새로운 Person을 추가합니다."),
              actions: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new TextButton(
                        child: new Text("확인"),
                        onPressed: () {
                          _add(_person);
                          Navigator.pop(context);
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return new HomeScreen(tap_index: 1);
                          }));
                        }),
                    new TextButton(
                        child: new Text("취소"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ]);
        });
  }

  void _showError() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Add new Person"),
              content: new Text("모든 정보를 올바르게 입력하세요"),
              actions: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new TextButton(
                        child: new Text("확인"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ]);
        });
  }

  void _add(Person _person) async {
    if (isSelected[0] == true) {
      await FirebaseFirestore.instance.collection("people_yonsei").add({
        "name": _person.name,
        "field": _person.field,
        "major": _person.major,
        "number": _person.number,
      }).then((value) => _addImg(value.id));
    } else if (isSelected[1] == true) {
      await FirebaseFirestore.instance.collection("people_aca").add({
        "name": _person.name,
        "field": _person.field,
        "major": _person.major,
        "number": _person.number,
      }).then((value) => _addImg(value.id));
    } else if (isSelected[2] == true) {
      await FirebaseFirestore.instance.collection("people_indus").add({
        "name": _person.name,
        "field": _person.field,
        "major": _person.major,
        "number": _person.number,
      }).then((value) => _addImg(value.id));
    }
  }

  void _addImg(String add_id) {
    String img_name = add_id + "." + pickImage.name.split(".")[1].toLowerCase();
    firebaseStorage.Reference ref = firebaseStorage.FirebaseStorage.instance
        .ref('gs://ysfintech-homepage.appspot.com/')
        .child('people/${img_name}');
    try {
      ref.putBlob(pickImage);
    } catch (e) {
      print(e);
    }
  }
}
