import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/intro_edu_controller.dart';
import 'package:ysfintech_admin/model/introduction.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:ysfintech_admin/widgets/common.dart';

class IntroBottomSheet extends StatelessWidget {
  static final controller = Get.put(IntroEditController());

  late final String docID;
  late final Intro passedData;
  late final double parentHeight;

  IntroBottomSheet(this.docID, this.passedData, this.parentHeight) {
    controller.initTextControllers(passedData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: parentHeight * 0.8,
      padding: padding(16, 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Get.width * 0.015),
          topRight: Radius.circular(Get.width * 0.015),
        ),
        color: Colors.white,
      ),
      // needs ListView and Forms
      child: Form(
        key: controller.introKey,
        child: Obx(() => ListView(
              children: [
                Text(
                  '수정하기',
                  style: ThemeTyphography.subTitle.style
                      .copyWith(color: ThemeColor.primary.color),
                ),
                SizedBox(
                  height: 32,
                ),

                /// title
                ListTile(
                  leading: Icon(Icons.title_rounded),
                  title: TextFormField(
                    controller: controller.introTitleCtlr,
                    decoration: CommonWidget.inputDecoration('제목을 입력해주세요...'),
                    style: ThemeTyphography.body.style,
                  ),
                  minLeadingWidth: Get.size.width * 0.05,
                ),

                /// content
                ListTile(
                  leading: Icon(Icons.article_rounded),
                  title: TextFormField(
                    controller: controller.introContentCtlr,
                    decoration: CommonWidget.inputDecoration('내용을 입력해주세요...'),
                    style: ThemeTyphography.body.style,
                    maxLines: null,
                  ),
                  minLeadingWidth: Get.size.width * 0.05,
                ),

                /// writer's name
                ListTile(
                  leading: Icon(Icons.person),
                  title: TextFormField(
                    controller: controller.introNameCtlr,
                    decoration: CommonWidget.inputDecoration('작성자를 입력해주세요...'),
                    style: ThemeTyphography.body.style,
                  ),
                  minLeadingWidth: Get.size.width * 0.05,
                ),

                /// writer's role
                ListTile(
                  leading: Icon(Icons.star_outline_rounded),
                  title: TextFormField(
                    controller: controller.introRoleCtlr,
                    decoration: CommonWidget.inputDecoration('역할를 입력해주세요...'),
                    style: ThemeTyphography.body.style,
                  ),
                  minLeadingWidth: Get.size.width * 0.05,
                ),

                /// image upload
                Center(
                  child: Padding(
                    padding: padding(0, 32),
                    child: Image.network(controller.imagePath.value,
                        width: Get.width * 0.25, height: Get.height * 0.25,
                        errorBuilder: (context, error, stackTrace) {
                      final res = controller.imagePath.string;
                      print(res);
                      return Text('LOAD FAILED 🥶');
                    }),
                  ),
                ),
                TextButton.icon(
                  onPressed: controller.selectFile,
                  icon: Icon(
                    Icons.file_upload_rounded,
                    color: Colors.white,
                  ),
                  label: Text(
                    '파일 선택하기',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: ThemeColor.primary.color,
                    shape: StadiumBorder(),
                    padding: padding(0, 16),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
