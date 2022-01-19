
import 'package:bayan/internetChecker/check_net.dart';
import 'package:bayan/style/customWidget/check_net.dart';
import 'package:bayan/style/customWidget/custm_button.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/customWidget/custom_circular_progress.dart';
import 'package:bayan/style/widgetStyle/custm_logo_style.dart';
import 'package:bayan/ui/login/controller_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final _controller = Get.put(LoginController());
   LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,title: const MyTextView(text: "تسجيل",txSize: 18,),elevation: 0,),
        body: Stack(
            children: [
              Form(
                  key: _controller.loginFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: _buildPortrait()),
              Obx(() => _controller.isLoading.value
                  ?  CenterProgress()
                  : const SizedBox()),
            ],
        ));
  }

  Widget _buildPortrait(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0),
      child: ListView(
            children: [_customLogo(4),
          _customInputText(),
          _customBtn(),
        ],
      ),
    );
  }

  Column _customInputText(){
    return Column(
      children: [
        MyTextInput(
          isRequired: 1,
          textEditingController:
          _controller.memberNum,
          labelText: "الاسم",
          icon: Icons.person_outline_outlined,
        ),
        MyPasswordTxtFld(textEditingController: _controller.password, isLogin: true,),
        // Container(
        //   padding:
        //   EdgeInsets.symmetric(vertical: 5.h),
        //   width: double.infinity,
        //   alignment: Alignment.center,
        //   child:Obx(()=>CustmCheckBox(
        //     checkTxt: LoginTxtTrns.RememberMeTxt,
        //     checkVal: _controller.rememberMe.value,
        //     checkFun: (checkBoxValue){
        //       _controller.rememberMe.value=checkBoxValue;
        //     },),
        //   ),
        // ),
      ],
    );
  }

  MyButton _customBtn(){
    return MyButton(
        widthSize: Get.context!.width,
        buttonText: "دخول",
        txtSize: 16,
        buttonFun: (){
          _controller.loginBtnFun();}
          );
  }

  MyLogo _customLogo(int imgSize){
    return  MyLogo(
      logoWth: Get.context!.width / imgSize,
      bgImage: 'asset/img/splash.jpg',
    );
  }
}