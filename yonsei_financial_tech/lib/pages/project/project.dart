import 'package:flutter/material.dart';
// firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// components
import 'package:yonsei_financial_tech/components/blog.dart';
import 'package:yonsei_financial_tech/components/components.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  ScrollController _controller = new ScrollController();

  // firebase cloud firestore\
  CollectionReference projects =
      FirebaseFirestore.instance.collection('project');

  // firebase storage
  Future<String> downloadURLExample(title) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('gs://ysfintech-homepage.appspot.com/project/' + title + '.png')
        .getDownloadURL();
    return downloadURL;
  }

  var fetchedData;

  @override
  void initState() {
    super.initState();
    fetchedData = projects.orderBy('id').get();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: <Widget>[
            // MENU BAR ----------------------------------------------------------
            MenuBar(),
            // PROJECTS  ------------------------------------------------------------
            Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 100),
                  Container(
                    margin: marginHorizontal(size.width),
                    child: Text(
                      'Project',
                      style: h1TextStyle,
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
            divider,
            FutureBuilder<QuerySnapshot>(
              future: fetchedData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('500 - error'));
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
                        controller: _controller,  // same scroll controller 
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
                                data[index]!.get('id').toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('500 - error');
                              } else if (!snapshot.hasData) {
                                return SizedBox(); // remove indicator
                              } else {
                                return Article(
                                  backgroundColor: index % 2 == 0
                                      ? Colors.white
                                      : themeBlue,
                                  title: data[index]?.get('title') ?? '',
                                  content: content(),
                                  imageDesc:
                                      data[index]?.get('imageDesc') ?? '',
                                  from: data[index]?.get('from') ?? '',
                                  period: data[index]?.get('period') ?? '',
                                  image: Image.network(
                                      snapshot.data.toString(),
                                      width: 500,  // image in one size
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
      ),
    );
  }
}
