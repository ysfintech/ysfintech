import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

/// custom code
import 'package:ysfintech_admin/model/introduction.dart';
import 'package:ysfintech_admin/utils/firebase.dart';
import 'package:ysfintech_admin/utils/spacing.dart';

class IntroEduController extends GetxController {
  /// map is need for updating and removing the document from the colletion
  Rx<List<Intro>> introList = Rx<List<Intro>>([]);

  /// key - intro's id
  /// value - FireStore document id
  Rx<Map<int, String>> introDocIDMap = Rx<Map<int, String>>({});

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

  void removeIntro(String docID, int id) async {
    bool userResponse = false;
    await Get.defaultDialog(
      title: '삭제하기',
      middleText: '해당 Introduction을 삭제하시겠어요?',
      textCancel: '취소',
      textConfirm: '삭제',
      confirmTextColor: Colors.white,
      onConfirm: () {
        userResponse = true;
        Get.back();
      },
    );
    if (userResponse) {
      final res = await FireStoreDB.removeIntro(docID, id);
      if (res) {
        Get.snackbar(
          'Introduction 삭제',
          '성공적으로 삭제 됐습니다!',
          snackPosition: SnackPosition.BOTTOM,
          margin: marginH40V40,
        );
      } else {
        Get.snackbar(
          'Introduction 삭제',
          '삭제하지 못했어요..!',
          snackPosition: SnackPosition.BOTTOM,
          margin: marginH40V40,
        );
      }
    }
  }
}

class IntroEditController extends GetxController {
  /// for CircularProgressingIndicator in Presentation Layer
  RxBool isLoading = false.obs;

  /// to use this method with 2 different state
  /// First, updating the existing data in the FireStore
  /// Second, adding new data into FireStore and Storage as well
  RxBool isNewData = false.obs;

  /// for TextFormFields and validators
  final introKey = GlobalKey<FormFieldState>();

  final introContentCtlr = TextEditingController();
  final introNameCtlr = TextEditingController();
  final introRoleCtlr = TextEditingController();
  final introTitleCtlr = TextEditingController();

  /// for values that needs to be observable
  RxInt introID = 0.obs;
  RxString docID = ''.obs;
  Rx<Uint8List> imageFile = Uint8List(0).obs;
  RxString imagePath = ''.obs;

  @override
  void onClose() {
    // TODO: TextEditingController needs to be disposed?
    super.onClose();
  }

  void initTextControllers(
    bool isNew,
    String passedDocID,
    Intro intro,
  ) async {
    isNewData.value = isNew;

    /// form data
    introContentCtlr.text = intro.content;
    introNameCtlr.text = intro.name;
    introRoleCtlr.text = intro.role;
    introTitleCtlr.text = intro.title;
    introID.value = intro.id;

    /// observable data
    docID.value = passedDocID;
    if (intro.imagePath != '') {
      final downloadURL = await FireStoreDB.getDownloadURL(
          'gs://ysfintech-homepage.appspot.com/introduction/${intro.id}.jpg');
      if (downloadURL != '') imagePath.value = downloadURL;
    } else {
      imagePath.value = '';
    }
    update();
  }

  /// select image file from PC
  void selectFile() async {
    final Uint8List picked = await ImagePickerWeb.getImage(
      outputType: ImageType.bytes,
    );
    if (picked.isNotEmpty) {
      imageFile.value = picked;
      update();
    }
  }

  void updateIntro() async {
    /// send loading is `true`
    isLoading.value = true;
    update();

    final hasImage = imageFile.value.isNotEmpty;
    final data = Intro(
      content: introContentCtlr.text,
      id: introID.value,
      imagePath: imagePath.value, // will be updated at next procedure
      name: introNameCtlr.text,
      role: introRoleCtlr.text,
      title: introTitleCtlr.text,
    );
    late final result;

    /// update procedure
    if (!isNewData.value) {
      if (hasImage) {
        result =
            await FireStoreDB.updateIntro(docID.value, data, imageFile.value);
      } else {
        result = await FireStoreDB.updateIntroWithoutImage(docID.value, data);
      }
    } else {
      result = await FireStoreDB.addNewIntro(data, imageFile.value);
    }

    /// after all procedures
    isLoading.value = false;
    update();

    if (result) {
      Get.back();
      Get.snackbar(
        'Introduction 수정',
        '성공적으로 업데이트 했습니다!',
        snackPosition: SnackPosition.BOTTOM,
        margin: marginH40V40,
      );
    } else {
      Get.snackbar(
        'Introduction 수정',
        '업데이트 실패 🤯',
        snackPosition: SnackPosition.BOTTOM,
        margin: marginH40V40,
      );
    }
  }
}
