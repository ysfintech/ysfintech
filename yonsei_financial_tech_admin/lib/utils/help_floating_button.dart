import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'color.dart';

final helpButton = InkWell(
  onTap: () => Get.snackbar(
    '문의하기',
    '준비중이에요 😄',
    snackPosition: SnackPosition.BOTTOM,
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
