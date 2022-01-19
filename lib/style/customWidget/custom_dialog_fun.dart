import 'package:bayan/style/customWidget/custm_button.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class CustomDialog {
  String ?title;
  IconData? icon;
  Color ?iconClr;
  String ?firstBtnTxt;
  String ?secondBtnTxt;
  bool ?disableDialog;

  CustomDialog(
      {required this.title,
      this.icon,
      this.iconClr,
      this.firstBtnTxt,
      this.disableDialog = true,
      this.secondBtnTxt});

  Scaffold design({Widget ?btnDesign,BoxConstraints ?constraints}) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r)
              ),
              width: constraints!.maxWidth -125.w,
              child: Wrap(
                spacing: 15,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  Icon(icon??Icons.error_outline,color:iconClr ?? MyColor().icnClrWrong,size: 40,),

                  Container(
                    width: constraints.maxWidth - 130.w,
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight / 2,
                    ),
                    child: SingleChildScrollView(
                      child: MyTextView(
                        text: title,
                        txSize: 12,
                        isAlgCenter: 1,
                      ),
                    ),
                  ),
                  btnDesign!,
                ],
              ),
            ),
          ),
    );
  }

  oneBtn({required GestureTapCallback firstFun,}){
    return Get.dialog(
        LayoutBuilder(
            builder: (context, screenSize) {
            return design(constraints: screenSize,btnDesign: MyButton(
                  buttonText: firstBtnTxt ??"اوكي",
                  widthSize: screenSize.maxWidth - 150.w,
                  buttonFun: () {
                    print("1212");
                    firstFun();
                    // Get.back();
                  }));
            }),
    transitionCurve: Curves.easeInOutCubic,
    useSafeArea: true,
    barrierDismissible:disableDialog!,
    barrierColor: Colors.black26,
    transitionDuration: Duration(milliseconds:800));
  }

  towBtns({Function() ?firstFun, Function() ?secondFun}) {
    return Get.dialog(LayoutBuilder(
        builder: (context, screenSize) {
      return design(constraints: screenSize,btnDesign: Container(
          width: screenSize.maxWidth-145.w,
          child: Row(
            children: [
              Expanded(
                child: MyButton(
                    horzPad: 5.w,
                    buttonText: firstBtnTxt ?? "اوكي",
                    buttonFun: () {
                      if (firstFun != null) firstFun();
                      Get.back();
                    }),
              ),
              Expanded(
                child: MyButton(
                    horzPad: 5.w,
                    buttonText: secondBtnTxt ?? "الغاء",
                    buttonColor: MyColor().whiteClr,
                    buttonFun: () {
                      if (secondFun != null) secondFun();
                      Get.back();
                    }),
              ),
            ],
          ),
        ));}),
        transitionCurve: Curves.easeInOutCubic,
        useSafeArea: true,
        barrierDismissible:disableDialog!,
        barrierColor: Colors.black26,
        transitionDuration: Duration(milliseconds:800)
    );
  }
}
