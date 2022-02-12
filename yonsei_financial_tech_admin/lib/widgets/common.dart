import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

/// custom data
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

/// controllers
import '../controllers/auth_controller.dart';

const mapper = {
  'Introduction & Education': ['/home/intro_edu', Icons.info_outline_rounded],
  'People': ['', Icons.people_alt_rounded],
  'Project': ['/home/project', Icons.science_rounded],
  'Working Papers': ['', Icons.contact_page_rounded],
  'Collaboration': ['/home/collaboration', Icons.workspaces_rounded],
  'Seminars': ['', Icons.present_to_all_rounded],
};

var drawer = Drawer(
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
              // TODO: route pages
              onTap: () => bottomSnackBar('title', 'msg'),
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

var appBar = AppBar(
  title: Text(
    'Yonsei Fintech Admin mode',
    style: ThemeTyphography.subTitle.style,
  ),
  flexibleSpace: Container(
    decoration: BoxDecoration(gradient: ThemeColor.gradient.color),
  ),
  centerTitle: true,
  elevation: 0.0,
);

var floatingButton = InkWell(
  onTap: () => bottomSnackBar(
    '문의하기',
    '준비중이에요 ☺️',
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

inputDecoration(String? hintText) => InputDecoration(
      hintText: hintText,
      contentPadding: padding(16, 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.blueGrey),
      ),
    );

/// for same snackbar to be revealed
bottomSnackBar(String title, String msg) => Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 32),
      icon: SvgPicture.asset(
        'yonsei_logo.svg',
        key: UniqueKey(),
        width: 40,
        height: 40,
      ),
      padding: padding(32, 16),
      backgroundColor: Colors.white.withOpacity(0.5),
    );
