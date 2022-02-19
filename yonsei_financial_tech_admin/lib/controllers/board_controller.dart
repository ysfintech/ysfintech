// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  Rx<html.File?> binaryFile = null.obs;
  Rx<Board?> selectedBoard = Rx<Board?>(null);

  void selectFile() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      binaryFile.value = File(picked.path) as html.File?;
      update();
    }
  }
}
