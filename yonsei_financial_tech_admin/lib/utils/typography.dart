import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ysfintech_admin/utils/color.dart';

// import 'package:google_fonts/google_fonts.dart';

// // HEAD LINE 1
// TextStyle h1TextStyle = GoogleFonts.nunito(
//     textStyle: TextStyle(
//         fontSize: 30,
//         color: textPrimary,
//         letterSpacing: 1.5,
//         fontWeight: FontWeight.w700));

// TextStyle h1WhiteTextStyle = GoogleFonts.nunito(
//     textStyle: TextStyle(
//         fontSize: 30,
//         color: Colors.white,
//         letterSpacing: 1.5,
//         fontWeight: FontWeight.w700));

// // HEAD LINE 2
// TextStyle h2TextStyle = GoogleFonts.nunito(
//     textStyle: TextStyle(
//   fontSize: 24,
//   color: textPrimary,
//   fontWeight: FontWeight.w600,
//   letterSpacing: 1,
// ));

// TextStyle h2WhiteTextStyle = GoogleFonts.nunito(
//     textStyle: TextStyle(
//   fontSize: 24,
//   color: lightWhite,
//   fontWeight: FontWeight.w600,
//   letterSpacing: 1,
// ));

// // HEAD LINE 3
// TextStyle h3TextStyle = GoogleFonts.nunito(
//     textStyle: TextStyle(
//         fontSize: 20,
//         color: textSecondary,
//         letterSpacing: 1,
//         fontWeight: FontWeight.w500));

// TextStyle h3WhiteTextStyle = GoogleFonts.nunito(
//     textStyle: TextStyle(
//         fontSize: 20,
//         color: lightWhite,
//         letterSpacing: 1,
//         fontWeight: FontWeight.w500));

// // CONTENT
// TextStyle bodyTextStyle = GoogleFonts.nunito(
//     textStyle: TextStyle(
//         fontSize: 16, color: textPrimary, fontWeight: FontWeight.w400));

// TextStyle bodyWhiteTextStyle = GoogleFonts.nunito(
//     textStyle: TextStyle(
//         fontSize: 16, color: lightWhite, fontWeight: FontWeight.w400));

// // button
// TextStyle buttonTextStyle = GoogleFonts.nunito(
//     textStyle: TextStyle(
//         fontSize: 14,
//         color: textPrimary,
//         letterSpacing: 1,
//         fontWeight: FontWeight.w500));

// // image DESC
// TextStyle imageDescTextStyle =
//     GoogleFonts.nunito(textStyle: TextStyle(fontSize: 12, color: ligthGray));

// TextStyle imageDescTexWhitetStyle =
//     GoogleFonts.nunito(textStyle: TextStyle(fontSize: 12, color: lightWhite));

// // Advanced
// TextStyle titleIntroductionTextStyle = TextStyle(
//     fontSize: 40,
//     color: Colors.white,
//     fontWeight: FontWeight.w800,
//     // fontFamily: 'Yonsei'
//     fontFamily: GoogleFonts.nunito().fontFamily);

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
