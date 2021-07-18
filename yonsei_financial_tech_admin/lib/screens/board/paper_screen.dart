import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/screens/board/paper_detail.dart';
import 'package:ysfintech_admin/screens/project/project_detail.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:ysfintech_admin/widgets/post.dart';

class PaperScreen extends StatefulWidget {
  @override
  _PaperScreenState createState() => _PaperScreenState();
}

class _PaperScreenState extends State<PaperScreen> {
  // firebase firestore
  CollectionReference paper = FirebaseFirestore.instance.collection('paper');

  // data fetched
  Future<QuerySnapshot> paperData;

  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    paperData = paper.orderBy('id').get();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: paperData,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error - 500'));
        } else if (!snapshot.hasData) {
          return Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()));
        } else {
          // data
          BoardCollection boardData =
              BoardCollection.from(snapshot.data.docs.toList());
          List<Board> list = boardData.list;
          
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
                                    Text('Post new Paper',
                                        style: bodyWhiteTextStyle)
                                  ],
                                )),
                            onPressed: () => showBottomSheet(context: context, builder: (context) => Post(id: list.length + 1, collection: 'paper',)),
                          ))),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                    controller: _controller,
                    itemCount: list.length,
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemBuilder: (context, index) => ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tileColor: Colors.white,
                      onTap: () => showBottomSheet(context: context,
                        builder: (context) => BoardDetail(
                          data: list[index], pathID: snapshot.data.docs[index].id,
                        ),                      
                      ),
                      contentPadding: paddingH20V20,
                      leading: Column(
                        children: <Widget>[
                          Icon(Icons.tag),
                          SizedBox(
                            width: 5,
                          ),
                          Text((index + 1).toString())
                        ],
                      ),
                      title: Text(
                        list[index].title,
                        style: h3TextStyle,
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '작성일자 ' + list[index].date,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '조회수 ' + list[index].view.toString(),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '작성자 ' + list[index].writer,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        }
      },
    );
  }
}
