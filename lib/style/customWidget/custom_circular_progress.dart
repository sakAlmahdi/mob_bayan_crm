import 'package:bayan/internetChecker/check_net.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'custm_text_fild.dart';

class CustomProgressBar extends StatelessWidget {
  final String progressTitle;
  const CustomProgressBar({Key ?key, this.progressTitle=""});
  @override
  Widget build(BuildContext context) {
    // Get.defaultDialog(title: "wqdqd",content: Center(child: CircularProgressIndicator(),));

    return Container(
      alignment: Alignment.center,
      height: context.height,
      width: context.width,
      color: Colors.black.withOpacity(0.5),
      child:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow:  [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        height: context.height/6,
        width: context.width/1.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            progressTitle.isNotEmpty?MyTextView(text:progressTitle.tr,):SizedBox(),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}


class CenterProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: Get.context!.width,
      height:Get.context!.height,
      color: Colors.black12,
      child: SizedBox(width: 100.r,height: 100.r,child: LoadingIndicator(indicatorType: Indicator.squareSpin ,backgroundColor: Colors.green,colors: [MyColor().btnClr.withOpacity(0.6)],)),
    );
  }
}
class CheckTxtDataProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 35.h),
      width: double.infinity,
      height:70.h,
      color: Colors.transparent,
      child: LoadingIndicator(indicatorType: Indicator.ballRotateChase ,colors: [Colors.teal,MyColor().btnClr.withOpacity(0.6)]),
    );
  }
}

class SpinnerProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.r),
        color: Colors.black12,
      ),
      child: Obx(()=> Get.find<CheckInterNet>().connectionInterNet.value!=0? SizedBox(height: 50.r,width: 50.r,child: LoadingIndicator(indicatorType: Indicator.ballBeat,colors: [Colors.teal,MyColor().btnClr.withOpacity(0.6)]))
          : Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.wifi_off_sharp),
        MyTextView(text:"لا يوجد اتصال بالانترنت",isAlgCenter: 1,txSize: 10.sp,)
      ],
    )) );
  }
}

class ImageProgress extends StatelessWidget {
  final Color progressClr;
  const ImageProgress({Key ?key, this.progressClr:Colors.teal});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60.r,
      width: 60.r,
      child: LoadingIndicator(indicatorType: Indicator.ballScaleMultiple,colors: [progressClr,progressClr.withOpacity(0.5)]),
    );
  }
}
