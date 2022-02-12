import 'dart:html' as html;

import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/utils/firebase.dart';

/// `BoardController` gonna be the parent class of the other classes
class BoardController extends GetxController {
  late final FireStoreDB firestore;
  final String collection;

  BoardController(this.collection) {
    firestore = new FireStoreDB();
    /// data fetch - use in view layer
    Get.put(() => BoardController(collection));
  }

  Rx<List<Board>> boardList = Rx<List<Board>>([]);
  Rx<Map<int, String>> boardMapper = Rx<Map<int, String>>({});

  List<Board> get boards => boardList.value;
  Map<int, String> get mapper => boardMapper.value;

  @override
  Future<void> onInit() async {
    final fetchedItems = firestore.getItemsOfBoard(collection);
    boardList
        .bindStream(fetchedItems.map((e) => e.first as List<Board>).cast());
    boardMapper
        .bindStream(fetchedItems.map((e) => e.last as Map<int, String>).cast());
    super.onInit();
  }
}

mixin BoardEditMixinController on GetxController {
  /// used for image/file upload
  /// can be null cause of [Collaboration]
  Rx<html.File?> binaryFile = null.obs;
  Rx<Board?> selectedBoard = Rx<Board?>(null);

  void selectFile() async {
    final html.File picked = await ImagePickerWeb.getImage(
      outputType: ImageType.file,
    );
    if (picked.size > 0) {
      binaryFile.value = picked;
      update();
    }
  }
}
