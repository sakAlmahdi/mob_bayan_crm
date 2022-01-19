import 'package:bayan/dealWithScreenSize/responsbal_screen_size.dart';
import 'package:flutter/material.dart';

// @immutable
class CoustomTextStyle extends TextStyle {
  final Color clr;
  final String fntFamily;
  final double fntSize;
  final FontWeight fntWeigh;
  final TextDecoration? txtDecorion;
  const CoustomTextStyle({
    this.clr = Colors.black,
    this.fntFamily = 'Cairo',
    this.fntSize = 12,
    this.fntWeigh = FontWeight.w400,
    this.txtDecorion=TextDecoration.none
  });

  TextStyle setTextStyle() {
    return TextStyle(
      decoration:txtDecorion,
      color: clr,
      letterSpacing: 1.3,
      fontFamily: fntFamily,
      fontWeight: fntWeigh,
      fontSize: SizeScreen.isSmallScreen() ? fntSize : fntSize + 2,
    );
  }
}
