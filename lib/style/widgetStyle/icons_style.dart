import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:flutter/material.dart';
class CustomIcons {
  Widget myIcon({required IconData myIcons, Color ?icnClr, double ?iconSiz}) {
    return Icon(
      myIcons,
      size: iconSiz,
      color: icnClr ?? MyColor().btnClr,
    );
  }
}
