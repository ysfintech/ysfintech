import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/intro_controller.dart';
import 'package:ysfintech_admin/model/introduction.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:ysfintech_admin/widgets/common.dart';

class IntroBottomSheet extends GetResponsiveView<IntroEditController> {
  // static final controller = Get.put(IntroEditController());

  final String? docID;
  final int indexOfDoc;
  final Intro? passedData;
  final double parentHeight;

  IntroBottomSheet(
    this.docID,
    this.indexOfDoc,
    this.passedData,
    this.parentHeight,
  ) {
    controller.initTextControllers(
      docID,
      passedData,
      indexOfDoc,
    );
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
      child:

          /// check if the update process is being running
          controller.isLoading.isTrue
              ? CircularProgressIndicator.adaptive()
              : Form(
                  key: controller.introKey,
                  child: Obx(() => ListView(
                        children: [
                          Text(
                            docID == null ? '작성하기' : '수정하기',
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
                              decoration: inputDecoration('제목을 입력해주세요...'),
                              style: ThemeTyphography.body.style,
                            ),
                            minLeadingWidth: Get.size.width * 0.05,
                          ),

                          /// content
                          ListTile(
                            leading: Icon(Icons.article_rounded),
                            title: TextFormField(
                              controller: controller.introContentCtlr,
                              decoration: inputDecoration('내용을 입력해주세요...'),
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
                              decoration: inputDecoration('작성자를 입력해주세요...'),
                              style: ThemeTyphography.body.style,
                            ),
                            minLeadingWidth: Get.size.width * 0.05,
                          ),

                          /// writer's role
                          ListTile(
                            leading: Icon(Icons.star_outline_rounded),
                            title: TextFormField(
                              controller: controller.introRoleCtlr,
                              decoration: inputDecoration('역할를 입력해주세요...'),
                              style: ThemeTyphography.body.style,
                            ),
                            minLeadingWidth: Get.size.width * 0.05,
                          ),

                          /// image upload
                          Center(
                            child: Padding(
                              padding: padding(0, 32),

                              /// check if user has selected image to upload
                              /// if not get the image from firebase first
                              child: controller.imageFile.value.isEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: controller.imagePath.value != ''
                                          ? controller.imagePath.value
                                          : controller.notFoundURL,
                                      placeholder: (_, url) =>
                                          CircularProgressIndicator.adaptive(),
                                      errorWidget: (_, url, err) =>
                                          Text('LOAD FAILED 🥶\n$err'),

                                      /// size
                                      width: Get.width * 0.25,
                                      height: Get.height * 0.25,
                                    )
                                  : Image.memory(
                                      controller.imageFile.value,

                                      /// size
                                      width: Get.width * 0.25,
                                      height: Get.height * 0.25,
                                    ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: controller.selectFile,
                            icon: Icon(
                              Icons.file_upload_rounded,
                              color: Colors.white,
                            ),
                            label: Text(
                              '파일 선택 후 덮어쓰기',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: ThemeColor.primary.color,
                              shape: StadiumBorder(),
                              padding: padding(0, 16),
                            ),
                          ),
                          SizedBox(height: 16),

                          /// save
                          TextButton(
                            onPressed: controller.updateIntro,
                            child: Text(
                              '저장하기',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: ThemeColor.highlight.color,
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
