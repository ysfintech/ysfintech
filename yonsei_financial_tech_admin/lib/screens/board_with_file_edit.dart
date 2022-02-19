import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/firebase.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

import 'package:ysfintech_admin/widgets/common.dart';

import 'package:ysfintech_admin/controllers/board_with_file_controller.dart';
import 'package:ysfintech_admin/model/board.dart';

class BoardWithFileBottomSheet
    extends GetResponsiveView<BoardWithFileEditController> {
  final String title;
  final Board? board;
  final String? docId;
  final int docNumericId;

  BoardWithFileBottomSheet({
    required this.title,
    this.board,
    this.docId,
    required this.docNumericId,
  }) : assert(
          (board != null && docId != null) || (board == null && docId == null),
        ) {
    // init
    controller.init(board, docId, docNumericId);
  }

  void openURL(String url) async {
    if (url == '' || !await launch(url))
      bottomSnackBar('Error', '파일을 찾을 수 없어요 :(');
  }

  String getFilename(String? imagePath) {
    if (imagePath == null || imagePath == '') return '';
    final ref = FireStoreDB.baseURL + '/' + controller.collectionName;
    return imagePath.substring(ref.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding(32, 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Get.size.width * 0.015),
          topRight: Radius.circular(Get.size.width * 0.015),
        ),
        color: Colors.white,
      ),
      child: Obx(
        () {
          if (controller.onProgress.isFalse) {
            return Form(
              // TODO: validator implementation
              child: ListView(
                children: [
                  Text(
                    "$title ${board == null ? '새롭게 작성하기' : '기존 글 수정하기'}",
                    style: ThemeTyphography.title.style,
                  ),
                  SizedBox(height: 32),

                  /// Title
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
                    maxLines: null,
                  ),
                  SizedBox(height: 32),

                  /// existing file
                  Wrap(
                    spacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: ThemeColor.second.color,
                          shape: StadiumBorder(),
                          padding: padding(32, 16),
                        ),
                        icon: Icon(
                          Icons.file_download,
                          color: Colors.white,
                        ),
                        label: Text(
                          '${getFilename(controller.selectedBoard.value?.imagePath)} 파일 다운로드',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () =>
                            openURL(controller.downloadableURL.value ?? ''),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: ThemeColor.highlight.color,
                          shape: StadiumBorder(),
                          padding: padding(32, 16),
                        ),
                        icon: Icon(
                          Icons.file_upload_rounded,
                          color: Colors.white,
                        ),
                        label: Text(
                          '파일 업로드',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: controller.selectFile,
                      ),
                      Obx(
                        () => Text(
                          controller.selectedFileBytes != null
                              ? '업로드된 파일 : ${controller.selectedFileName}'
                              : '업로드한 파일이 없어요',
                          style: ThemeTyphography.body.style,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),

                  /// save button
                  TextButton(
                    onPressed: controller.save,
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

                  if (docId != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: controller.delete,
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
                        ),
                      ],
                    ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator.adaptive();
          }
        },
      ),
    );
  }
}
