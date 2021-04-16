import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/screens/project/project_detail.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/typography.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  // firebase firestore
  CollectionReference project =
      FirebaseFirestore.instance.collection('project');

  // data fetched
  Future<QuerySnapshot> projectData;

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    projectData = project.orderBy('id').get();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: projectData,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('ERROR - 500'));
        } else if (!snapshot.hasData) {
          return Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()));
        } else {
          return SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          margin: EdgeInsets.only(right: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: themeBlue),
                            child: Container(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.post_add_rounded),
                                    SizedBox(width: 10),
                                    Text('Post new Project',
                                        style: bodyWhiteTextStyle)
                                  ],
                                )),
                            onPressed: () {
                              print('addd');
                            },
                          ))),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    controller: _controller,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        // childAspectRatio: size.width > 800 ? 3 / 4 : 1 / 6,
                        // crossAxisCount: size.width > 800 ? 2 : 1,
                        childAspectRatio: 4/3,
                        crossAxisCount: 1),
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return ProjectDetail(
                        controller: _controller,
                        data: new Project(
                          id: snapshot.data.docs[index].data()['id'],
                          title: snapshot.data.docs[index].data()['title'],
                          content: snapshot.data.docs[index].data()['content'],
                          from: snapshot.data.docs[index].data()['from'],
                          imageDesc:
                              snapshot.data.docs[index].data()['imageDesc'],
                          period: snapshot.data.docs[index].data()['period'],
                          imagePath:
                              snapshot.data.docs[index].data()['imagePath'],
                        ),
                        pathID: snapshot.data.docs[index].id,
                      );
                    },
                  )
                ],
              ));
        }
      },
    );
  }
}
