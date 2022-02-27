import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/components.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPageState createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  ScrollController _controller = new ScrollController();

  // filter
  var filterText = '';

  // iframe
  final IFrameElement _iFrameElement = IFrameElement();

  @override
  void initState() {
    super.initState();
    _iFrameElement.src = 'https://scholar.google.co.kr/citations?user=Snutek0AAAAJ&hl=en';
    _iFrameElement.style.border = 'none';

    /**
     *  여기 아래 오류라고 표시가 뜨지만 오류가 난 것이 아닙니다.
     *  iframe을 사용하기 위해서 설정해둔 값입니다. 
     *  @author seunghwanly
     */
   // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iFrameElement,
      );
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
              title(context),
              Container(
                padding: paddingBottom24,
                color: Colors.white,
                child: divider,
              ),
              // WEB VIEW
              SizedBox(
                width: size.width * 0.8,
                height: size.height,
                child: HtmlElementView(
                  key: UniqueKey(),
                  viewType: 'iframeElement',
                ),
              ),
              Footer(),
            ],
          )),
    );
  }

  Container title(BuildContext context) {
    var md = MediaQuery.of(context).size;
    return Container(
      width: md.width,
      color: Colors.white,
      padding: marginHorizontal(md.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 100),
          Container(
            child: Text(
              'Publication',
              style: h1TextStyle,
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
