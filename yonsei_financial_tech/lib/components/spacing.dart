import 'package:flutter/painting.dart';

// Margin
const EdgeInsets marginBottom12 = EdgeInsets.only(bottom: 12);
const EdgeInsets marginBottom24 = EdgeInsets.only(bottom: 24);
const EdgeInsets marginBottom40 = EdgeInsets.only(bottom: 40);
const EdgeInsets marginHorizontal300 = EdgeInsets.symmetric(horizontal: 300);
const EdgeInsets marginHorizontal20 = EdgeInsets.symmetric(horizontal: 20);
EdgeInsets marginHorizontal(double width) {
  return EdgeInsets.symmetric(horizontal: width * 0.2 * 0.4);
}

EdgeInsets marginH100V20 = EdgeInsets.symmetric(horizontal: 100, vertical: 20);

EdgeInsets marginH3V2(double width) {
  return EdgeInsets.symmetric(horizontal: width * 0.3, vertical: width * 0.2);
}

// Padding
const EdgeInsets paddingBottom24 = EdgeInsets.only(bottom: 24);
const EdgeInsets paddingTop100 = EdgeInsets.only(top: 100);
const EdgeInsets paddingHorizontal20 = EdgeInsets.symmetric(horizontal: 20);
const EdgeInsets paddingH20V20 =
    EdgeInsets.symmetric(horizontal: 20, vertical: 20);
