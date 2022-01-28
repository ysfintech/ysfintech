import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// custom data
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

/// controllers
import '../controllers/auth_controller.dart';

class CommonWidget {
  static final mapper = {
    'Introduction & Education': ['/home/intro_edu', Icons.info_outline_rounded],
    'People': ['', Icons.people_alt_rounded],
    'Project': ['/home/project', Icons.science_rounded],
    'Papers': ['', Icons.contact_page_rounded],
    'Worklist': ['', Icons.workspaces_rounded],
    'Seminars': ['', Icons.present_to_all_rounded],
  };

  static var drawer = Drawer(
    // style
    backgroundColor: ThemeColor.primary.color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(Get.width * 0.025),
        bottomEnd: Radius.circular(Get.width * 0.025),
      ),
    ),
    // child
    child: ListView(
      padding: padding(0, 32),
      children: mapper.entries
          .map<Widget>((e) => ListTile(
                onTap: () => Get.snackbar('r', 'message'),
                hoverColor: ThemeColor.second.color,
                leading: Icon(
                  e.value.last as IconData,
                  color: Colors.white,
                ),
                title: Text(
                  e.key,
                  style: TextStyle(fontWeight: FontWeight.bold)
                      .copyWith(color: Colors.white),
                ),
              ))
          .toList()
        ..add(SizedBox(
          height: 32,
        ))
        ..add(ListTile(
          onTap: AuthController.instance.signOut,
          hoverColor: ThemeColor.second.color,
          leading: Icon(
            Icons.logout_outlined,
            color: Colors.white,
          ),
          title: Text(
            '로그아웃',
            style: TextStyle(fontWeight: FontWeight.bold)
                .copyWith(color: Colors.white),
          ),
          selectedTileColor: ThemeColor.primary.color,
        )),
    ),
  );

  static var appBar = AppBar(
    title: Text(
      'Yonsei Fintech Admin mode',
      style: ThemeTyphography.subTitle.style,
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(gradient: ThemeColor.gradient.color),
    ),
    centerTitle: true,
    elevation: 1.0,
  );

  static var floatingButton = InkWell(
    onTap: () => Get.snackbar(
      '문의하기',
      '준비중이에요',
      snackPosition: SnackPosition.BOTTOM,
      // margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: ThemeColor.body.color.withOpacity(0.5),
            spreadRadius: 0.25,
            blurRadius: 7,
            offset: Offset(1, 3),
          )
        ],
      ),
      child: CircleAvatar(
        child: Icon(
          Icons.help_outline_rounded,
          color: Colors.white,
        ),
        backgroundColor: ThemeColor.primary.color,
      ),
    ),
  );

  static inputDecoration(String? hintText) => InputDecoration(
        hintText: hintText,
        contentPadding: padding(16, 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
      );
}
