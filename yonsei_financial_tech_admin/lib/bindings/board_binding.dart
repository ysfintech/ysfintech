import 'package:get/get.dart';

import 'package:ysfintech_admin/controllers/collaboration_controller.dart';
import 'package:ysfintech_admin/controllers/board_with_file_controller.dart';

class CollaborationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollaborationController());
  }
}

class PaperBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BoardWithFileController('paper'));
  }
}

class SeminarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BoardWithFileController('seminar'));
  }
}

class ConferenceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BoardWithFileController('conference'));
  }
}
