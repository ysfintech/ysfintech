import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

/// custom code
import 'package:ysfintech_admin/model/introduction.dart';
import 'package:ysfintech_admin/utils/firebase.dart';

class IntroEduController extends GetxController {
  /// map is need for updating and removing the document from the colletion
  Rx<List<Intro>> introList = Rx<List<Intro>>([]);

  /// key - intro's id
  /// value - FireStore document id
  Rx<Map<int, String>> introDocIDMap = Rx<Map<int, String>>({});

  late RxString eduContent;

  @override
  void onInit() {
    final fetched = FireStoreDB.getIntroStream();
    introList
        .bindStream(fetched.map((event) => event.first as List<Intro>).cast());
    introDocIDMap.bindStream(
        fetched.map((event) => event.last as Map<int, String>).cast());
    super.onInit();
  }

  List<Intro> get intros => introList.value;
  Map<int, String> get docIDs => introDocIDMap.value;

  void editIntroContent(Intro data) {}
}

class IntroEditController extends GetxController {
  final introKey = GlobalKey<FormFieldState>();

  final introContentCtlr = TextEditingController();
  final introNameCtlr = TextEditingController();
  final introRoleCtlr = TextEditingController();
  final introTitleCtlr = TextEditingController();

  Rx<Uint8List> imageFile = Uint8List(0).obs;

  var imagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void initTextControllers(Intro intro) async {
    introContentCtlr.text = intro.content;
    introNameCtlr.text = intro.name;
    introRoleCtlr.text = intro.role;
    introTitleCtlr.text = intro.title;
    final downloadURL = await FireStoreDB.getDownloadURL(
        'gs://ysfintech-homepage.appspot.com/introduction/${intro.id}.jpg');
    if (downloadURL != '') imagePath.value = downloadURL;
    update();
  }

  /// select image file from PC
  void selectFile() async {
    final Uint8List picked =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);
    if (picked.isNotEmpty) {
      imageFile.value = picked;
      update();
    }
  }
}
