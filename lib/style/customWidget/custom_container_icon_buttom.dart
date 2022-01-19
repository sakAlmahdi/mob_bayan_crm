import 'package:bayan/dealWithScreenSize/responsbal_screen_size.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomHomBtm extends StatelessWidget {
  final String ?txt1;
  final int ?val1;
  final String ?txt2;
  final int ?val2;
  final IconData ?icon1;
  final String ?screenName;
  final int ?isLargWidth;
  final Function ?btnFun;
  final Color ?btnClr;

  const CustomHomBtm(
      {Key ?key,
        this.txt1,
        this.icon1,
        this.screenName,
        this.isLargWidth,
        this.btnFun, this.btnClr=Colors.indigo, this.txt2, this.val1, this.val2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        btnFun != null
            ? btnFun!()
            : Get.toNamed(screenName!);
      },
      child: Column(
        children: [
          Container(
            height: SizeScreen.isSmallScreen()?60:Get.width/8,
            width: SizeScreen.isSmallScreen()?108:Get.width/3.2,
            margin: const EdgeInsets.only(top: 5,right: 5,left:5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color:btnClr),
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   MyTextView(text: val1.toString(),txSize: 13,txClr: Colors.white,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyTextView(
                        text: txt1,
                        txSize:11,txClr: MyColor().whiteClr,
                        isAlgCenter: 1,
                      ),
                      Icon(Icons.add_task,size:SizeScreen.isSmallScreen()?18:35 ,color: MyColor().whiteClr,),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 2,
            // shape:  RoundedRectangleBorder(side:BorderSide(width: 1,color:btnClr??Colors.transparent) ),
            color:Colors.white,
            child: Container(
              height: SizeScreen.isSmallScreen()?75:Get.width/6,
              // height: SizeScreen.isSmallScreen()?70:100,
              width: SizeScreen.isSmallScreen()?108:Get.width/3.2,
              // width: SizeScreen.isSmallScreen()?108:128,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  // color:Colors.white
              ),
              child: Stack(alignment: Alignment.center,
                children: [
                  Icon(icon1,size: 100.r,color: Colors.black12,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       MyTextView(text: val2.toString(),txSize: 30,),
                      MyTextView(
                        text: txt2,
                        txSize:13,
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}