import 'package:bayan/global/funcations.dart';
import 'package:bayan/spner_model.dart';
import 'package:bayan/style/customWidget/custm_snack_bar.dart';
import 'package:bayan/ui/coustomer/add_customer_view.dart';
import 'package:bayan/ui/model/get_coustomer.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FollowTodayController extends GetxController with StateMixin<List<CoustomerModel>>{
  late List<SpinnerModels>costomerList;
  late List<CoustomerModel>coustomerData;
  late RxBool isEmptyCostomer;
  late TextEditingController followDate;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    followDate =TextEditingController();
    isEmptyCostomer=false.obs;
    costomerList = List<SpinnerModels>.empty(growable: true).obs;
    coustomerData = List<CoustomerModel>.empty(growable: true).obs;
    followDate.text=DateTime.now().toString();
    getCoustomerFollow(followDate.text);
    // getDate();
  }
  getCoustomerFollow(String date){
    change(null,status: RxStatus.loading());
    coustomerData.clear();
      CoustomerModel( ).fetchCoustomerFollow(date: date,
          fullLstFun: (value){
            coustomerData.addAll(value);
            change(coustomerData,status: RxStatus.success());
          },
          emptyLstFun: (){
            change([],status: RxStatus.empty());
          },
          errorFun:(error) {
            change([], status: RxStatus.error());
            // GetDialogMsg().runTimeDialog(tryAgainFun: () => getCoustomerFollow(followDate.text));
            ErrorSnackBar(errorMsg: error.toString() ).getSnack();
      });
  }

  getDate(){
    BottomPicker.date(
      title:  "تاريخ المتابعة ",
      titleStyle: const TextStyle(color:Color(0xFF0F8361), fontSize:  15, fontWeight:  FontWeight.bold,),
      pickerTextStyle:  const TextStyle(color:Color(0xFF0F8361), fontSize:  15, fontWeight:  FontWeight.bold,),
      // minDateTime: DateTime.now(),
      gradientColors: const [Colors.green,Color(0xFF0F8361)],
      bottomPickerTheme: BOTTOM_PICKER_THEME.blue,
      onSubmit: (val){
        followDate.text= DateFormat('yyyy-MM-dd').format(val).toString();
        getCoustomerFollow(followDate.text.toString());
      },
    ).show(Get.context!);
  }
  showCustomer({String? id="0"}){
    Get.find<GtxFun>().customerId.value=id!;
    Get.to(AddCustomerView());
  }
}