
import 'package:bayan/ui/home/view_home.dart';
import 'package:bayan/ui/login/screen_login.dart';
import 'package:bayan/ui/registr/registr_screen.dart';
import 'package:bayan/ui/splashScreens/view.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

abstract class MyRoutScreen{
  static const splash="/gsd";
  static const login="/LoginScreen";
  static const home="/HomeView";

}

class MyAppPages{
  static final  routes= [
    GetPage(name: MyRoutScreen.splash , page:()=>SplashScreen(),transition: Transition.zoom,),
    GetPage(name: MyRoutScreen.home,page:()=>   MyTabbedPage()),
    GetPage(name: MyRoutScreen.login,page:()=>  LoginScreen(),transition: Transition.cupertinoDialog),
  ];
}