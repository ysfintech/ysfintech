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
  var filterText;

  @override
  void initState() {
    super.initState();
    fetchedData = papers.get();
  }

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
                        CircularProgressIndicator(),
                        Footer()
                      ],
                    );
                  } else {
                    // data
                    List<Map<String, dynamic>> data = [];
                    // add filtering
                    snapshot.data.docs.forEach((element) {
                      if (filterText == null) {
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

                    return Column(
                      children: <Widget>[
                        // MENU BAR ----------------------------------------------------------
                        MenuBar(),
                        // IMAGE BACKGROUND - NAME -------------------------------------------
                        searchTab(context),
                        // Board  ------------------------------------------------------------
                        BoardArticle(board: data),
                        Footer()
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
              image: AssetImage('images/workingpaper.jpg'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.dstATop),
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
                              onChanged: (value) =>
                                  textEditingController.text = value,
                              cursorColor: Colors.blue[400],
                              cursorWidth: 4.0,
                              cursorHeight: 10,
                              decoration:
                                  InputDecoration(border: InputBorder.none)),
                        )),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          onPressed: () => print('search'),
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
        )
      ],
    );
  }
}
