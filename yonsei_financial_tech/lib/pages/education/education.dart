import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';
import 'package:yonsei_financial_tech/components/components.dart';

class EduPage extends StatefulWidget {
  @override
  _EduPageState createState() => _EduPageState();
}

class _EduPageState extends State<EduPage> {
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
                // Education Article -------------------------------------------------
                Article(
                  false,
                  backgroundColor: themeBlue,
                  title: 'Education',
                  content:
                      '최신 금융연구에서 사용되는 다양한 연구 방법론과 적용 사례 등을 학습할 수 있는 금융기술전문가 교육과정을 진행합니다. 본 교육과정은 학계의 최신 이론 및 업계 전문가의 경험을 결합하여 실제 금융 관련 프로젝트나 사업에 적용 가능한 내용으로 구성됩니다.\n\n이를 위해, 국내외의 저명한 교수진과 업계 최고 수준의 전문가들로 구성된 강사진들이 주제별로 방법론 및 실전 사례 등을 단계적으로 구성하여 이해도를 높일 수 있도록 하였습니다. 또한, 교육과정에서 학습한 내용을 현업에서 더욱 발전시킬 수 있도록, 수강생과 강사진 간의 지속적인 네트워킹을 지원할 예정입니다.',
                  
                ),
                // Footer   ----------------------------------------------------------
                Footer()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
