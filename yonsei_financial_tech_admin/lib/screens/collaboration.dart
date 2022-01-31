import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/collaboration_controller.dart';
import 'package:ysfintech_admin/screens/board_list.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:ysfintech_admin/widgets/common.dart';

class CollaborationScreen extends GetResponsiveView<CollaborationController> {
  @override
  Widget build(BuildContext context) {
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
              expandedHeight: 160,
              flexibleSpace: Obx(
                () => FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: padding(32, 16),
                  title: Wrap(
                    spacing: 16.0,
                    children: [
                      Text(
                        '연세대학교 금융기술센터 Collaboration',
                        style: ThemeTyphography.subTitle.style,
                      ),

                      /// search bar
                      controller.scrollController.value.position.pixels > 0
                          ? SizedBox()
                          : Form(
                              key: UniqueKey(),
                              child: TextFormField(
                                controller: controller.searchController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),

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
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
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
