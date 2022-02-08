import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/model/board.dart';

import 'board_controller.dart';

class CollaborationController extends BoardController {
  static const String collectionName = 'work';

  CollaborationController() : super(collectionName) {
    Get.put(() => BoardController(collectionName));
  }

  /// for search bar
  TextEditingController searchController = TextEditingController();
  Rx<ScrollController> scrollController = ScrollController().obs;

  /// variables
  Rx<List<Board>> parsedBoards = Rx<List<Board>>([]);

  @override
  List<Board> get boards => parsedBoards.value;

  @override
  void onInit() {
    /// super first for fetching the data
    super.onInit();
    print('onInit : ${boards.length} vs ${super.boardList.value.length}');
    update();

    /// then add events to Controller
    searchController.text = '';

    /// update existing list
    parsedBoards.value = List.from(super.boardList.value);

    // add listener to controller
    searchController.addListener(() {
      var title = searchController.text.trim();

      if (title.isNotEmpty) {
        List<Board> tempList = [];
        for (int i = 0; i < super.boardList.value.length; ++i) {
          final Board bd = super.boardList.value[i];
          if (bd.title.contains(title)) {
            tempList.add(bd);
          }
        }
        parsedBoards.value = tempList;
      } else {
        parsedBoards.value = super.boardList.value;
      }
      update();
      print('update : ${boards.length} vs ${super.boardList.value.length}');
    });
  }

  @override
  void onClose() {
    scrollController.value.dispose();
    searchController.dispose();
    super.onClose();
  }
}
