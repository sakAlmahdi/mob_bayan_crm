import 'package:bayan/language/translate.dart';
import 'package:bayan/style/customWidget/custom_dialog_fun.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:flutter/material.dart';
class GetDialogMsg {
  runTimeDialog({Function ?tryAgainFun}) {
    return CustomDialog(
            title: "لايوجد استجابة من السرفر",
            icon: Icons.cloud_off_outlined,
            iconClr: MyColor().icnClrSuccess,
            firstBtnTxt: "اعادة المحاولة")
        .towBtns(firstFun: () {
      tryAgainFun!();
    });
  }
  deleteWarningDialog({required Function deleteFun}) {
    return CustomDialog(
      title:"هل انت متاكد من الحذف",
      icon: Icons.delete,
      iconClr: MyColor().icnClrWrong,
      firstBtnTxt: "حذف",
    ).towBtns(firstFun: () {
      deleteFun();
    });
  }

}

