import 'package:get/get.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/utils/firebase.dart';

/// `BoardController` gonna be the parent class of the other classes
class BoardController extends GetxController {
  final String collection;

  BoardController(this.collection);

  Rx<List<Board>> boardList = Rx<List<Board>>([]);
  Rx<Map<int, String>> boardMapper = Rx<Map<int, String>>({});

  List<Board> get boards => boardList.value;
  Map<int, String> get mapper => boardMapper.value;

  @override
  void onInit() {
    final fetchedItems = FireStoreDB.getItemsOfBoard(collection);
    boardList
        .bindStream(fetchedItems.map((e) => e.first as List<Board>).cast());
    boardMapper
        .bindStream(fetchedItems.map((e) => e.last as Map<int, String>).cast());
    update();
    super.onInit();
  }
}
