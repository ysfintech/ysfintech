import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yonsei_financial_tech/components/color.dart';

// Simple
TextStyle headlineTextStyle = GoogleFonts.notoSerif(
    textStyle: TextStyle(
        fontSize: 26,
        color: textPrimary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500));

TextStyle headlineWhiteTextStyle = GoogleFonts.notoSerif(
    textStyle: TextStyle(
        fontSize: 26,
        color: Colors.white,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500));

TextStyle headlineSecondaryTextStyle = GoogleFonts.notoSerif(
    textStyle: TextStyle(
        fontSize: 20, color: textPrimary, fontWeight: FontWeight.w300));

TextStyle subtitleTextStyle = GoogleFonts.notoSerif(
    textStyle: TextStyle(
        fontSize: 16,
        color: textSecondary,
        letterSpacing: 1,
        fontWeight: FontWeight.bold));

TextStyle subtitleWhiteTextStyle = GoogleFonts.notoSerif(
    textStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
        letterSpacing: 1,
        fontWeight: FontWeight.bold));

TextStyle bodyTextStyle = GoogleFonts.notoSerif(
    textStyle: TextStyle(fontSize: 14, color: textPrimary));

TextStyle bodyWhiteTextStyle = GoogleFonts.notoSerif(
    textStyle: TextStyle(fontSize: 14, color: lightWhite));

TextStyle buttonTextStyle = GoogleFonts.notoSerif(
    textStyle: TextStyle(fontSize: 14, color: textPrimary, letterSpacing: 1));

// Advanced
TextStyle titleIntroductionTextStyle = TextStyle(
    fontSize: 40,
    color: Colors.white,
    fontWeight: FontWeight.w800,
    // fontFamily: 'Yonsei'
    fontFamily: GoogleFonts.notoSerif().fontFamily);

TextStyle articleTitleTextStyle({Color color}) {
  return TextStyle(
      fontSize: 28,
      color: color != null ? color : Colors.white,
      fontFamily: 'Yonsei',
      fontWeight: FontWeight.w700);
}

TextStyle articleContentTextStyle({Color color}) {
  return TextStyle(
    fontSize: 22,
    color: color != null ? color : ligthGray,
  );
}

TextStyle imageDescTextStyle =
    GoogleFonts.notoSerif(textStyle: TextStyle(fontSize: 12, color: ligthGray));
