// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/utils/firebase.dart';
import 'package:ysfintech_admin/widgets/common.dart';

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
  late Stream<Map<String, dynamic>> mapperStream;

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
    final html.File picked = await ImagePickerWeb.getImage(
      outputType: ImageType.file,
    );
    if (picked.size > 0) {
      binaryFile.value = picked;
      update();
    }
  }
}
