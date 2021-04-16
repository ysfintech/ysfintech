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
  final String content;
  final String date;
  final int id;
  final String title;
  final int view;
  final String writer;

  Board({this.content, this.date, this.id, this.title, this.view, this.writer});

  factory Board.from(QueryDocumentSnapshot snapshot) {
    return Board(
        content: snapshot.data()['content'],
        date: snapshot.data()['date'],
        id: snapshot.data()['id'],
        title: snapshot.data()['title'],
        view: snapshot.data()['view'],
        writer: snapshot.data()['writer']);
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
