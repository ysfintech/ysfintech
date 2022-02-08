import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/collaboration_controller.dart';
import 'package:ysfintech_admin/screens/board_list.dart';
import 'package:ysfintech_admin/screens/collaboration_edit.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';


class CollaborationScreen extends GetResponsiveView<CollaborationController> {
  @override
  Widget build(BuildContext context) {

    /// insert dependency
    Get.put(CollaborationEditController());

    return Scaffold(
      body: CustomScrollView(
          controller: controller.scrollController.value,
          slivers: [
            /// app bar
            SliverAppBar(
              backgroundColor: ThemeColor.primary.color,
              floating: false,
              pinned: true,
              snap: false,
              expandedHeight: 220,
              flexibleSpace: Obx(
                () => FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: padding(32, 16),
                  title: Wrap(
                    spacing: 16.0,
                    children: [
                      Center(
                        child: Text(
                          '연세대학교 금융기술센터 Collaboration',
                          style: ThemeTyphography.subTitle.style,
                        ),
                      ),

                      /// search bar
                      controller.scrollController.value.position.pixels > 0
                          ? SizedBox()
                          : Padding(
                              padding: padding(8, 16),
                              child: Form(
                                key: UniqueKey(),
                                child: TextFormField(
                                  controller: controller.searchController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,

                                    hintText: '제목을 입력해주세요...',
                                    labelStyle: ThemeTyphography.body.style,

                                    /// [Button]
                                    suffixIcon: TextButton.icon(
                                      onPressed: () =>
                                          controller.searchController.clear(),
                                      icon: Icon(Icons.clear_rounded),
                                      label: SizedBox(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => Get.bottomSheet(
                    CollaborationBottomSheet(
                      indexOfDoc: controller.parentBoards.length + 1,
                      parentSize: Get.size,
                    ),
                  ),
                  icon: Icon(Icons.plus_one_rounded),
                )
              ],
            ),

            /// list of boards
            Obx(
              () => BoardListScreen(list: controller.boards),
            ),
          ]),
    );
  }
}
