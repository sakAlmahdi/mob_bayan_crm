
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomSnackBar{
  String snackMsg;
  CustomSnackBar({required this.snackMsg});
   getSnack(){
    return Get.showSnackbar(GetBar(
      messageText: MyTextView(
        text: snackMsg,
        txClr: MyColor().whiteClr,
        isAlgCenter: 1,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin:const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 5000),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      backgroundGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          MyColor().btnClr,
          MyColor().btnClr.withOpacity(0.6),
        ],
      ),
      borderRadius: 20.r,
      reverseAnimationCurve: Curves.easeOutBack,
      forwardAnimationCurve: Curves.easeOutBack,
      animationDuration: Duration(seconds: 2),
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      snackPosition: SnackPosition.TOP,
    ));
  }
}

class ErrorSnackBar{
  String errorMsg;
  ErrorSnackBar({required this.errorMsg});
   getSnack(){
    return Get.showSnackbar(
        GetBar(
      messageText: Wrap(
        alignment: WrapAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 5.w),
            alignment: Alignment.center,
            width: errorMsg.length<=29?Get.context!.width/2.5:errorMsg.length<=60?Get.context!.width/1.5:Get.context!.width,
            decoration: BoxDecoration(
                color: Colors.red.shade700,
              borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20.r),topLeft:Radius.circular(20.r))
            ),
            constraints: BoxConstraints(
              minHeight: 48,
              maxWidth: Get.context!.width/1.1
            ),
            child: MyTextView(
              text: errorMsg,
              txClr: MyColor().whiteClr,
              isAlgCenter: 1,
            ),
          ),
        ],
      ),
      padding:const EdgeInsets.symmetric(vertical: 10),
      margin:const EdgeInsets.only(top: 50),
      duration: const Duration(milliseconds: 5000,),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.transparent,
      reverseAnimationCurve: Curves.easeOutBack,
      forwardAnimationCurve: Curves.easeOutBack,
      animationDuration: const Duration(milliseconds: 500),
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      snackPosition: SnackPosition.TOP,
    ));
  }
}

