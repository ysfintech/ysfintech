import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/controllers/auth_controller.dart';
import 'package:ysfintech_admin/utils/color.dart';
import 'package:ysfintech_admin/utils/help_floating_button.dart';
import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';

class HomeGridViewScreen extends StatefulWidget {
  const HomeGridViewScreen({Key? key}) : super(key: key);

  @override
  _HomeGridViewScreenState createState() => _HomeGridViewScreenState();
}

class _HomeGridViewScreenState extends State<HomeGridViewScreen> {
  static final mapper = {
    'Introduction & Education': ['', Icons.info_outline_rounded],
    'People': ['', Icons.people_alt_rounded],
    'Project': ['', Icons.science_rounded],
    'Papers': ['', Icons.contact_page_rounded],
    'Worklist': ['', Icons.workspaces_rounded],
    'Seminars': ['', Icons.present_to_all_rounded],
  };

  static Color unSelectedColor = Colors.grey.withOpacity(0.5);

  var gridViewColors = List.generate(mapper.length, (index) => unSelectedColor);

  void onSelected(int index) {
    setState(() {
      if (gridViewColors[index] == unSelectedColor) {
        gridViewColors[index] = ThemeColor.second.color;
      } else {
        gridViewColors[index] = unSelectedColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yonsei Fintech Admin mode',
          style: ThemeTyphography.subTitle.style,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: ThemeColor.gradient.color),
        ),
        centerTitle: true,
        elevation: 1.0,
      ),

      /// grid view body
      body: Center(
        child: GridView.builder(
          shrinkWrap: true,
          padding: padding(16, 16),
          itemCount: mapper.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 x 3
            childAspectRatio: 1, // width 1 / height 1
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemBuilder: (context, index) => InkWell(
            onHover: (value) => onSelected(index),
            onTap: () => Get.snackbar('route', 'preparing'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: gridViewColors[index],
                  title: Text(
                    mapper.keys.elementAt(index),
                    style: ThemeTyphography.subTitle.style,
                    textAlign: TextAlign.center,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Icon(
                    mapper.values.elementAt(index).last as IconData,
                    size: Get.width * 0.125,
                    color: gridViewColors[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      /// drawer
      drawer: Drawer(
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
      ),

      /// floating help button
      floatingActionButton: helpButton,
    );
  }
}
