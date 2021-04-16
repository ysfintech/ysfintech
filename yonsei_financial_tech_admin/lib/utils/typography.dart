import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ysfintech_admin/utils/color.dart';

// HEAD LINE 1
TextStyle h1TextStyle = GoogleFonts.notoSans(
    textStyle: TextStyle(
        fontSize: 30,
        color: textPrimary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700));

TextStyle h1WhiteTextStyle = GoogleFonts.notoSans(
    textStyle: TextStyle(
        fontSize: 30,
        color: Colors.white,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700));

// HEAD LINE 2
TextStyle h2TextStyle = GoogleFonts.notoSans(
    textStyle: TextStyle(
  fontSize: 24,
  color: textPrimary,
  fontWeight: FontWeight.w600,
  letterSpacing: 1,
));

TextStyle h2WhiteTextStyle = GoogleFonts.notoSans(
    textStyle: TextStyle(
  fontSize: 24,
  color: lightWhite,
  fontWeight: FontWeight.w600,
  letterSpacing: 1,
));

// HEAD LINE 3
TextStyle h3TextStyle = GoogleFonts.notoSans(
    textStyle: TextStyle(
        fontSize: 20,
        color: textSecondary,
        letterSpacing: 1,
        fontWeight: FontWeight.w500));

TextStyle h3WhiteTextStyle = GoogleFonts.notoSans(
    textStyle: TextStyle(
        fontSize: 20,
        color: lightWhite,
        letterSpacing: 1,
        fontWeight: FontWeight.w500));

// CONTENT
TextStyle bodyTextStyle = GoogleFonts.notoSans(
    textStyle: TextStyle(
        fontSize: 16, color: textPrimary, fontWeight: FontWeight.w400));

TextStyle bodyWhiteTextStyle = GoogleFonts.notoSans(
    textStyle: TextStyle(
        fontSize: 16, color: lightWhite, fontWeight: FontWeight.w400));

// button
TextStyle buttonTextStyle = GoogleFonts.notoSans(
    textStyle: TextStyle(
        fontSize: 14,
        color: textPrimary,
        letterSpacing: 1,
        fontWeight: FontWeight.w500));

// image DESC
TextStyle imageDescTextStyle =
    GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 12, color: ligthGray));

TextStyle imageDescTexWhitetStyle = GoogleFonts.notoSans(
    textStyle: TextStyle(fontSize: 12, color: lightWhite));

// Advanced
TextStyle titleIntroductionTextStyle = TextStyle(
    fontSize: 40,
    color: Colors.white,
    fontWeight: FontWeight.w800,
    // fontFamily: 'Yonsei'
    fontFamily: GoogleFonts.notoSans().fontFamily);
