import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/model/board.dart';

/// utils
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

/// list up the fetched data from the stream
/// only used for [Working Papers], [Collaboration] and [Seminars]
///
/// each of the board will have widget of `ListTile`
/// with `id`, `title`, `content`, `date`, `imagePath`, `view` and  `writer`
///
/// and this class had to be wrapped up like `Obx(() => BoardListScreen())`
///
/// the small difference between [Working Papers] + [Seminars] and [Collaboration]
/// is that Collaboration don't neeed file attached!!
/// just leave the `imagePath` to `null`
///
/// and `imagePath` is used for filePath
///
///
/// finally returns `SliverList`, must be wrapped it `CustomListView`

class BoardListScreen extends StatelessWidget {

  final List<Board> list;
  BoardListScreen({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        list
            .map((item) => ListTile(
                  /// styles
                  minLeadingWidth: Get.width * 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: padding(16, 8),
                  tileColor: Colors.white,

                  // TODO: get the `onTap` function via parameter
                  onTap: () {},

                  /// `id`
                  leading: CircleAvatar(
                    child: Text(
                      '${item.id}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: ThemeColor.primary.color,
                  ),

                  /// `title`
                  title: Text(
                    item.title,
                    style: ThemeTyphography.subTitle.style,
                  ),

                  /// `content`
                  subtitle: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Text(
                        item.writer,
                        style: ThemeTyphography.caption.style,
                      ),
                      Text(
                        '${item.date.year}.${item.date.month}.${item.date.day}',
                        style: ThemeTyphography.caption.style,
                      ),
                    ],
                  ),

                  /// `views`
                  trailing: Text('조회수 : ${item.view}'),
                ))
            .toList(),
      ),
    );
  }
}
