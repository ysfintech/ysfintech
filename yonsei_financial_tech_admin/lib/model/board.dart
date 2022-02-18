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
    final Timestamp timestamp = snapshot.get('date');
    final DateTime dateTime = timestamp.toDate();

    final Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;

    return Board(
      id: snapshot.get('id'),
      content: json['content'],
      date: dateTime,
      title: json['title'],
      view: json['view'],
      writer: json['writer'],
      imagePath: json['imagePath'],
    );
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

  factory Board.clone(Board board) => Board(
        id: board.id,
        content: board.content,
        date: board.date,
        title: board.title,
        imagePath: board.imagePath,
        view: board.view,
        writer: board.writer,
      );

  factory Board.cloneWith(Board board, String newPath) => Board(
        id: board.id,
        content: board.content,
        date: board.date,
        title: board.title,
        imagePath: newPath,
        view: board.view,
        writer: board.writer,
      );
}
