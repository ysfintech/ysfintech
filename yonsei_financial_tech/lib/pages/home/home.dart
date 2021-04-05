import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';
import 'package:yonsei_financial_tech/components/components.dart';
import 'package:yonsei_financial_tech/components/color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                title(context),
                // About Us - INTRODUCTION -------------------------------------------
                Article(
                  true,
                  title: 'Introduction',
                  imagePath: 'images/fintech2.jpeg',
                  content:
                      '본 연구센터는 금융 시장의 제반 이슈들에 대한 재무이론 기반 분석과 중장기적 금융 정책 수립을 위한 연구를 수행한다. 이를 위해, 금융 및 공학 등 관련 분야의 교내외 전문 연구자와 교수진이 참여한다. \n\n 주요 연구주제는 인공지능, 핀테크, 암호화폐 등 차세대 기술 및 사회변화를 반영한 금융 및 경제 분야의 최신 주제들로 구성하여 가까운 미래 트렌드를 반영할 예정이다. 연구 결과물들은 최상위 수준 국제학술지 등에 발표하며, 정책적 시사점을 토대로 실제 금융 정책에도 응용이 가능할 것으로 전망된다.',
                  backgroundColor: Colors.white,
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

Stack title(BuildContext context) {
  var md = MediaQuery.of(context).size;
  // margin: EdgeInsets.symmetric(horizontal: md.width * 0.1, vertical: 0.1),
  return Stack(
    children: <Widget>[
      Container(
          // height: md.height * 0.58,
          height: 600,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/introBackground.jpeg'),
            fit: BoxFit.cover,
          ))),
      Positioned(
        left: 150,
        top: 150,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: themeBlue,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset.fromDirection(3.0),
                      blurRadius: 10.0,
                      spreadRadius: 3.0)
                ]),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            width: md.width > 450 ? 500 : 400,
            height: md.height > 400 ? 300 : 240,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '연세대학교 금융기술센터', style: titleIntroductionTextStyle),
                TextSpan(
                    text: '에 \n',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                TextSpan(
                    text: '오신 것을 환영합니다',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ]),
            )),
      ),
    ],
  );
}
