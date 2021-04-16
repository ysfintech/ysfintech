import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ysfintech_admin/screens/people/add_person.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:image_picker_web/image_picker_web.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
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
    var md = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(md.width * 0.1, 0, md.width * 0.1, 0),
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            addPerson(context),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 50.0),
            Text("Edit Person", style: h2TextStyle),
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
                    return yonseiPeople(context, _yonsei_people, _yonsei_id);
                  }
                }),
            SizedBox(height: 50.0),
            Divider(
              color: Colors.grey,
            ),
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
            SizedBox(height: 50.0),
            Divider(
              color: Colors.grey,
            ),
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
                    return indusExPeople(context, _indus_people, _indus_id);
                  }
                }),
          ],
        ),
      ),
    );
  }
}

Container addPerson(BuildContext context) {
  var md = MediaQuery.of(context).size;
  return Container(
    //padding: EdgeInsets.fromLTRB(md.width * 0.1, 0, md.width * 0.1, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50.0),
        AddPerson(),
      ],
    ),
  );
}

Container yonseiPeople(BuildContext context, List _people, List _id) {
  var md = MediaQuery.of(context).size;
  return Container(
    //padding: EdgeInsets.fromLTRB(md.width * 0.1, 0, md.width * 0.1, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("참여 전임교원", style: h2TextStyle),
        SizedBox(
          height: 80,
        ),
        _peopleList(context, _people, _id),
      ],
    ),
  );
}

Container acaExPeople(BuildContext context, List _people, List _id) {
  var md = MediaQuery.of(context).size;
  return Container(
    //padding: EdgeInsets.fromLTRB(md.width * 0.1, 0, md.width * 0.1, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("외부 전문가 - 학계", style: h2TextStyle),
        SizedBox(
          height: 80,
        ),
        _peopleList(context, _people, _id),
      ],
    ),
  );
}

Container indusExPeople(BuildContext context, List _people, List _id) {
  var md = MediaQuery.of(context).size;
  return Container(
    //padding: EdgeInsets.fromLTRB(md.width * 0.1, 0, md.width * 0.1, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("외부 전문가 - 산업계", style: h2TextStyle),
        SizedBox(
          height: 80,
        ),
        _peopleList(context, _people, _id),
      ],
    ),
  );
}

Widget _peopleList(BuildContext context, List _people, List _id) {
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

  ScrollController _controller_row = new ScrollController();
  return ListView.builder(
    shrinkWrap: true,
    itemCount: _people.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        contentPadding: EdgeInsets.only(bottom: 15.0),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _controller_row,
          child: Row(
            children: <Widget>[
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
                              return CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(snapshot.data),
                              );
                            }
                          });
                    } else if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(snapshot.data),
                      );
                    }
                  }),
              SizedBox(
                width: 20.0,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("이름: " + _people[index]["name"], style: h3TextStyle),
                    Text("소속: " + _people[index]["major"], style: h3TextStyle),
                    Text("전문분야: " + _people[index]["field"],
                        style: h3TextStyle),
                  ]),
              SizedBox(
                width: 30.0,
              ),
              Column(children: <Widget>[
                ElevatedButton.icon(
                  //onPressed: _pickImage,
                  icon: Icon(Icons.edit, size: 18, color: Colors.white),
                  label: Text('Update', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return themeBlue;
                        return themeBlue; // Use the component's default.
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton.icon(
                  //onPressed: _pickImage,
                  icon: Icon(Icons.delete, size: 18, color: Colors.white),
                  label: Text('Delete', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return themeBlue;
                        return themeBlue; // Use the component's default.
                      },
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      );
    },
  );
}
