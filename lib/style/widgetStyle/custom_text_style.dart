import '../../dealWithScreenSize/responsbal_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextStyle {
  double fontSize;
  FontWeight fontWeight;
  Color textColor;
  MyTextStyle({this.fontSize=11,this.fontWeight=FontWeight.normal,this.textColor=Colors.black});
  TextStyle myTextStyle() {
    return TextStyle(
        color:textColor,
        fontSize:  SizeScreen.isSmallScreen()?fontSize:SizeScreen.isMediumScreen()?fontSize.sp-3.sp:(fontSize+3).sp,
        fontWeight: fontWeight,
        fontFamily: "Cairo",
        wordSpacing: 0.5,
        height: 1.9
    );
  }
}