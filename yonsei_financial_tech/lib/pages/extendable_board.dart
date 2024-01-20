import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:yonsei_financial_tech/components/components.dart';

class ExtendablePage extends StatefulWidget {
  final String collectionName;

  ExtendablePage(this.collectionName);

  @override
  _ExtendablePageState createState() => _ExtendablePageState();
}

class _ExtendablePageState extends State<ExtendablePage> {
  ScrollController _controller = new ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late final CollectionReference papers;

  var fetchedData;

  // filter
  var filterText = '';

  @override
  void initState() {
    super.initState();
    papers = FirebaseFirestore.instance.collection(widget.collectionName);
    fetchedData = papers.orderBy('id').get();
  }

  _refresh() => setState(
        () {
          fetchedData = papers.orderBy('id').get();
        },
      );

  // search action
  void searchWithTitle(String title) {
    setState(
      () {
        filterText = title;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          controller: _controller,
          child: FutureBuilder<QuerySnapshot>(
            future: fetchedData,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('500 - error'));
              } else if (!snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    // MENU BAR ----------------------------------------------------------
                    MenuBarY(),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 400,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Footer()
                  ],
                );
              } else {
                // data
                List<Map<String, dynamic>> data = [];
                // add filtering
                snapshot.data!.docs.forEach((element) {
                  if (filterText.length == 0) {
                    Map<String, dynamic> temp = {
                      'docID': element.id,
                      ...element.data() as Map<String, dynamic>
                    };
                    data.add(temp);
                  } else {
                    if (element
                        .get('title')
                        .toString()
                        .contains(filterText)) {
                      Map<String, dynamic> temp = {
                        'docID': element.id,
                        ...element.data() as Map<String, dynamic>
                      };
                      data.add(temp);
                    }
                  }
                });
                data = data.reversed.toList();
                return Column(
                  children: <Widget>[
                    // MENU BAR ----------------------------------------------------------
                    MenuBarY(),
                    title(context),
                    Container(
                      padding: paddingBottom24,
                      color: Colors.white,
                      child: divider,
                    ),
                    // IMAGE BACKGROUND - NAME -------------------------------------------
                    searchTab(context),
                    filterText.length != 0
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.15,
                                      vertical: 20),
                                  color: themeBlue.withOpacity(0.7),
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              filterText = '';
                                            });
                                          },
                                          child: Text(
                                            "'" +
                                                filterText +
                                                "'" +
                                                ' 관련 검색 결과 초기화',
                                            style: h3WhiteTextStyle,
                                          ),
                                          style: ButtonStyle(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith(
                                                      (states) => Colors
                                                          .transparent))),
                                      TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              filterText = '';
                                            });
                                          },
                                          icon: Icon(
                                              Icons.close_rounded,
                                              color: Colors.white,
                                              size: 22),
                                          label: Text('')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(height: 0),
                    // Board  ------------------------------------------------------------
                    BoardArticle(
                      board: data,
                      storage: '${widget.collectionName}',
                      onRefresh:_refresh,
                    ),
                    Footer(),
                  ],
                );
              }
            },
          )),
    );
  }

  Container title(BuildContext context) {
    var md = MediaQuery.of(context).size;
    return Container(
      width: md.width,
      color: Colors.white,
      padding: marginHorizontal(md.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 100),
          Container(
            child: widget.collectionName == 'paper'
            ? Text(
                'Working Paper',
                style: h1TextStyle,
              )
            : widget.collectionName == 'work'
              ? Text(
                  'Collaboration',
                  style: h1TextStyle,
                )
              : Text(
                  '${widget.collectionName[0].toUpperCase()}${widget.collectionName.substring(1)}',
                  style: h1TextStyle,
                ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget searchTab(BuildContext context) {
    var md = MediaQuery.of(context).size;

    TextEditingController textEditingController = new TextEditingController();

    return Stack(
      children: <Container>[
        Container(
          color: Colors.white,
          width: md.width,
          height: 70,
        ),
        Container(
          color: Colors.transparent,
          margin: marginHorizontal(md.width),
          height: md.width > 600 ? 60 : 120,
          child: md.width > 600
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        flex: 7,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset.fromDirection(1.0),
                                  blurRadius: 5.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0)),
                          child: TextFormField(
                              controller: textEditingController,
                              onChanged: (value) {
                                textEditingController.text = value;
                                // setting cursor position
                                textEditingController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            textEditingController.text.length));
                              },
                              cursorColor: Colors.blue[400],
                              cursorWidth: 4.0,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '검색할 제목을 입력해주세요.',
                                  labelStyle: bodyTextStyle)),
                        )),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () =>
                              searchWithTitle(textEditingController.text),
                          style: ElevatedButton.styleFrom(
                              primary: themeBlue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              )),
                          child: Text("검색", style: bodyWhiteTextStyle),
                        ))
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset.fromDirection(-2.0),
                                  blurRadius: 16.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0)),
                          child: TextFormField(
                              controller: textEditingController,
                              onChanged: (value) {
                                textEditingController.text = value;
                                // setting cursor position
                                textEditingController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            textEditingController.text.length));
                              },
                              cursorColor: Colors.blue[400],
                              cursorWidth: 4.0,
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '검색할 제목을 입력해주세요.',
                                  labelStyle: bodyTextStyle)),
                        )),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          onPressed: () =>
                              searchWithTitle(textEditingController.text),
                          style: ElevatedButton.styleFrom(
                              primary: themeBlue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              )),
                          child: Text("검색", style: bodyWhiteTextStyle),
                        ))
                  ],
                ),
        )
      ],
    );
  }
}
