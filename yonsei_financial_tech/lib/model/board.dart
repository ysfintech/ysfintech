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
  final ItemContent content;

  BoardItem({this.content, this.date, this.number, this.title, this.views, this.writer});

   

}

class ItemContent {
  final String title;
  final String path;

  ItemContent({this.path, this.title});
}