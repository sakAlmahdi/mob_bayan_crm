import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustmCheckBox extends StatelessWidget {
  final String checkTxt;
  final bool checkVal;
  final Function? checkFun;
  // final GestureTapCallback checkFun;
  final MainAxisAlignment mainAxis;
  final double ?textSize;
  const CustmCheckBox({Key ?key, required this.checkVal,  this.checkFun, required this.checkTxt,this.mainAxis=MainAxisAlignment.start, this.textSize});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxis,
      children: [
        Checkbox(
          value: checkVal, onChanged: checkFun!() ,activeColor: MyColor().btnClr,materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,)
        ,MyTextView(text: checkTxt,txSize: textSize,),
      ],
    );
  }
}