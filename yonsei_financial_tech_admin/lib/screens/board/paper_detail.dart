import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/firebase.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

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
  html.File _file;
  Field _field;

  @override
  void initState() {
    super.initState();
    title = new TextEditingController(text: widget.data.title);
    content = new TextEditingController(text: widget.data.content);
    _field = new Field(collection: 'paper');
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
                  Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 10.0,
                    children: <ElevatedButton>[
                      ElevatedButton.icon(
                        onPressed: () => _field.removeField(widget.pathID),
                        icon: Icon(Icons.delete_rounded),
                        label: Text(
                          "REMOVE",
                          style: bodyWhiteTextStyle,
                        ),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.red[200]),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(_editable
                            ? Icons.save_alt_rounded
                            : Icons.edit_rounded),
                        label: Text(_editable ? 'SAVE' : 'EDIT',
                            style: bodyWhiteTextStyle),
                        style: ElevatedButton.styleFrom(
                            primary: !_editable ? themeBlue : Colors.orange),
                        onPressed: () {
                          setState(() {
                            if (_editable) {
                              _field
                                  .updateDocument(context,
                                      file: _file != null ? _file : null,
                                      pathID: widget.pathID,
                                      content: content.text,
                                      title: title.text,
                                      imagePath: _file != null
                                          ? _field.getImagePath(_file)
                                          : widget.data.imagePath)
                                  .then((value) {
                                if (_file != null) {
                                  if (widget.data.imagePath != null) {
                                    if (_file.name !=
                                        _field.getImageName(
                                            widget.data.imagePath)) {
                                      _field
                                          .removeStorage(widget.data.imagePath)
                                          .then((value) =>
                                              print('prev file deleted'));
                                    }
                                  }
                                }
                              }).then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                              '${widget.data.title}의 내용이 수정되었습니다.'))));
                            }
                            // save to firebase
                            _editable = !_editable;
                          });
                        },
                      )
                    ],
                  )
                ]),
            SizedBox(height: 50),
            // show title
            Expanded(
                // title and writer
                flex: 1,
                child: !_editable
                    ? Text(widget.data.title, style: h2TextStyle)
                    : TextFormField(
                        maxLines: 2,
                        controller: title,
                        autofocus: true,
                        enabled: _editable,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                gapPadding: 16.0,
                                borderSide: BorderSide(color: ligthGray)),
                            filled: true,
                            fillColor: lightWhite,
                            icon: Icon(Icons.title_rounded)),
                      )),
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
                flex: 7,
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
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: _editable
                    ? () async {
                        final _picked = await ImagePickerWeb.getImage(
                            outputType: ImageType.file);
                        try {
                          setState(() {
                            _file = _picked;
                          });
                        } catch (e) {}
                      }
                    : widget.data.imagePath == null
                        ? null
                        : () => _field.downloadFile(widget.data.imagePath),
                style: TextButton.styleFrom(
                    padding: paddingH20V20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(color: lightWhite)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(!_editable
                        ? Icons.download_rounded
                        : Icons.upload_rounded),
                    Text(
                        !_editable
                            ? widget.data.imagePath == null
                                ? '업로드된 파일이 없습니다.'
                                : _field.getImageName(widget.data.imagePath)
                            : _file == null
                                ? widget.data.imagePath == null
                                    ? '파일 업로드 및 수정'
                                    : _field.getImageName(widget.data.imagePath)
                                : _file.name,
                        style: bodyTextStyle)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
