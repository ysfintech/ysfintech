class Board {
  final List<BoardItem> list;

  Board({this.list});
}

class BoardItem {
  final int number;
  final String title;
  final String writer;
  final String date;
  final int views;
  final String contentPath;

  BoardItem({this.contentPath, this.date, this.number, this.title, this.views, this.writer});

}