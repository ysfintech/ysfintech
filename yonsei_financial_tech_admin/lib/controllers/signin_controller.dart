import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/widgets/common.dart';

/// auth controller
import 'auth_controller.dart';

class SignInController extends GetxController {
  final signInFormKey = GlobalKey<FormState>();

  /// used for sign-in to Firebase
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    emailController.text = '';
    passwordController.text = '';
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: reason why dispose is making issue "textEditingController is being used after disposed"
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  bool emailValidator(String inputEmail) {
    if (inputEmail.isEmpty) return false;
    if (inputEmail.isEmail) return true;
    return false;
  }

  void signIn() {
    if (signInFormKey.currentState != null &&
        signInFormKey.currentState!.validate()) {
      /// use AuthController for sign-in
      AuthController.instance.signInWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } else {
      CommonWidget.bottomSnackBar(
        '오류',
        '다시 시도해주세요',
      );
    }
  }
}
