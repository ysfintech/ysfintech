import 'dart:html';

import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';
import 'package:yonsei_financial_tech/components/components.dart';
// firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // firebase cloud firestore\
  CollectionReference homes =
      FirebaseFirestore.instance.collection('introduction');

  // firebase storage
  Future<String> downloadURLExample(title) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('gs://ysfintech-homepage.appspot.com/introduction/' +
            title +
            '.jpg')
        .getDownloadURL();
    return downloadURL;
  }

  var fetchedData;

  @override
  void initState() {
    super.initState();
    fetchedData = homes.orderBy('id').get();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          // MENU BAR ----------------------------------------------------------
          MenuBarY(),
          // IMAGE BACKGROUND - NAME -------------------------------------------
          title(context),
          // PROJECTS  ------------------------------------------------------------
          FutureBuilder<QuerySnapshot>(
            future: fetchedData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text('500 - error'));
              } else if (!snapshot.hasData) {
                return Center(
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator()));
              } else {
                var data = snapshot.data!.docs.asMap();
                return Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        // content parsing
                        List<String> parsedContent = data[index]!
                            .get('content')
                            .toString()
                            .split('<br>');
                        String content() {
                          StringBuffer sb = new StringBuffer();
                          for (String item in parsedContent) {
                            sb.write(item + '\n\n');
                          }
                          return sb.toString();
                        }

                        return FutureBuilder(
                          future: downloadURLExample(
                              data[index]?.get('id').toString() ?? ''),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  '500 - error');
                            } else if (!snapshot.hasData) {
                              return SizedBox(); // remove indicator
                            } else {
                              return ArticleB(
                                backgroundColor: index % 2 == 0
                                    ? themeBlue
                                    : Colors.white,
                                title: data[index]?.get('title') ?? '',
                                content: content(),
                                role: data[index]?.get('role') ?? '',
                                name: data[index]?.get('name') ?? '',
                                image:
                                    Image.network(snapshot.data.toString(),
                                        width: 200, // image in one size
                                        fit: BoxFit.cover),
                              );
                            }
                          },
                        );
                      },
                    ));
              }
            },
          ),
          Footer(),
        ],
      ),
    );
  }
}
