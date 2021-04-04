import 'package:flutter/material.dart';

Text makeSmallTitle(final text, BuildContext context,
    {Color color, FontWeight fontWeight, double fontSize}) {
  return Text(
    text,
    style: TextStyle(
        color: color != null ? color : Colors.black,
        fontWeight: fontWeight != null ? fontWeight : FontWeight.bold,
        fontSize: fontSize != null && context != null
            ? fontSize
            : MediaQuery.of(context).size.width * 0.01),
        textAlign: TextAlign.center,
  );
}
