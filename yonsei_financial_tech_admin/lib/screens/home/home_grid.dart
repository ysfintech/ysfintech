import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ysfintech_admin/utils/color.dart';

import 'package:ysfintech_admin/utils/spacing.dart';
import 'package:ysfintech_admin/utils/typography.dart';
import 'package:ysfintech_admin/widgets/common.dart';

class HomeGridViewScreen extends StatefulWidget {
  const HomeGridViewScreen({Key? key}) : super(key: key);

  @override
  _HomeGridViewScreenState createState() => _HomeGridViewScreenState();
}

class _HomeGridViewScreenState extends State<HomeGridViewScreen> {
  static Color unSelectedColor = Colors.grey.withOpacity(0.5);

  var gridViewColors =
      List.generate(CommonWidget.mapper.length, (index) => unSelectedColor);

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
      /// common Widgets
      appBar: CommonWidget.appBar,
      drawer: CommonWidget.drawer,
      floatingActionButton: CommonWidget.floatingButton,

      /// grid view body
      body: Center(
        child: GridView.builder(
          shrinkWrap: true,
          padding: padding(16, 16),
          itemCount: CommonWidget.mapper.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 x 3
            childAspectRatio: 1, // width 1 / height 1
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemBuilder: (context, index) => InkWell(
            onHover: (value) => onSelected(index),
            onTap: () {
              final key =
                  CommonWidget.mapper.values.elementAt(index).first.toString();
              if (key != '')
                Get.toNamed(key);
              else
                Get.snackbar('route', 'preparing');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: gridViewColors[index],
                  title: Text(
                    CommonWidget.mapper.keys.elementAt(index),
                    style: ThemeTyphography.subTitle.style,
                    textAlign: TextAlign.center,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Icon(
                    CommonWidget.mapper.values.elementAt(index).last
                        as IconData,
                    size: Get.width * 0.125,
                    color: gridViewColors[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
