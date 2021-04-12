import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yonsei_financial_tech/components/components.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPageState createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
ScrollController _controller = new ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference papers = FirebaseFirestore.instance.collection('publication');

  var fetchedData;

  // filter
  var filterText = '';

  @override
  void initState() {
    super.initState();
    fetchedData = papers.orderBy('number').get();
  }

  // search action
  void searchWithTitle(String title) {
    setState(() {
      filterText = title;
    });
  }
  // FOR TESTING
  // Future<void> add() {
  //   for (int i = 2; i < 15; ++i) {
  //     papers.add({
  //       'number': i,
  //       'title': 'test-' + i.toString(),
  //       'writer': 'test-writer',
  //       'date': '21.04.08',
  //       'view': Random().nextInt(50)
  //     }).then((value) => print('completed'));
  //   }
  // }
  // TextButton(
  //                         onPressed: add,
  //                         child: Text("ADD!!!"),
  //                       ),

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
                        data.add(element.data());
                      } else {
                        if (element
                            .data()['title']
                            .toString()
                            .contains(filterText)) {
                          data.add(element.data());
                        }
                      }
                    });
                    // reverse data
                    data = data.reversed.toList();

                    return Column(
                      children: <Widget>[
                        // MENU BAR ----------------------------------------------------------
                        MenuBar(),
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
                        BoardArticle(board: data),
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

  Widget searchTab(BuildContext context) {
    var md = MediaQuery.of(context).size;

    TextEditingController textEditingController = new TextEditingController();

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
            // height: md.height * 0.58,
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/publication.jpg'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              fit: BoxFit.cover,
            ))),
        Container(
          margin: marginHorizontal(md.width * 0.5),
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
                                  labelStyle: GoogleFonts.montserrat(
                                      color: Colors.black87,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
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
                          child: Text("검색",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0)),
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
                                  labelStyle: GoogleFonts.montserrat(
                                      color: Colors.black87,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
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
                          child: Text("검색",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0)),
                        ))
                  ],
                ),
        ),
        // title
        Positioned(
          top: 50.0,
          left: 100.0,
          child: Text('Publication',
              style: articleTitleTextStyle(color: Colors.white)),
        )
      ],
    );
  }
}