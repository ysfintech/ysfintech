import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/intro_edu_controller.dart';
import 'package:ysfintech_admin/screens/intro_edu_bottomsheet.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:ysfintech_admin/widgets/common.dart';

class IntroEduScreen extends GetResponsiveView<IntroEduController> {
  @override
  Widget build(BuildContext context) {
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
                        onTap: () {
                          if (controller.docIDs.containsKey(e.id)) {
                            // print(e.id.toString() + ' ' + controller.docIDs[e.id].toString());
                            Get.bottomSheet(
                              IntroBottomSheet(
                                controller.docIDs[e.id]!,
                                e,
                                Get.height,
                              ),
                              isScrollControlled: true,
                            );
                          }
                        },
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
                        trailing: TextButton.icon(
                          onPressed: () => Get.snackbar('title', 'message'),
                          icon:
                              Icon(Icons.mode_edit_outline_rounded, size: 20.0),
                          label: Text(
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
                      ))
                  .toList(),
            ),
          ),
          InkWell(
            onTap: () => Get.bottomSheet(BottomSheet(
                onClosing: () {},
                builder: (_) {
                  return Container(
                    height: Get.height * 0.5,
                  );
                })),
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
