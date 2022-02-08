import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// controller
import 'package:ysfintech_admin/controllers/collaboration_controller.dart';

/// model
import 'package:ysfintech_admin/model/board.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

class CollaborationBottomSheet
    extends GetResponsiveView<CollaborationEditController> {
  final Board? board;
  final String? docID;
  final int indexOfDoc;
  final Size parentSize;

  /// if the `board` and `docID` are `null` then it means [new work]
  /// or else it must be editing an [exisiting work]
  CollaborationBottomSheet({
    Key? key,
    this.board,
    this.docID,
    required this.indexOfDoc,
    required this.parentSize,
  })  : assert(
          (board != null && docID != null) || (board == null && docID == null),
        ),
        super(key: key);

  static OutlineInputBorder outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  );

  static InputDecoration formDecoration = InputDecoration(
    border: outlineBorder,
    fillColor: Colors.grey[100],
    filled: true,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: parentSize.height * 0.8,
      padding: padding(16, 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(parentSize.width * 0.015),
          topRight: Radius.circular(parentSize.width * 0.015),
        ),
        color: Colors.white,
      ),

      /// needs [content], [date], [id], [title], [view], [writer]
      child: Form(
        key: UniqueKey(),
        child: ListView(
          padding: padding(16, 16),
          children: [
            Text(
              board == null ? '새롭게 작성하기' : '기존 글 수정하기',
              style: ThemeTyphography.title.style,
            ),
            SizedBox(height: 32),

            /// id
            Text(
              'ID : $indexOfDoc',
              style: ThemeTyphography.subTitle.style,
            ),
            SizedBox(
              height: 16,
            ),

            /// Content
            Text(
              'Title',
              style: ThemeTyphography.subTitle.style.copyWith(
                color: ThemeColor.primary.color,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: controller.titleController,
              decoration: formDecoration,
            ),
            SizedBox(height: 32),

            /// Content
            Text(
              'Content',
              style: ThemeTyphography.subTitle.style.copyWith(
                color: ThemeColor.primary.color,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: controller.contentController,
              decoration: formDecoration,
            ),
            SizedBox(height: 32),

            /// save button
            TextButton(
              onPressed: () {},
              child: Text(
                '저장하기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              style: TextButton.styleFrom(
                padding: padding(0, 16),
                backgroundColor: ThemeColor.primary.color,
                shape: StadiumBorder(),
              ),
            ),

            if (docID != null)
              TextButton(
                onPressed: () {},
                child: Text(
                  '삭제하기',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: padding(0, 16),
                  backgroundColor: ThemeColor.highlight.color,
                  shape: StadiumBorder(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
