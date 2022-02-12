import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/screens/collaboration_edit.dart';
import 'package:ysfintech_admin/utils/firebase.dart';
import 'package:ysfintech_admin/widgets/common.dart';

import 'board_controller.dart';

const String collectionName = 'work';

class CollaborationController extends BoardController {
  CollaborationController() : super(collectionName) {
    /// for editing
    Get.lazyPut(() => CollaborationEditController());
  }

  /// for search bar
  TextEditingController searchController = TextEditingController();
  Rx<ScrollController> scrollController = ScrollController().obs;

  /// variables
  Rx<List<Board>> parsedBoards = Rx<List<Board>>([]);

  @override
  List<Board> get boards => parsedBoards.value;

  List<Board> get parentBoards => super.boards;

  @override
  void onReady() {
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
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.value.dispose();
    searchController.dispose();
    super.onClose();
  }

  /// for bottom sheet
  void openBottomSheet(
    final int index,
  ) {
    Get.bottomSheet(
      index > parentBoards.length
          ? CollaborationBottomSheet(
              docNumericID: index,
            )
          : CollaborationBottomSheet(
              board: super.boards[index],
              docID: super.mapper[boards[index].id],
              docNumericID: super.boards[index].id,
            ),
    );
  }
}

class CollaborationEditController extends GetxController
    with BoardEditMixinController {
  late final FireStoreDB fireStore;
  CollaborationEditController() {
    fireStore = FireStoreDB();
  }

  /// needs [content], [date], [id], [title], [view], [writer]
  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  Rx<int> indexOfDocument = Rx<int>(-1);
  Rx<String?> docID = Rx<String?>(null);

  @override
  void onInit() {
    contentController.text = '';
    titleController.text = '';
    super.onInit();
  }

  /// take input data as initializer
  void init(Board? data, String? id, int docIdx) {
    print(data);
    selectedBoard.value = data != null ? Board.clone(data) : null;

    /// not related to `Board` Object
    docID.value = id;
    indexOfDocument.value = docIdx;

    if (data != null) {
      // existing document
      contentController.text = data.content;
      titleController.text = data.title;
    } else {
      // new document
      // ...
    }
    update();
  }

  /// save document
  /// send [imagePath] to null
  void save() async {
    /// create new data
    final Board newData = Board(
      id: indexOfDocument.value,
      content: contentController.text.trim(),
      date: DateTime.now(),
      title: titleController.text.trim(),
      view: selectedBoard.value?.view ?? 0,
      writer: selectedBoard.value?.writer ?? '관리자',
      imagePath: selectedBoard.value?.imagePath,
    );

    /// existing data - update
    if (docID.value != null) {
      // update
    } else {
      // add
      final uploadResult = await fireStore.addNewBoard(
        collectionName,
        newData,
        null,
      );
      Get.back();
      bottomSnackBar(
        'Collaboration',
        uploadResult ? '새롭게 추가되었어요 :)' : '오류가 발생했어요 :(',
      );
    }
  }

  /// this method is not shown in new data form
  void delete() async {
    if (docID.value != null) {
      final result =
          await fireStore.removeBoard(collectionName, docID.value!, null);
      Get.back();
      bottomSnackBar(
        'Collaboration',
        result ? '성공적으로 삭제되었어요 :)' : '오류가 발생했어요 :(',
      );
    }
  }
}
