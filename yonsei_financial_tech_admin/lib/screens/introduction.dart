import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/intro_edu_controller.dart';
import 'package:ysfintech_admin/model/introduction.dart';
import 'package:ysfintech_admin/screens/introduction_edit.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:ysfintech_admin/widgets/common.dart';

class IntroEduScreen extends GetResponsiveView<IntroEduController> {
  /// open bottom sheet
  moveToEditScreen({
    required bool isNewData,
    required int id,
    Intro? e,
  }) {
    if (!isNewData) {
      if (controller.docIDs.containsKey(id)) {
        Get.bottomSheet(
          IntroBottomSheet(
            !isNewData,
            controller.docIDs[id]!,
            e!,
            Get.height,
          ),
          isScrollControlled: true,
        );
      }
    } else {
      Get.bottomSheet(
        IntroBottomSheet(
          true,
          (controller.intros.length + 1)
              .toString(), // to be pushed at last element
          new Intro(
            content: '',
            id: controller.intros.length + 1,
            imagePath: '',
            name: '',
            role: '',
            title: '',
          ),
          Get.height,
        ),
        isScrollControlled: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    /// put controller of bottomSheet
    Get.put(IntroEditController());

    return Scaffold(
      /// common Widgets
      appBar: CommonWidget.appBar,
      drawer: CommonWidget.drawer,
      floatingActionButton: CommonWidget.floatingButton,

      /// body
      body: ListView(
        padding: padding(16, 32),
        shrinkWrap: true,
        children: [
          Text(
            'Introduction',
            style: ThemeTyphography.title.style
                .copyWith(color: ThemeColor.primary.color),
          ),

          /// introduction contents
          Obx(
            () => ListView(
              padding: padding(8, 16),
              reverse: true,
              shrinkWrap: true,
              children: controller.intros
                  .map((e) => ListTile(
                        /// events
                        onTap: () => moveToEditScreen(
                          isNewData: false,
                          id: e.id,
                          e: e,
                        ),
                        hoverColor: (ThemeColor.second.color as Color)
                            .withOpacity(0.15),

                        /// contents
                        leading: Text(
                          '${e.id}',
                          style: ThemeTyphography.subTitle.style,
                        ),
                        title: Text(
                          e.content,
                          style: ThemeTyphography.body.style,
                        ),
                        subtitle: Text(
                          e.name + ' / ' + e.role,
                          style: ThemeTyphography.caption.style,
                        ),
                        trailing: Wrap(
                          children: [
                            TextButton(
                              onPressed: () => moveToEditScreen(
                                isNewData: false,
                                id: e.id,
                                e: e,
                              ),
                              child: Text(
                                '수정',
                                style: ThemeTyphography.body.style,
                              ),
                              style: TextButton.styleFrom(
                                // backgroundColor: ThemeColor.primary.color,
                                padding: padding(16, 8),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: ThemeColor.primary.color,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),

                            /// remove
                            TextButton(
                              onPressed: () {
                                if (controller.docIDs.containsKey(e.id)) {
                                  controller.removeIntro(
                                    controller.docIDs[e.id]!,
                                    e.id,
                                  );
                                }
                              },
                              child: Text(
                                '삭제',
                                style: ThemeTyphography.body.style.copyWith(
                                  color: ThemeColor.highlight.color,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                // backgroundColor: ThemeColor.primary.color,
                                padding: padding(16, 8),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: ThemeColor.highlight.color,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          InkWell(
            onTap: () => moveToEditScreen(
              isNewData: true,
              id: controller.intros.length + 1,
            ),
            child: CircleAvatar(
              child: Icon(
                Icons.plus_one_rounded,
                color: Colors.white,
              ),
              backgroundColor: ThemeColor.primary.color,
            ),
          ),

          /// Divider between introduction and education
          Divider(),
        ],
      ),
    );
  }
}
