import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yonsei_financial_tech/components/components.dart';

class PaperPage extends StatefulWidget {
  @override
  _PaperPageState createState() => _PaperPageState();
}

class _PaperPageState extends State<PaperPage> {
  ScrollController _controller = new ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference papers = FirebaseFirestore.instance.collection('paper');

  var fetchedData;

  // filter
  var filterText = '';

  @override
  void initState() {
    super.initState();
    fetchedData = papers.orderBy('id').get();
  }

  _refresh(dynamic value) => setState(() {
        fetchedData = papers.orderBy('id').get();
      });

  // search action
  void searchWithTitle(String title) {
    setState(() {
      filterText = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
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
                        MenuBar(),
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
                    snapshot.data.docs.forEach((element) {
                      if (filterText.length == 0) {
                        Map<String, dynamic> temp = {
                          'docID': element.id,
                          ...element.data()
                        };
                        data.add(temp);
                      } else {
                        if (element
                            .data()['title']
                            .toString()
                            .contains(filterText)) {
                          Map<String, dynamic> temp = {
                            'docID': element.id,
                            ...element.data()
                          };
                          data.add(temp);
                        }
                      }
                    });
                    // reverse data
                    data = data.reversed.toList();
                    print(data.length);
                    return Column(
                      children: <Widget>[
                        // MENU BAR ----------------------------------------------------------
                        MenuBar(),
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
                                          Text(
                                            "'" +
                                                filterText +
                                                "'" +
                                                ' 관련 검색 결과 초기화',
                                            style: h3WhiteTextStyle,
                                          ),
                                          TextButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  filterText = '';
                                                });
                                              },
                                              icon: Icon(Icons.close_rounded,
                                                  color: Colors.white,
                                                  size: 22),
                                              label: Text('')),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        // Board  ------------------------------------------------------------
                        BoardArticle(
                          board: data,
                          storage: 'paper',
                          onRefresh: _refresh,
                        ),
                        Footer(),
                      ],
                    );
                  }
                },
              )),
        ],
      ),
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
            child: Text(
              'Working Papers',
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
          height: 100,
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
                                  offset: Offset.fromDirection(-2.0),
                                  blurRadius: 16.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(20.0)),
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
                                  labelStyle: GoogleFonts.notoSans(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.0))),
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
                                borderRadius: BorderRadius.circular(20.0),
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
                              borderRadius: BorderRadius.circular(20.0)),
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
                                  labelStyle: GoogleFonts.notoSans(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.0))),
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
                                borderRadius: BorderRadius.circular(20.0),
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
