/// basic
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ysfintech_admin/controllers/signin_controller.dart';

import 'package:ysfintech_admin/utils/color.dart';
// firebase auth
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:ysfintech_admin/widgets/common.dart';

import '../utils/spacing.dart';

/// updated 0121 Fri
/// using GetX controller to make event
class SignInScreen extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: paddingHorizontal20,
        child: Center(
          child: Form(
            key: controller.signInFormKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// title
                  SvgPicture.asset(
                    'yonsei_logo.svg',
                    width: Get.width * 0.1,
                    height: Get.width * 0.1,
                  ),
                  Padding(
                    padding: padding(16, 32),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: '연세대학교 Fintech Center\n',
                            style: ThemeTyphography.title.style),
                        TextSpan(
                            text: 'Admin',
                            style: ThemeTyphography.title.style
                                .copyWith(color: ThemeColor.primary.color)),
                        TextSpan(
                            text: ' Mode', style: ThemeTyphography.title.style),
                      ]),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  /// email
                  ListTile(
                    leading: Text('ID(이메일)'),
                    title: TextFormField(
                      controller: controller.emailController,
                      decoration: inputDecoration('example@gmail.com'),
                    ),
                    minLeadingWidth: Get.size.width * 0.1,
                  ),

                  /// password
                  ListTile(
                    leading: Text('PW'),
                    title: TextFormField(
                      controller: controller.passwordController,
                      decoration: inputDecoration('Password'),
                      obscureText: true,
                    ),
                    minLeadingWidth: Get.size.width * 0.1,
                  ),

                  /// login button
                  Padding(
                    padding: padding(16, 32),
                    child: ElevatedButton(
                      onPressed: controller.signIn,
                      child: Padding(
                        padding: padding(0, 8),
                        child: Text(
                          '로그인',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: ThemeColor.primary.color,
                        elevation: 1.0,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),

      /// helper contact
      floatingActionButton: floatingButton,
    );
  }
}
