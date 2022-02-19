import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/utils/firebase.dart';

/// `BoardController` gonna be the parent class of the other classes
class BoardController extends GetxController {
  /// find the instance
  static BoardController get to => Get.find<BoardController>();

  late final FireStoreDB firestore;
  final String collection;

  BoardController(this.collection) {
    firestore = new FireStoreDB();
  }

  late Stream<List<Board>> boardStream;
  late Stream<Map<int, String>> mapperStream;

  @override
  onInit() {
    print('BoardController onInit');
    final fetchedItems = firestore.getItemsOfBoard(collection);
    boardStream = fetchedItems.map((e) => e.first as List<Board>).cast();
    mapperStream = fetchedItems.map((e) => e.last as Map<int, String>).cast();
    super.onInit();
  }
}

mixin BoardEditMixinController on GetxController {
  /// used for image/file upload
  /// can be null cause of [Collaboration]
  Rx<Uint8List?> fileBytes = Rx<Uint8List?>(null);
  Rx<String?> fileName = Rx<String?>(null);
  Rx<Board?> selectedBoard = Rx<Board?>(null);

  void selectFile() async {
    final picked = await FilePicker.platform.pickFiles();

    if (picked != null) {
      fileBytes.value = picked.files.first.bytes;
      fileName.value = picked.files.first.name;
      update();
    }
  }
}
