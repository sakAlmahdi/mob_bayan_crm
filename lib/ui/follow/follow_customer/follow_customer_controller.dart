import 'package:bayan/global/funcations.dart';
import 'package:bayan/ui/follow/follow_customer/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowCustomerController extends GetxController with StateMixin<List<FollowsModel>> {
  late List<FollowsModel>coustomerData;
  late RxBool isEmptyCostomer;
  late RxString idCustomer;
  late TextEditingController followDate;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idCustomer="0".obs;
    followDate =TextEditingController();
    isEmptyCostomer=false.obs;
    coustomerData = List<FollowsModel>.empty(growable: true).obs;
    ever(idCustomer, (callback)
    {
      if(idCustomer.value!="0") {
        getCoustomerFollows(id: Get
          .find<GtxFun>()
          .customerId
          .value);
      }
    });
  }
  getCoustomerFollows({required String id}){
    change(null,status: RxStatus.loading());
    coustomerData.clear();
    FollowsModel( ).fetchFollows(id: id,
        fullLstFun: (value){
          coustomerData.addAll(value);
          change(coustomerData,status: RxStatus.success());
        },
        emptyLstFun: (){
          change([],status: RxStatus.empty());
        },
        errorFun:(error) {
          change([], status: RxStatus.error());});
  }
  goBack(){
    Get.back();
    idCustomer.value="0";
    // Get.find<GtxFun>().customerId.value="0";
  }
}