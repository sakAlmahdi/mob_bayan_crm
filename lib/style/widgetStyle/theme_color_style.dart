import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData themeColor() {
  return ThemeData(
    primaryColor: const Color(0xFF0F8361),
    primarySwatch: Colors.teal,
    primaryColorDark: const Color(0xFF0F8361),
    primaryColorLight: const Color(0xFF0F8361),
    hintColor: const Color(0xFF0F8361),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: ThemeData.light().textTheme.copyWith(
        button: TextStyle(
            color:Colors.black,fontSize: 11.sp,fontWeight: FontWeight.bold,fontFamily: "Cairo"
        )
    ),
    splashColor:   const Color(0xFF0F8361),
  );
}

