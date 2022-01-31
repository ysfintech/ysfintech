import 'package:cloud_firestore/cloud_firestore.dart';

class Board {
  final int id;
  final String content;
  final DateTime date;
  final String title;
  final int view;
  final String writer;
  final String? imagePath;

  Board({
    required this.id,
    required this.content,
    required this.date,
    required this.title,
    required this.view,
    required this.writer,
    this.imagePath,
  });

  factory Board.fromJson(QueryDocumentSnapshot snapshot) {
    final Timestamp timestamp = snapshot.data()['date'];
    final DateTime dateTime = timestamp.toDate();

    return Board(
        id: snapshot.data()['id'],
        content: snapshot.data()['content'],
        date: dateTime,
        title: snapshot.data()['title'],
        view: snapshot.data()['view'],
        writer: snapshot.data()['writer'],
        imagePath: snapshot.data()['imagePath']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "date": Timestamp.fromDate(date),
        "title": title,
        "view": view,
        "writer": writer,
        "imagePath": imagePath
      };
}
