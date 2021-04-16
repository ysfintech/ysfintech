import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/typography.dart';

class AddPerson extends StatefulWidget {
  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final isSelected = <bool>[false, false, false];

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _majorController = new TextEditingController();
  TextEditingController _fieldController = new TextEditingController();

  final _pickedImages = <Image>[];
  String _imageInfo = '';
  Future<void> _pickImage() async {
    Image fromPicker =
        await ImagePickerWeb.getImage(outputType: ImageType.widget);

    if (fromPicker != null) {
      setState(() {
        _pickedImages.clear();
        _pickedImages.add(fromPicker);
      });
    }
  }

  Future<void> _getImgFile() async {
    html.File infos = await ImagePickerWeb.getImage(outputType: ImageType.file);
    setState(() => _imageInfo =
        'Name: ${infos.name}\nRelative Path: ${infos.relativePath}');
  }

  Future<void> _getImgInfo() async {
    final infos = await ImagePickerWeb.getImageInfo;
    setState(() {
      _pickedImages.clear();
      _pickedImages.add(Image.memory(
        infos.data,
        semanticLabel: infos.fileName,
      ));
      _imageInfo = '${infos.fileName}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Add New Person", style: h2TextStyle),
              SizedBox(width: 20.0),
              ElevatedButton.icon(
                onPressed: _pickImage,
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
    );
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
            enabled: false),
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
            enabled: false),
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
            enabled: false),
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
                onPressed: _getImgInfo, //_pickImage,
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
                    itemCount: _pickedImages == null ? 0 : _pickedImages.length,
                    itemBuilder: (context, index) => _pickedImages[index]),
              ),
            ),
          ]),
        ]);
  }
}
