import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/project_controller.dart';
import 'package:ysfintech_admin/model/project.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:ysfintech_admin/widgets/common.dart';

class ProjectBottomSheet extends GetResponsiveView<ProjectEditController> {
  /// variables that need to be passed from previous page
  final dynamic docID;
  final Project? project;
  final double parentHeight;

  ProjectBottomSheet({
    required this.docID,
    required this.parentHeight,
    this.project,
  }) {
    /// init data
    controller.getInfoFrom(docID, project);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: parentHeight * 0.9,
      padding: padding(32, 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),

      /// title, image, content, organ, image_description, period(from-to)
      child: Obx(
        () => ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: padding(0, 16),
              child: Text(
                'Project ${project != null ? "수정하기" : "게시하기"}',
                style: ThemeTyphography.title.style.copyWith(
                  color: ThemeColor.primary.color,
                ),
              ),
            ),

            /// title
            Text(
              'Title',
              style: ThemeTyphography.subTitle.style,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: controller.titleController,
              style: ThemeTyphography.subTitle.style,
              decoration: CommonWidget.inputDecoration('제목을 입력해주세요...'),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                /// left-side : image, image_description
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// image part
                      Text(
                        'Image',
                        style: ThemeTyphography.subTitle.style,
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFD8D8D8)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: controller.binaryImage.value.isEmpty
                              ? CachedNetworkImage(
                                  imageUrl: controller.imagePath.value,
                                  width: Get.width * 0.3,
                                  errorWidget: (context, url, error) =>
                                      CircularProgressIndicator.adaptive(),
                                )
                              : Image.memory(
                                  controller.binaryImage.value,
                                  width: Get.width * 0.3,
                                ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton.icon(
                        onPressed: controller.uploadNewImage,
                        label: Text(
                          '업로드 및 덮어쓰기',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        icon: Icon(
                          Icons.upload_rounded,
                          color: Colors.white,
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: ThemeColor.highlight.color,
                          padding: padding(16, 8),
                        ),
                      ),
                      SizedBox(height: 16),

                      /// image description part
                      Text(
                        'Description',
                        style: ThemeTyphography.subTitle.style,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: controller.imageDescController,
                        style: ThemeTyphography.caption.style,
                        decoration: CommonWidget.inputDecoration(
                            '첨부한 이미지에 대한 설명을 입력해주세요...'),
                      ),
                    ],
                  ),
                ),

                /// right-side : content, organ, period
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: padding(16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// content
                        Text(
                          'Contents',
                          style: ThemeTyphography.subTitle.style,
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: controller.contentController,
                          style: ThemeTyphography.body.style,
                          maxLines: null,
                          decoration:
                              CommonWidget.inputDecoration('내용을 입력해주세요...'),
                        ),
                        SizedBox(height: 16),

                        /// organ
                        Text(
                          'Organization',
                          style: ThemeTyphography.subTitle.style,
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: controller.organController,
                          style: ThemeTyphography.body.style,
                          decoration:
                              CommonWidget.inputDecoration('기관을 입력해주세요...'),
                        ),
                        SizedBox(height: 16),

                        /// period
                        Text(
                          'Period',
                          style: ThemeTyphography.subTitle.style,
                        ),
                        SizedBox(height: 8),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width * 0.15,
                              child: TextFormField(
                                controller: controller.fromController,
                                style: ThemeTyphography.body.style,
                                decoration: CommonWidget.inputDecoration(
                                    '시작년도 ex) 2022'),
                              ),
                            ),
                            Text(' ~ '),
                            SizedBox(
                              width: Get.width * 0.15,
                              child: TextFormField(
                                controller: controller.toController,
                                style: ThemeTyphography.body.style,
                                decoration: CommonWidget.inputDecoration(
                                    '종료년도 ex) 2022'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            /// `onSAVE` ============================================================
            ElevatedButton(
              onPressed: controller.save,
              child: Text(
                '저장하기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                elevation: 8.0,
                primary: ThemeColor.highlight.color,
              ),
            ),

            /// `onDELETE` ============================================================
            SizedBox(height: 32),

            /// save button
            project != null
                ? ElevatedButton(
                    onPressed: () => controller.removeProject(project!.id),
                    child: Text(
                      '삭제하기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      elevation: 8.0,
                      primary: ThemeColor.second.color,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
