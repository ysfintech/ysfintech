import 'package:get/get.dart';

import 'package:ysfintech_admin/controllers/collaboration_controller.dart';
import 'package:ysfintech_admin/controllers/paper_controller.dart';

class CollaborationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollaborationController());
  }
}

class PaperBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaperController());
  }
}
