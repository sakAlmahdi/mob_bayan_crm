import 'package:bayan/global/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class GtxFun extends GetxService {
  late List<String> myLanguageLst;
  late RxString myLanguageSelect ,languageSelectedCode,customerId;
  late RxInt customerScreen;
  late RxBool switchBtn;
  GetStorage storage= GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    switchBtn=true.obs;
    customerScreen=0.obs;
    myLanguageSelect='عربي'.obs;
    customerId='0'.obs;
    languageSelectedCode='ar-YE'.obs;
    myLanguageLst=['عربي','English'];
  }

  changLanguageFun(String newLang)async{
   myLanguageSelect(newLang);
   languageSelectedCode.value = newLang == 'عربي'?"ar-YE":"en-GP";
     Get.updateLocale(Locale(newLang=='عربي'?'ar':"en"));
   storage.write(GetStorageText.languageSelect, newLang.trim());
  }
  }