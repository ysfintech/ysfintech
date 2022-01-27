import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/project_controller.dart';


class ProjectBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectController());
  }
}
