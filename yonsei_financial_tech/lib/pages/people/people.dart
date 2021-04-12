import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';
import 'package:yonsei_financial_tech/components/color.dart';
import 'package:yonsei_financial_tech/components/components.dart';
import 'package:yonsei_financial_tech/model/person.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  List<Person> _people = [
    Person.fromMap({
      'name': '안광원',
      'major': '연세대학교 산업공학과',
      'img': 'images/fintech2.jpeg',
      'field': '거시경제, 자산가격 결정이론, 경제물리'
    }),
    Person.fromMap({
      'name': '박태영',
      'major': '연세대학교 응용통계학과',
      'img': 'images/fintech2.jpeg',
      'field': '데이터 사이언스, 베이지안 통계학'
    }),
    Person.fromMap({
      'name': '장수령',
      'major': '연세대학교 경영학과',
      'img': 'images/fintech2.jpeg',
      'field': '소비자-기업 행동모델, 빅데이터 분석'
    }),
    Person.fromMap({
      'name': '장한울',
      'major': '연세대학교 산업공학과 및 투자정보공학과',
      'img': 'images/fintech2.jpeg',
      'field': '부동산 경제, 도시계획, 거시경제'
    }),
  ];

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
                yonseiPeople(context, _people),
                // Meet Our People ---------------------------------------------------
                acaExPeople(context, _people),
                indusExPeople(context, _people),
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

Container yonseiPeople(BuildContext context, List<Person> _people) {
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
        Text("People", style: headlineWhiteTextStyle),
        SizedBox(
          height: 80,
        ),
        Text("참여 전임교원", style: subtitleWhiteTextStyle),
        SizedBox(
          height: 80,
        ),
        _peopleList(context, _people, false),
      ],
    ),
  );
}

Container acaExPeople(BuildContext context, List<Person> _people) {
  var md = MediaQuery.of(context).size;

  return Container(
    padding: marginHorizontal(md.width * 0.4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("외부 전문가 - 학계", style: subtitleTextStyle),
        SizedBox(
          height: 80,
        ),
        _peopleList(context, _people, true),
      ],
    ),
  );
}

Container indusExPeople(BuildContext context, List<Person> _people) {
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
        Text("외부 전문가 - 산업계", style: subtitleWhiteTextStyle),
        SizedBox(
          height: 80,
        ),
        _peopleList(context, _people, false),
      ],
    ),
  );
}

Widget _peopleList(
    BuildContext context, List<Person> _people, bool isBackWhite) {
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
              Text(_people[index].name,
                  style:
                      isBackWhite ? subtitleTextStyle : subtitleWhiteTextStyle),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(_people[index].img)),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(_people[index].major,
                  style: isBackWhite ? bodyTextStyle : bodyWhiteTextStyle),
              SizedBox(
                height: 15.0,
              ),
              Text(_people[index].field,
                  style: isBackWhite ? bodyTextStyle : bodyWhiteTextStyle),
            ],
          ),
        );
      });
}
