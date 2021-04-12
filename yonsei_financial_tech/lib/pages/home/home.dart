import 'dart:html';

import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';
import 'package:yonsei_financial_tech/components/components.dart';
// firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller = new ScrollController();

  // fire store
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference intro =
      FirebaseFirestore.instance.collection('introduction');
  // data
  var fetchedData;

  @override
  void initState() {
    super.initState();
    fetchedData = intro.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // MENU BAR ----------------------------------------------------------
                MenuBar(),
                // IMAGE BACKGROUND - NAME -------------------------------------------
                title(context),
                // About Us - INTRODUCTION -------------------------------------------
                FutureBuilder<QuerySnapshot>(
                  future: fetchedData,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('500 - error'));
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      /**
                       *  개행 문자를 포함해서 return 하기 
                       */
                      List<String> contentArray = snapshot.data.docs[0].data()['content'].toString().split('<br>');
                      String content() {
                        StringBuffer sb =new StringBuffer();
                        for(String item in contentArray) {
                          sb.write(item + '\n\n');
                        }
                        return sb.toString();
                      }

                      return Article(
                        false,
                        title: snapshot.data.docs[0].data()['title'],
                        content: content(),
                      );
                    }
                  },
                ),
                // FOOTER ------------------------------------------------------------
                Footer()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
