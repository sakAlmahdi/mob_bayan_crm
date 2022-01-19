import 'dart:io';
import 'package:bayan/global/funcations.dart';
import 'package:bayan/helpr_model.dart';
import 'package:bayan/ui/splashScreens/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'internetChecker/check_net.dart';
import 'language/translate.dart';
import 'style/widgetStyle/theme_color_style.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Get.put(CheckInterNet(), permanent: true);
  Get.put(GtxFun(), permanent: true);
  runApp(ScreenUtilInit(
      designSize: const Size(480,853),
      builder:()=> GetMaterialApp(
          title: TranslateText.appName.tr,
          translations: Translation(),
          locale: const Locale("ar"),
          fallbackLocale: const Locale('ar'),
          debugShowCheckedModeBanner: false,
          theme: themeColor(),
          defaultTransition:Transition.fadeIn,
          home: SplashScreen(),
          getPages: MyAppPages.routes,
          unknownRoute:GetPage(name: MyRoutScreen.splash,page:()=>  SplashScreen())
  )));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

