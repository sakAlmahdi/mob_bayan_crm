import 'package:bayan/global/funcations.dart';
import 'package:bayan/internetChecker/check_net.dart';
import 'package:bayan/spner_model.dart';
import 'package:bayan/ui/follow/follow_model.dart';
import 'package:bayan/ui/model/lookup.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FollowController extends GetxController {
  late List<SpinnerModels>followUpTypeList,purposeFollowList;
  late RxBool isEmptyFollow,isEmptyPurposeFollow,isEmptyCostomer,isLoading;
  late RxString followTypeTxt,followTypeNextTxt,purposeFollowTxt,costomerName;
  late RxInt idFollow,idFollowNext,idPurposeFollow,starts,idCostomer;
  late TextEditingController goleTxt,resultTxt,nextFollowDate,nextFollowTime;
late DateTime date;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading=false.obs;
    costomerName="".obs;
    idCostomer=0.obs;
    followTypeNextTxt="".obs;
    isEmptyCostomer=false.obs;
    resultTxt= TextEditingController();
    nextFollowTime= TextEditingController();
    nextFollowDate= TextEditingController();
    goleTxt= TextEditingController();
    idFollow=0.obs;
    starts=1.obs;
    idFollowNext=0.obs;
    idPurposeFollow=0.obs;
    followTypeTxt="".obs;
    purposeFollowTxt="".obs;
    isEmptyFollow=false.obs;
    isEmptyPurposeFollow=false.obs;
    followUpTypeList = List<SpinnerModels>.empty(growable: true).obs;
    purposeFollowList = List<SpinnerModels>.empty(growable: true).obs;
    getFollowTypeLst();
    getPurposeFollowLst();
  }
  getFollowTypeLst() async {
    if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      isEmptyFollow(true);
      await LookupModel().fetchFollowType(
        fullLstFun: (value){
          followUpTypeList.addAll(value);
          isEmptyFollow(false);
        },
        emptyLstFun: (){isEmptyFollow.value=true;},
      );
    }
  }
  getPurposeFollowLst() async {
    if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      isEmptyPurposeFollow(true);
      await LookupModel().fetchPurposeFollow(
        fullLstFun: (value){
          print(value.toString());
          purposeFollowList.addAll(value);
          isEmptyPurposeFollow(false);
        },
        emptyLstFun: (){
          isEmptyPurposeFollow.value=true;},
      );
    }
  }

   addFollow(){
     FollowUpModel(customerID:Get.find<GtxFun>().customerId.value,followDate:date.toString() ,followTime:"08:00:00" ,goal:goleTxt.text ,nextFollowDate:nextFollowDate.text,nextFollowTime:nextFollowTime.text,
         nextFollowTypeId:idFollowNext.value ,typeId:idFollow.value ,result:resultTxt.text ,interactionRange: starts.value ,targetId:idPurposeFollow.value ,).createFollow(successFun: (value){
     });
   }
  getDate(){
    BottomPicker.date(

      title:  "تاريخ المتابعة القادمة للعميل",
      titleStyle: const TextStyle(color:  Colors.indigo, fontSize:  15, fontWeight:  FontWeight.bold,),
      pickerTextStyle:  const TextStyle(color:  Colors.indigo, fontSize:  15, fontWeight:  FontWeight.bold,),
      // minDateTime: DateTime.now(),
      gradientColors: const [Colors.indigoAccent, Colors.indigo],
      bottomPickerTheme: BOTTOM_PICKER_THEME.blue,
      onSubmit: (val){
        nextFollowDate.text= DateFormat('yyyy-MM-dd').format(val).toString();
      },
      // initialDateTime:date=DateTime.now()
    ).show(Get.context!);
  }
  getTime(){
    BottomPicker.time(
      title: "وقت المتابعة القادمة للعميل",
      titleStyle: const TextStyle(color:  Colors.indigo, fontSize:  15, fontWeight:  FontWeight.bold,),
      pickerTextStyle:  const TextStyle(color:  Colors.indigo, fontSize:  15, fontWeight:  FontWeight.bold,),
      gradientColors: const [Colors.indigoAccent, Colors.indigo],
      bottomPickerTheme: BOTTOM_PICKER_THEME.blue,
      onSubmit: (val){
        nextFollowTime.text= DateFormat('KK:mm  a').format(val).toString();
      },
    ).show(Get.context!);
  }
}