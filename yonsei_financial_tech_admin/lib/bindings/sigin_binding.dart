import 'package:get/get.dart';
/// controller
import 'package:ysfintech_admin/controllers/signin_controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
