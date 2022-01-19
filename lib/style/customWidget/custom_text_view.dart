import 'package:auto_size_text/auto_size_text.dart';
import '../../dealWithScreenSize/responsbal_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTxtView extends StatelessWidget {
  const CustomTxtView({Key? key, this.text='', this.centerTxt=false, this.txClr=Colors.black, this.txSize=10, this.txtFontWeight=FontWeight.normal}):super(key: key);

  final String text;
  final bool centerTxt;
  final double txSize;
  final Color txClr;

  final FontWeight txtFontWeight;

  @override
  Widget build(BuildContext context) {
    return
      AutoSizeText(
        text,
        minFontSize: 9,
        maxFontSize:16,
        softWrap: true,
        wrapWords: true,
        textAlign:  centerTxt? TextAlign.center : TextAlign.start,
        style:TextStyle(color:txClr,fontSize:SizeScreen.isSmallScreen()?txSize:txSize.sp,fontWeight:txtFontWeight,fontFamily: "Cairo",) ,
      );
  }
}