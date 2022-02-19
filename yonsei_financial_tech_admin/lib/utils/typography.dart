import 'package:flutter/material.dart';

enum ThemeTyphography { title, subTitle, body, caption }

extension ThemeTyphographyExtension on ThemeTyphography {
  TextStyle get style {
    switch (this) {
      case ThemeTyphography.title:
        return TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 38,
        );
      case ThemeTyphography.subTitle:
        return TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        );
      case ThemeTyphography.body:
        return TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      case ThemeTyphography.caption:
        return TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 11,
        );
      default:
        return TextStyle(
          fontWeight: FontWeight.normal,
        );
    }
  }
}
