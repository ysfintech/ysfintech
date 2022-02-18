import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ysfintech_admin/model/project.dart';
import 'package:ysfintech_admin/utils/firebase.dart';
import 'package:ysfintech_admin/widgets/common.dart';

class ProjectController extends GetxController {
  late final fireStore;
  ProjectController() {
    fireStore = FireStoreDB();
  }

  /// to list the uploaded projects
  Rx<List<Project>> projectList = Rx<List<Project>>([]);
  Rx<Map<int, String>> docIDMap = Rx<Map<int, String>>({});

  /// getter
  List<Project> get projects => projectList.value;
  Map<int, String> get docIDs => docIDMap.value;

  /// LIFE-CYCLE
  @override
  void onInit() {
    /// load projects with using stream
    final Stream<List<dynamic>> fetched = fireStore.getProjectStream();
    Stream<List<Project>> projStream = fetched.map((event) => event.first);
    Stream<Map<int, String>> mapperStream = fetched.map((event) => event.last);
    projectList.bindStream(projStream);
    docIDMap.bindStream(mapperStream);
    super.onInit();
  }

  /// methods

}

class ProjectEditController extends GetxController {
  late final fireStore;
  ProjectEditController() {
    fireStore = FireStoreDB();
  }

  static const String notFoundURL =
      'https://cdn.pixabay.com/photo/2022/01/17/22/20/subtract-6945896_960_720.png';

  /// textEditController
  final contentController = TextEditingController();
  final organController = TextEditingController();
  final imageDescController = TextEditingController();
  final titleController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();

  /// image
  Rx<Uint8List?> binaryImage = Uint8List.fromList([]).obs;
  Rx<String> imagePath = ''.obs;

  /// docID
  Rx<dynamic> docID = Rx<dynamic>(null);
  Rx<int?> projectID = Rx<int?>(null);

  @override
  void onInit() {
    /// init textEditingController
    contentController.text = '';
    organController.text = '';
    imageDescController.text = '';
    titleController.text = '';
    fromController.text = '';
    toController.text = '';
    super.onInit();
  }

  /// on `Navigator.pop`, the data need to be reset
  void onReset() {
    contentController.text = '';
    organController.text = '';
    imageDescController.text = '';
    titleController.text = '';
    fromController.text = '';
    toController.text = '';
    binaryImage.value = Uint8List.fromList([]);
    imagePath.value = notFoundURL;
    docID.value = null;
    update();
  }

  /// get current context's form data via `ProjectEditController`
  Project getObjectForUpload() => Project(
      content: contentController.text.trim(),
      from: organController.text.trim(),
      imageDesc: imageDescController.text.trim(),
      title: titleController.text.trim(),
      period: fromController.text.trim() + ' – ' + toController.text.trim(),
      id: projectID.value ?? docID.value,
      imagePath: '');

  /// for receiving data from previous page
  void getInfoFrom(dynamic passedDocID, Project? data) {
    docID.value = passedDocID;

    /// project data
    if (data != null) {
      final periods = data.period.split(" – ");

      /// controllers
      contentController.text = data.content;
      organController.text = data.from;
      imageDescController.text = data.imageDesc;
      titleController.text = data.title;
      fromController.text = periods.first;
      toController.text = periods.last;

      /// variable
      projectID.value = data.id;

      /// image
      FireStoreDB.getDownloadURL(data.imagePath)
          .then((value) => imagePath.value = value);
    } else {
      imagePath.value = notFoundURL;
    }
    update();
  }

  /// upload new image file
  void uploadNewImage() async {
    final Uint8List? selected = await ImagePickerWeb.getImageAsBytes();

    /// check if the image file is not empty
    if (selected != null) {
      binaryImage.value = selected;
      update();
    }
  }

  /// save to FireStore
  void save() async {
    final updatedProject = getObjectForUpload();

    bool uploadResult = false;

    /// check if the written data is for update or add
    if (docID.value is String) {
      /// update exisiting data
      /// check if the new image file has been upload via `binaryImage`
      if (binaryImage.value != null) {
        /// update without image
        uploadResult = await fireStore.updateProjectWithoutImage(
          docID.value,
          updatedProject,
        );
      } else {
        /// update with new image
        uploadResult = await fireStore.updateProject(
          docID.value,
          updatedProject,
          binaryImage.value,
        );
      }
      // FireStoreDB.updateProject()
    } else if (docID.value is int) {
      /// add new data
      uploadResult = await fireStore.addNewProject(
          Project.cloneWithNewID(updatedProject, docID.value),
          binaryImage.value);
    }

    /// response to user with result
    if (uploadResult) {
      Get.back(); // pop then show result
      bottomSnackBar(
        'Project 게시글',
        '성공적으로 업로드 되었어요!',
      );
    } else {
      bottomSnackBar(
        'Project 게시글',
        '업로드 실패했어요 :(',
      );
    }
  }

  void removeProject(int id) async {
    bool userResponse = false;
    await Get.defaultDialog(
      title: '삭제하기',
      middleText: '해당 Project를 삭제하시겠어요?',
      textCancel: '취소',
      textConfirm: '삭제',
      confirmTextColor: Colors.white,
      onConfirm: () {
        userResponse = true;
        Get.back();
      },
    );

    if (userResponse) {
      print("${docID.value}  $id");
      final result = await fireStore.removeProject(docID.value, id);

      /// close the bottom sheet first
      Get.back();

      /// check the result
      if (result) {
        bottomSnackBar(
          'Project 게시글',
          '성공적으로 삭제 되었어요!',
        );
      } else {
        bottomSnackBar(
          'Project 게시글',
          '삭제하지 못했어요 :(',
        );
      }
    }
  }
}
