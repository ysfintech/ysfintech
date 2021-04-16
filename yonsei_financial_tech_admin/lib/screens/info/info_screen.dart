import 'package:flutter/material.dart';
// firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ysfintech_admin/model/introduction.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/widgets/item.dart';

String convertString(list) {
  StringBuffer sb = new StringBuffer();
  for (String item in list) {
    sb.write(item + '\n\n');
  }
  return sb.toString();
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  // firebase firestore
  CollectionReference intro =
      FirebaseFirestore.instance.collection('introduction');
  CollectionReference edu = FirebaseFirestore.instance.collection('education');

  // data fetched
  Future<QuerySnapshot> eduData, introData;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController();
    introData = intro.get();
    eduData = edu.get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([introData, eduData]),
      builder: (context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('ERROR - 500'));
        } else if (!snapshot.hasData) {
          return Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()));
        } else {
          return SingleChildScrollView(
            controller: _controller,
            child: Container(
                padding: paddingH20V20,
                child: Column(
                  children: <Widget>[
                    ItemEditor(
                      data: new Information(
                          title: snapshot.data[0].docs[0].data()['title'],
                          content: snapshot.data[0].docs[0].data()['content']),
                      editable: false,
                      id: snapshot.data[0].docs[0].id,
                    ),
                    SizedBox(
                      height: 50,
                      child: divider,
                    ),
                    ItemEditor(
                      data: new Information(
                          title: snapshot.data[1].docs[0].data()['title'],
                          content: snapshot.data[1].docs[0].data()['content']),
                      editable: false,
                      id: snapshot.data[1].docs[0].id,
                    )
                  ],
                )),
          );
        }
      },
    );
  }
}
