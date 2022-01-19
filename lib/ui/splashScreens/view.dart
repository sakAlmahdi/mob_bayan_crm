import 'package:bayan/global/funcations.dart';
import 'package:bayan/global/global_data.dart';
import 'package:bayan/global/models_lst.dart';
import 'package:bayan/helpr_model.dart';
import 'package:bayan/internetChecker/check_net.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetStorage storage = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () async {
      Get.put(GtxFun(), permanent: true).changLanguageFun(
          storage.read(GetStorageText.languageSelect) ?? 'عربي');
      Get.put(CheckInterNet(), permanent: true);
      String rememberMe = "${storage.read(GetStorageText.rememberMe)}";
      if (rememberMe == "true") {
        Get.offAllNamed(MyRoutScreen.home);
      } else {
        Get.offAllNamed(MyRoutScreen.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ModelsList(), permanent: true);
    return Image.asset('asset/img/splash.jpg',fit: BoxFit.fill,);
  }
}
