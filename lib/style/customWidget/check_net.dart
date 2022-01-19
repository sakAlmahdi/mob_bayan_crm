import 'package:bayan/internetChecker/check_net.dart';
import 'package:bayan/language/translate.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CheckNetAndProgressFotFetchData extends StatelessWidget {
  final Color ? icnClr;
  final Color ? txtClr;
  const CheckNetAndProgressFotFetchData({Key? key,this.icnClr=Colors.grey, this.txtClr=Colors.black}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(()=> Get.find<CheckInterNet>().connectionInterNet.value!=0?
    const Center(child:CircularProgressIndicator(color: Colors.orangeAccent,))
        :Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.wifi_off_sharp,size:40,color:icnClr ),
        MyTextView(text: "لا يوجد اتصال بالانترنت",txClr:txtClr)
      ],
    ));
  }
}