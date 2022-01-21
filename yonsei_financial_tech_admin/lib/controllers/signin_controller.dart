import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// auth controller
import 'auth_controller.dart';

class SignInController extends GetxController {
  final signInFormKey = GlobalKey<FormState>();

  /// used for sign-in to Firebase
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    /// sth to init
    emailController.text = 'example@gmail.com';
    super.onInit();
  }

  @override
  void onClose() {
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
      Get.snackbar('오류', '다시 시도해주세요');
    }
  }
}
