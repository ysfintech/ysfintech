import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/components.dart';
import 'package:yonsei_financial_tech/firebase/fetch.dart';
import 'package:yonsei_financial_tech/model/board.dart';

class PaperPage extends StatefulWidget {
  @override
  _PaperPageState createState() => _PaperPageState();
}

class _PaperPageState extends State<PaperPage> {
  ScrollController _controller = new ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference papers = FirebaseFirestore.instance.collection('paper');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
              controller: _controller,
              child: FutureBuilder<QuerySnapshot>(
                future: papers.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  
                  if (snapshot.hasError) {
                    return Center(child: Text('500 - error'));
                  } else if (!snapshot.hasData) {
                    print(snapshot.connectionState);

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
                    print(snapshot.data.size.toString());

                    List<Map<String,dynamic>> data = [];

                    snapshot.data.docs.forEach((element) {
                      data.add(element.data());
                    });

                    return Column(
                      children: <Widget>[
                        // MENU BAR ----------------------------------------------------------
                        MenuBar(),
                        // IMAGE BACKGROUND - NAME -------------------------------------------
                        searchTab(context),
                        // Board  ------------------------------------------------------------
                        BoardArticle(board: data)
                      ],
                    );
                  }
                },
              )),
        ],
      ),
    );
  }
}

Container searchTab(BuildContext context) {
  var md = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
    child: Text("search Tab"),
  );
}
