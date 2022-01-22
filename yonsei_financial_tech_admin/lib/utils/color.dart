import 'package:flutter/material.dart';

// Text
Color textPrimary = Color(0xFF111111);
Color textSecondary = Color(0xFF3A3A3A);
// Theme
const themeBlue = Color.fromRGBO(0, 55, 111, 1.0);
const lightWhite = Color.fromRGBO(242, 242, 242, 1.0);
const ligthBlack = Color.fromRGBO(51, 51, 51, 1.0);
const ligthGray = Color.fromRGBO(119, 119, 119, 1.0);

enum ThemeColor { primary, second, title, body, caption }

extension ThemeColorExtension on ThemeColor {
  Color get color {
    switch (this) {
      case ThemeColor.primary:
        return Color(0xFF0083B0);
      case ThemeColor.second:
        return Color(0xFF00B4DB);
      case ThemeColor.title:
        return Color(0xFF111111);
      case ThemeColor.body:
        return Color(0xFF3A3A3A);
      case ThemeColor.caption:
        return Color.fromRGBO(119, 119, 119, 1.0);
      default:
        return Color.fromRGBO(0, 55, 111, 1.0);
    }
  }
}
