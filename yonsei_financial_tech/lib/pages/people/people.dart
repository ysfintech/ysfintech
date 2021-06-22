import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';
import 'package:yonsei_financial_tech/components/color.dart';
import 'package:yonsei_financial_tech/components/components.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:yonsei_financial_tech/model/person.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference peo_yonsei =
      FirebaseFirestore.instance.collection("people_yonsei");
  CollectionReference peo_aca =
      FirebaseFirestore.instance.collection("people_aca");
  CollectionReference peo_indus =
      FirebaseFirestore.instance.collection("people_indus");

  var fetchedData_yonsei;
  var fetchedData_aca;
  var fetchedData_indus;

  @override
  void initState() {
    super.initState();
    fetchedData_yonsei = peo_yonsei.orderBy("number").get();
    fetchedData_aca = peo_aca.orderBy("number").get();
    fetchedData_indus = peo_indus.orderBy("number").get();
  }

  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scrollbar(
              controller: _controller,
              isAlwaysShown: true,
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // MENU BAR ----------------------------------------------------------
                    MenuBar(),
                    title(context),
                    FutureBuilder<QuerySnapshot>(
                        future: fetchedData_yonsei,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('500 - error'));
                          } else if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            List<Map<String, dynamic>> _yonsei_people = [];
                            List<String> _yonsei_id = [];
                            snapshot.data.docs.forEach((element) {
                              _yonsei_people.add(element.data());
                              _yonsei_id.add(element.id);
                            });
                            return yonseiPeople(
                                context, _yonsei_people, _yonsei_id);
                          }
                        }),
                    FutureBuilder<QuerySnapshot>(
                        future: fetchedData_aca,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('500 - error'));
                          } else if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            List<Map<String, dynamic>> _aca_people = [];
                            List<String> _aca_id = [];
                            snapshot.data.docs.forEach((element) {
                              _aca_people.add(element.data());
                              _aca_id.add(element.id);
                            });
                            return acaExPeople(context, _aca_people, _aca_id);
                          }
                        }),
                    FutureBuilder<QuerySnapshot>(
                        future: fetchedData_indus,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('500 - error'));
                          } else if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            List<Map<String, dynamic>> _indus_people = [];
                            List<String> _indus_id = [];
                            snapshot.data.docs.forEach((element) {
                              _indus_people.add(element.data());
                              _indus_id.add(element.id);
                            });
                            return indusExPeople(
                                context, _indus_people, _indus_id);
                          }
                        }),
                    Footer(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

Container title(BuildContext context) {
  var md = MediaQuery.of(context).size;
  return Container(
    color: Colors.white,
    padding: marginHorizontal(md.width),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 100),
        Container(
          child: Text(
            'People',
            style: h1TextStyle,
          ),
        ),
        SizedBox(height: 100),
      ],
    ),
  );
}

Container yonseiPeople(BuildContext context, List _people, List _id) {
  var md = MediaQuery.of(context).size;
  return Container(
    color: themeBlue,
    padding: marginHorizontal(md.width),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        // Text("People", style: h2WhiteTextStyle),
        // SizedBox(
        //   height: 80,
        // ),
        Text("학내 참여인력", style: h3WhiteTextStyle),
        SizedBox(
          height: 80,
        ),
        _peopleList(context, _people, false, _id),
      ],
    ),
  );
}

Container acaExPeople(BuildContext context, List _people, List _id) {
  var md = MediaQuery.of(context).size;

  return Container(
    padding: marginHorizontal(md.width),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("외부 전문가 - 학계", style: h3TextStyle),
        SizedBox(
          height: 80,
        ),
        _peopleList(context, _people, true, _id),
      ],
    ),
  );
}

Container indusExPeople(BuildContext context, List _people, List _id) {
  var md = MediaQuery.of(context).size;

  return Container(
    color: themeBlue,
    padding: marginHorizontal(md.width),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("외부 전문가 - 산업계", style: h3WhiteTextStyle),
        SizedBox(
          height: 80,
        ),
        _peopleList(context, _people, false, _id),
      ],
    ),
  );
}

Widget _peopleList(
    BuildContext context, List _people, bool isBackWhite, List _id) {
  var md = MediaQuery.of(context).size;
  // firebase storage
  Future<String> downloadURL_jpg(_id) async {
    String downloadURL = '';
    downloadURL = await FirebaseStorage.instance
        .ref('gs://ysfintech-homepage.appspot.com/people/' + _id + '.jpg')
        .getDownloadURL();
    return downloadURL;
  }

  Future<String> downloadURL_png(_id) async {
    String downloadURL = '';
    downloadURL = await FirebaseStorage.instance
        .ref('gs://ysfintech-homepage.appspot.com/people/' + _id + '.png')
        .getDownloadURL();
    return downloadURL;
  }

  return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        crossAxisSpacing: 30,
        mainAxisSpacing: 0,
        childAspectRatio: 0.7,
      ),
      itemCount: _people.length,
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: Column(
            children: <Widget>[
              Text(_people[index]["name"],
                  style: isBackWhite ? h3TextStyle : h3WhiteTextStyle),
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: downloadURL_jpg(_id[index]),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return FutureBuilder(
                          future: downloadURL_png(_id[index]),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('500 - error'));
                            } else if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return ImagePixels(
                                imageProvider: NetworkImage(snapshot.data),
                                defaultColor: Colors.white,
                                builder: (context, img) => CircleAvatar(
                                  radius: 100,
                                  backgroundColor: img.pixelColorAtAlignment(
                                      Alignment.centerLeft),
                                  child: ClipOval(
                                    child: Image.network(snapshot.data,
                                        width: 200, height: 200),
                                  ),
                                ),
                              );
                            }
                          });
                    } else if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ImagePixels(
                        imageProvider: NetworkImage(snapshot.data),
                        defaultColor: Colors.white,
                        builder: (context, img) => CircleAvatar(
                          radius: 100,
                          backgroundColor:
                              img.pixelColorAtAlignment(Alignment.centerLeft),
                          child: ClipOval(
                            child: Image.network(snapshot.data,
                                width: 200, height: 200),
                          ),
                        ),
                      );
                    }
                  }),
              SizedBox(
                height: 15.0,
              ),
              Text(_people[index]["major"],
                  style: isBackWhite ? bodyTextStyle : bodyWhiteTextStyle),
              SizedBox(
                height: 15.0,
              ),
              Text(_people[index]["field"],
                  style: isBackWhite ? bodyTextStyle : bodyWhiteTextStyle),
            ],
          ),
        );
      });
}
