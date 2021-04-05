import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yonsei_financial_tech/components/color.dart';

// Simple
TextStyle headlineTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: 26,
        color: textPrimary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w300));

TextStyle headlineSecondaryTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: 20, color: textPrimary, fontWeight: FontWeight.w300));

TextStyle subtitleTextStyle = GoogleFonts.openSans(
    textStyle: TextStyle(fontSize: 14, color: textSecondary, letterSpacing: 1));

TextStyle bodyTextStyle = GoogleFonts.openSans(
    textStyle: TextStyle(fontSize: 14, color: textPrimary));

TextStyle buttonTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(fontSize: 14, color: textPrimary, letterSpacing: 1));

// Advanced
TextStyle titleIntroductionTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontSize: 40, color: Colors.white, fontWeight: FontWeight.w800));

TextStyle articleTitleTextStyle({Color color}) {
  return TextStyle(
      fontSize: 28,
      color: color != null ? color : Colors.white,
      fontWeight: FontWeight.w700);
}

TextStyle articleContentTextStyle({Color color}) {
  return TextStyle(
    fontSize: 22,
    color: color != null ? color : ligthGray,
  );
}

TextStyle imageDescTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(fontSize: 12, color: ligthGray));
