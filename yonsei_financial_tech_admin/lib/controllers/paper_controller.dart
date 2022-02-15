import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/board_controller.dart';
import 'package:ysfintech_admin/model/board.dart';

class PaperController extends BoardController {
  /// constructor
  PaperController(String collection) : super(collection) {
    Get.lazyPut(() => PaperEditController());
  }

  /// search bar
  TextEditingController searchController = TextEditingController();
  Rx<ScrollController> scrollController = ScrollController().obs;

  /// variables
  /// fetched from stream
  Rx<List<Board>> fetchedBoardList = Rx<List<Board>>([]);
  Rx<List<Board>> originBoardList = Rx<List<Board>>([]);
  Rx<Map<int, String>> fetchedMapper = Rx<Map<int, String>>({});

  /// only [fetchedBoards] is `mutable`
  List<Board> get fetchedBoards => fetchedBoardList.value;

  /// [originBoards] and [mapper] are `immutable`
  List<Board> get originBoards => originBoardList.value;
  Map<int, String> get mapper => fetchedMapper.value;

  @override
  void onReady() {
    // init textEditingController
    searchController.text = '';
    // bind stream from parent class
    originBoardList.bindStream(super.boardStream);
    fetchedMapper.bindStream(super.mapperStream);

    /// copy [originBoardList] to [fetchedBoardList] for init
    // fetchedBoardList.value = List.from(originBoards);

    /// add listener to [searchController]
    searchController.addListener(() {
      final input = searchController.text.trim();
      if (input.length > 0) {
        // add into temp list
        List<Board> tempList = [];
        for (Board board in originBoards) {
          if (board.title.contains(input)) tempList.add(board);
        }
        fetchedBoardList.value = List.from(tempList);
      } else {
        fetchedBoardList.value = List.from(originBoards);
      }
      // update
      update();
    });

    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.close();
    super.onClose();
  }

  /// if the incoming index is greater than [originBoards.length]
  /// that would be new `Board`
  void openBottomSheet(int index) {
    if (index > originBoards.length) {
      // TODO: implement new edit screen
    } else {
      // TODO: implement existing edit screen
    }
  }
}

class PaperEditController extends GetxController {}
