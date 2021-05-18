import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/components/blog.dart';
import 'package:yonsei_financial_tech/components/components.dart';
// firestore
import 'package:cloud_firestore/cloud_firestore.dart';

class EduPage extends StatefulWidget {
  @override
  _EduPageState createState() => _EduPageState();
}

class _EduPageState extends State<EduPage> {
  ScrollController _controller = new ScrollController();

  // fire store
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference edu = FirebaseFirestore.instance.collection('education');
  // data
  var fetchedData;

  @override
  void initState() {
    super.initState();
    fetchedData = edu.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    // IMAGE BACKGROUND - NAME -------------------------------------------
                    title(context),
                    // Education Article -------------------------------------------------
                    FutureBuilder<QuerySnapshot>(
                      future: fetchedData,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('500 - error'));
                        } else if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          /**
                       *  개행 문자를 포함해서 return 하기 
                       */
                          List<String> contentArray = snapshot.data.docs[0]
                              .data()['content']
                              .toString()
                              .split('<br>');
                          String content() {
                            StringBuffer sb = new StringBuffer();
                            for (String item in contentArray) {
                              sb.write(item + '\n\n');
                            }
                            return sb.toString();
                          }

                          return Article(
                              backgroundColor: themeBlue,
                              //title: snapshot.data.docs[0].data()['title'],
                              content: content());
                        }
                      },
                    ),
                    // Footer   ----------------------------------------------------------
                    Footer()
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
            'Education',
            style: h1TextStyle,
          ),
        ),
        SizedBox(height: 100),
      ],
    ),
  );
}
