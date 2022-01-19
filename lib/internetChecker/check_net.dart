import 'dart:async';
import 'package:bayan/spner_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CheckInterNet extends GetxService{
    late RxBool spinnerSearchStart;
  late List<dynamic> spinnerSearchLst;
  var connectionInterNet = 0.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult>_connectivitySubscription;
  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    spinnerSearchStart=false.obs;
    spinnerSearchLst=  List<dynamic>.empty(growable: true).obs;
    initConnectivity();
    _connectivitySubscription=_connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  Future<void>initConnectivity()async{
    late ConnectivityResult connectivityResult;
    try{
      connectivityResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (e)
    {
      print(e.toString());
    }
    return _updateConnectivityStatus(connectivityResult);
  }
  _updateConnectivityStatus(ConnectivityResult result){
    switch(result){
      case ConnectivityResult.none:connectionInterNet.value=0;break;
      case ConnectivityResult.wifi:connectionInterNet.value=1;break;
      case ConnectivityResult.mobile:connectionInterNet.value=2;break;
      default:connectionInterNet.value=3;break;

    }
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _connectivitySubscription.cancel();
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:simple_connection_checker/simple_connection_checker.dart';
//
//
// class CheckNet extends GetxService{
//   late RxBool spinnerSearchStart;
//   late List<dynamic> spinnerSearchLst;
//   RxBool interNet = false.obs;
//   late RxString language ;
//   late SimpleConnectionChecker simpleConnectionChecker=SimpleConnectionChecker()..setLookUpAddress('pub.dev') ;
//   StreamSubscription? subscription;
//   @override
//   void onInit()async {
//     // TODO: implement onInit
//     super.onInit();
//     spinnerSearchStart=false.obs;
//     spinnerSearchLst=  List<dynamic>.empty(growable: true).obs;
//     Get.updateLocale(const Locale("ar", "YE"));
//     language='عربي'.obs;
//     print("\n\n\n\n${Get.deviceLocale}\n\n\n\n");
//     subscription=simpleConnectionChecker.onConnectionChange.listen((connected){
//       interNet.value=connected;
//       print(interNet.value);
//     });
//   }
//   changeLanguage(String lang){
//     language.value=lang;
//     if(lang=='عربي') {
//       Get.updateLocale(const Locale("ar", "YE"));
//     } else {
//       Get.updateLocale(const Locale("en", "US"));
//     }
//
//   }
//   @override
//   void onReady() {
//     // TODO: implement onReady
//     super.onReady();
//     changeLanguage(Get.deviceLocale.toString().contains("ar")?'عربي':'English');
//   }
// }