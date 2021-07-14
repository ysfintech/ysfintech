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
  final String content;
  final String imagePath;

  BoardItem(
      {this.content,
      this.date,
      this.number,
      this.title,
      this.view,
      this.writer,
      this.imagePath});

  factory BoardItem.fromJson(Map<String, dynamic> json) {
    return BoardItem(
        number: json['number'],
        title: json['title'],
        writer: json['writer'],
        date: json['date'],
        view: json['view'],
        content: json['content'],
        imagePath: json['imagePath']
        );
  }
}

class Works {
  final List<WorkItem> list;

  Works({this.list});

  factory Works.fromJson(List<Map<String, dynamic>> json) {
    List<WorkItem> boardList =
        json.map((element) => WorkItem.fromJson(element)).toList();

    return Works(list: boardList);
  }
}

class WorkItem {
  final int number;
  final String title;
  final String writer;
  final String date;
  final int view;
  final String content;

  WorkItem(
      {this.content,
      this.date,
      this.number,
      this.title,
      this.view,
      this.writer});

  factory WorkItem.fromJson(Map<String, dynamic> json) {
    return WorkItem(
        number: json['number'],
        title: json['title'],
        writer: json['writer'],
        date: json['date'],
        view: json['view'],
        content: json['content']
        );
  }
}
