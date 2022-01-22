import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/intro_edu_controller.dart';


class IntroEduBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntroEduController());
  }
}
