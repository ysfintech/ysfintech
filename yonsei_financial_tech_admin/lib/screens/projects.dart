import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/project_controller.dart';
import 'package:ysfintech_admin/model/project.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/firebase.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:ysfintech_admin/widgets/common.dart';

class ProjectScreen extends GetResponsiveView<ProjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appBar,
      drawer: CommonWidget.drawer,
      floatingActionButton: CommonWidget.floatingButton,

      /// body
      body: Padding(
        padding: padding(8, 16),
        child: CustomScrollView(
          slivers: [
            /// app bar
            // SliverAppBar(
            //   title: Text('Sliver App Bar'),
            // ),

            /// list
            Obx(
              () => SliverList(
                delegate: SliverChildListDelegate(
                  controller.projects
                      .map(
                        (e) => ListTile(
                          leading: CircleAvatar(
                            backgroundColor: ThemeColor.primary.color,
                            child: Text(
                              '${e.id}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: cardItem(e),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cardItem(Project data) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8.0,
        child: Padding(
          padding: padding(16, 8),
          child: Column(
            children: [
              Text(
                '${data.title}',
                style: ThemeTyphography.subTitle.style.copyWith(
                  color: ThemeColor.primary.color,
                ),
              ),
              Row(
                children: [
                  /// left-side : image, image-desc
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FutureBuilder(
                        future: FireStoreDB.getDownloadURL(data.imagePath),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return CachedNetworkImage(
                              imageUrl: snapshot.data as String,
                              width: Get.width * 0.2,
                              fit: BoxFit.cover,
                            );
                          } else if (!snapshot.hasData) {
                            return CircularProgressIndicator.adaptive();
                          } else {
                            return Text('Error');
                          }
                        }),
                  ),

                  /// right-side : content
                  Expanded(
                    child: Padding(
                      padding: padding(8, 4),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: data.content,
                              style: ThemeTyphography.body.style,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${data.from}',
                              style: ThemeTyphography.caption.style,
                            ),
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${data.period}',
                              style: ThemeTyphography.caption.style,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
