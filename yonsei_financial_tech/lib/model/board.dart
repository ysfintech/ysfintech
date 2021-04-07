class Board {
  final List<BoardItem> list;

  Board({this.list});

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
  final String date;
  final int view;
  final String contentPath;

  BoardItem(
      {this.contentPath,
      this.date,
      this.number,
      this.title,
      this.view,
      this.writer});

  factory BoardItem.fromJson(Map<String, dynamic> json) {
    return BoardItem(
        number: json['number'],
        title: json['title'],
        writer: json['writer'],
        date: json['date'],
        view: json['view'],
        contentPath: json['contentPath']);
  }
}
