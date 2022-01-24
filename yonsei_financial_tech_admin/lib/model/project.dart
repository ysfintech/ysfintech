import 'package:json_annotation/json_annotation.dart';


part 'project.g.dart';

@JsonSerializable()
class Project {
  final String content;
  final String from;
  final int id;
  final String imageDesc;
  final String imagePath;
  final String period;
  final String title;

  Project({
    required this.content,
    required this.from,
    required this.id,
    required this.imageDesc,
    required this.imagePath,
    required this.period,
    required this.title,
  });

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

}



// class Board {
//   final int id;
//   final String content;
//   // final String date;
//   final DateTime date;
//   final String title;
//   final int view;
//   final String writer;
//   final String imagePath;

//   Board(
//       {this.id,
//       this.content,
//       this.date,
//       this.title,
//       this.view,
//       this.writer,
//       this.imagePath});

//   factory Board.from(QueryDocumentSnapshot snapshot) {
//     Timestamp timestamp = snapshot.data()['date'];
//     DateTime dateTime = timestamp.toDate();
//     return Board(
//         id: snapshot.data()['id'],
//         content: snapshot.data()['content'],
//         date: dateTime,
//         title: snapshot.data()['title'],
//         view: snapshot.data()['view'],
//         writer: snapshot.data()['writer'],
//         imagePath: snapshot.data()['imagePath']);
//   }
// }

// class BoardCollection {
//   final List<Board> list;

//   BoardCollection({this.list});

//   factory BoardCollection.from(List<QueryDocumentSnapshot> snapshot) {
//     List<Board> _list = snapshot.map((e) => Board.from(e)).toList();
//     return BoardCollection(list: _list);
//   }
// }
