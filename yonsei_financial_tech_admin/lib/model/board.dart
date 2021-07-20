import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String content;
  final String from;
  final int id;
  final String imageDesc;
  final String imagePath;
  final String period;
  final String title;

  Project(
      {this.content,
      this.from,
      this.id,
      this.imageDesc,
      this.imagePath,
      this.period,
      this.title});
}

class Board {
  final int id;
  final String content;
  // final String date;
  final DateTime date;
  final String title;
  final int view;
  final String writer;
  final String imagePath;

  Board(
      {this.id,
      this.content,
      this.date,
      this.title,
      this.view,
      this.writer,
      this.imagePath});

  factory Board.from(QueryDocumentSnapshot snapshot) {
    Timestamp timestamp = snapshot.data()['date'];
    DateTime dateTime = timestamp.toDate();
    return Board(
        id: snapshot.data()['id'],
        content: snapshot.data()['content'],
        date: dateTime,
        title: snapshot.data()['title'],
        view: snapshot.data()['view'],
        writer: snapshot.data()['writer'],
        imagePath: snapshot.data()['imagePath']);
  }
}

class BoardCollection {
  final List<Board> list;

  BoardCollection({this.list});

  factory BoardCollection.from(List<QueryDocumentSnapshot> snapshot) {
    List<Board> _list = snapshot.map((e) => Board.from(e)).toList();
    return BoardCollection(list: _list);
  }
}
