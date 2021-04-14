import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';
import 'package:yonsei_financial_tech/components/color.dart';
import 'package:yonsei_financial_tech/components/components.dart';
import 'package:yonsei_financial_tech/model/person.dart';
import 'package:yonsei_financial_tech/pages/people/people_firebase.dart';

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
          SingleChildScrollView(
            controller: _controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // MENU BAR ----------------------------------------------------------
                MenuBar(),
                // IMAGE BACKGROUND - NAME -------------------------------------------
                backImage(context),
                // About Us - INTRODUCTION -------------------------------------------
                FutureBuilder<QuerySnapshot>(
                    future: fetchedData_yonsei,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('500 - error'));
                      } else if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        List<Map<String, dynamic>> _yonsei_people = [];
                        snapshot.data.docs.forEach((element) {
                          _yonsei_people.add(element.data());
                        });
                        return yonseiPeople(context, _yonsei_people);
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
                        snapshot.data.docs.forEach((element) {
                          _aca_people.add(element.data());
                        });
                        return acaExPeople(context, _aca_people);
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
                        snapshot.data.docs.forEach((element) {
                          _indus_people.add(element.data());
                        });
                        return indusExPeople(context, _indus_people);
                      }
                    }),
                Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Container backImage(BuildContext context) {
  return Container(
    height: 600,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/introBackground.jpeg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Container yonseiPeople(BuildContext context, List _people) {
  var md = MediaQuery.of(context).size;
  return Container(
    color: themeBlue,
    padding: marginHorizontal(md.width * 0.4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("People", style: h2WhiteTextStyle),
        SizedBox(
          height: 80,
        ),
        Text("참여 전임교원", style: h3WhiteTextStyle),
        SizedBox(
          height: 80,
        ),
        _peopleList(context, _people, false),
      ],
    ),
  );
}

Container acaExPeople(BuildContext context, List _people) {
  var md = MediaQuery.of(context).size;

  return Container(
    padding: marginHorizontal(md.width * 0.4),
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
        _peopleList(context, _people, true),
      ],
    ),
  );
}

Container indusExPeople(BuildContext context, List _people) {
  var md = MediaQuery.of(context).size;

  return Container(
    color: themeBlue,
    padding: marginHorizontal(md.width * 0.4),
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
        _peopleList(context, _people, false),
      ],
    ),
  );
}

Widget _peopleList(BuildContext context, List _people, bool isBackWhite) {
  var md = MediaQuery.of(context).size;
  return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        crossAxisSpacing: 10,
        mainAxisSpacing: 50,
      ),
      itemCount: _people.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Column(
            children: <Widget>[
              Text(_people[index]["name"],
                  style: isBackWhite ? h3TextStyle : h3WhiteTextStyle),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/fintech2.jpeg")),
                ),
              ),
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
