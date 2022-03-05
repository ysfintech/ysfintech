import 'package:cloud_firestore/cloud_firestore.dart';

class Board {
  final List<BoardItem> list;

  Board({
    required this.list,
  });

  factory Board.fromJson(List<Map<String, dynamic>> json) {
    List<BoardItem> boardList =
        json.map((element) => BoardItem.fromJson(element)).toList();

    return Board(list: boardList);
  }
}

class BoardItem {
  final int number;
  final String title;
  final String writer;
  final DateTime date;
  final int view;
  final String content;
  final String? imagePath;

  BoardItem({
    required this.content,
    required this.date,
    required this.number,
    required this.title,
    required this.view,
    required this.writer,
    this.imagePath,
  });

  factory BoardItem.fromJson(Map<String, dynamic> json) {
    Timestamp _timeStamp = json['date'];
    DateTime _dateTime = _timeStamp.toDate();
    return BoardItem(
        number: json['id'],
        title: json['title'],
        writer: json['writer'],
        date: _dateTime,
        view: json['view'],
        content: json['content'],
        imagePath: json['imagePath']);
  }
}
