import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ysfintech_admin/controllers/board_controller.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/screens/paper_edit.dart';
import 'package:ysfintech_admin/utils/firebase.dart';
import 'package:ysfintech_admin/widgets/common.dart';

const collectionName = 'paper';

class PaperController extends BoardController {
  /// constructor
  PaperController() : super(collectionName) {
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
      Get.bottomSheet(
        PaperBottomSheet(docNumericId: index),
        ignoreSafeArea: true,
      );
    } else {
      // TODO: implement existing edit screen
      Get.bottomSheet(
        PaperBottomSheet(
          board: fetchedBoards[index],
          docId: mapper[fetchedBoards[index].id],
          docNumericId: fetchedBoards[index].id,
        ),
        ignoreSafeArea: true,
      );
    }
  }
}

class PaperEditController extends GetxController with BoardEditMixinController {
  late final FireStoreDB fireStore;
  PaperEditController() {
    fireStore = FireStoreDB();
  }

  /// needs [content], [date], [id], [title], [view], [writer], [file]
  /// file needs to be in `Blob`
  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  /// observable data
  Rx<int> docNumericId = Rx<int>(-1);
  Rx<String?> docId = Rx<String?>(null);
  Rx<String?> downloadableURL = Rx<String?>(null);

  Uint8List? get selectedFileBytes => super.fileBytes.value;
  String? get selectedFileName => super.fileName.value;

  @override
  void onInit() {
    contentController.text = '';
    titleController.text = '';
    super.onInit();
  }

  void init(Board? data, String? id, int docIdx) async {
    // reset selected file information
    super.fileBytes.value = null;
    super.fileName.value = null;

    docId.value = id;
    docNumericId.value = docIdx;

    if (data != null) {
      selectedBoard.value = Board.clone(data);
      contentController.text = data.content;
      titleController.text = data.title;

      if (data.imagePath != null) {
        final downloadURL = await FireStoreDB.getDownloadURL(data.imagePath!);
        downloadableURL.value = downloadURL;
      }
    } else {
      selectedBoard.value = null;
      contentController.text = '';
      titleController.text = '';
      downloadableURL.value = null;
    }
    update();
  }

  // TODO: implementation of BoardController Mixin or
  /// add abstract class to make [save], [delete], [init]
  void save() async {
    final Board updatedBoard = Board(
      id: docNumericId.value,
      content: contentController.text,
      date: DateTime.now(),
      title: titleController.text,
      view: selectedBoard.value?.view ?? 0,
      writer: selectedBoard.value?.writer ?? '관리자',
      imagePath: selectedBoard.value?.imagePath,
    );

    late final uploadResult;

    if (docId.value != null) {
      // update
      uploadResult = await fireStore.updateBoard(
        collectionName: collectionName,
        docId: docId.value!,
        board: updatedBoard,
        fileBytes: fileBytes.value,
        fileName: fileName.value,
      );
    } else {
      // add
      uploadResult = await fireStore.addNewBoard(
        collectionName: collectionName,
        newBoard: updatedBoard,
        fileBytes: fileBytes.value,
        fileName: fileName.value,
      );
    }
    // get back - pop modal
    Get.back();
    bottomSnackBar(
      'Working Papers',
      uploadResult ? '저장되었어요 :)' : '오류가 발생했어요 :(',
    );
  }

  void delete() async {
    if (docId.value != null && selectedBoard.value != null) {
      final result = await fireStore.removeBoard(
        collectionName: collectionName,
        docId: docId.value!,
        imagePath: selectedBoard.value!.imagePath,
      );
      // pop
      Get.back();
      bottomSnackBar(
        'Working Papers',
        result ? '삭제되었어요 :)' : '오류가 발생했어요 :(',
      );
    }
  }
}
