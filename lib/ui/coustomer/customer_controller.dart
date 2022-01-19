import 'package:bayan/internetChecker/check_net.dart';
import 'package:bayan/spner_model.dart';
import 'package:bayan/style/customWidget/custm_snack_bar.dart';
import 'package:bayan/ui/home/lookup_by_id_group.dart';
import 'package:bayan/ui/model/city.dart';
import 'package:bayan/ui/model/country.dart';
import 'package:bayan/ui/model/create_coustomer.dart';
import 'package:bayan/ui/model/lookup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController{
  GlobalKey<FormState> globalFormKey = GlobalKey();
  late List<SpinnerModels> customerActivityLst,customerTypeList,customerStateList,countryList,cityList,areaList,followUpTypeList,typeServiceRequireList ;
  late RxString haveSystemValue;
  String customerTypeValue = "عادي";
  String customerStateValue = "نشط";
  late TextEditingController facilityName,ownerName,employeeName,employeeAttribute,governorate,directorate,street,phoneNumber1,phoneNumber2;
  late TextEditingController nameSystem,systemCons,systemAdvantages,reactionRate,customerType,requiredSystemType,explanationRequiredSystem,customerCase,
      rightTimeToFollow,followUpType;
  late RxInt start,id,cityId,areaId,facilityTypeId,countryId,customerTypeId,typeServiceRequireId;
  late RxString facilityType,customerTypeTxt,customerStateTxt,countryTxt,namejope,cityTxt,areaTxt,followTypeTxt,typeServiceRequireTxt ;
  late RxBool isEmpty,isEmptyCountry,isEmptyCity,isEmptyCustomerType,isEmptyCustomerStateid,isEmptyTypeServiceRequireList ;
  late RxBool  isEmptyFacilityType;

  @override
  void onInit() {
    customerActivityLst = List<SpinnerModels>.empty(growable: true).obs;
    typeServiceRequireList = List<SpinnerModels>.empty(growable: true).obs;
    customerTypeList = List<SpinnerModels>.empty(growable: true).obs;
    customerStateList = List<SpinnerModels>.empty(growable: true).obs;
    countryList = List<SpinnerModels>.empty(growable: true).obs;
    cityList = List<SpinnerModels>.empty(growable: true).obs;
    followUpTypeList = List<SpinnerModels>.empty(growable: true).obs;
    areaList = List<SpinnerModels>.empty(growable: true).obs;
    typeServiceRequireTxt="".obs;
    areaTxt="".obs;
    facilityTypeId=0.obs;
    isEmptyTypeServiceRequireList=false.obs;
    cityId=0.obs;
    areaId=0.obs;
    typeServiceRequireId=0.obs;
    customerTypeId=0.obs;
    isEmptyCustomerType=false.obs;
    isEmptyCustomerStateid=false.obs;
    isEmptyFacilityType=false.obs;
    isEmptyCountry=false.obs;
    isEmpty=false.obs;
    isEmptyCity=false.obs;
    start=1.obs;
    id=0.obs;
    countryId=0.obs;
    facilityType=''.obs;
    customerTypeTxt=''.obs;
    customerStateTxt=''.obs;
    countryTxt=''.obs;
    namejope=''.obs;
    cityTxt=''.obs;
    followTypeTxt=''.obs;
    haveSystemValue = "نعم".obs;
    facilityName =TextEditingController();
    ownerName =TextEditingController();
    employeeName =TextEditingController();
    employeeAttribute =TextEditingController();
    governorate =TextEditingController();
    directorate =TextEditingController();
    street =TextEditingController();
    phoneNumber1 =TextEditingController();
    phoneNumber2 =TextEditingController();
    ///

    nameSystem =TextEditingController();
    systemCons =TextEditingController();
    systemAdvantages =TextEditingController();
    reactionRate =TextEditingController();
    customerType =TextEditingController();
    requiredSystemType =TextEditingController();
    explanationRequiredSystem =TextEditingController();
    customerCase =TextEditingController();
    rightTimeToFollow =TextEditingController();
    followUpType =TextEditingController();
    if(typeServiceRequireList.isEmpty)getTypeServiceRequiredLst();
    getCustomerActivityLst();
    getCustomerTypeLst();
    getCustomerStateLst();
    getCountryLst();
    super.onInit();
  }
  getCustomerActivityLst() async {
    if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      print("121");
      isEmptyFacilityType(true);
   await LookupByIdGrpModel().fetchCustomerActivity(
      fullLstFun: (value){
        customerActivityLst.addAll(value);
        isEmptyFacilityType(false);
      },
      emptyLstFun: (){isEmptyFacilityType.value=true;},
    );
    }
  }
  getCustomerTypeLst() async {
    if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      print("121");
      isEmptyCustomerType(true);
      // customerActivityLst.clear();
   await LookupByIdGrpModel().fetchCustomerType(
      fullLstFun: (value){
        customerTypeList.addAll(value);
        isEmptyCustomerType(false);
      },
      emptyLstFun: (){isEmptyCustomerType.value=true;},
    );
    }
  }
  getCustomerStateLst() async {
    if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      isEmptyCustomerStateid(true);
   await LookupByIdGrpModel().fetchCustomerStatus(
      fullLstFun: (value){
        customerStateList.addAll(value);
        isEmptyCustomerStateid(false);
      },
      emptyLstFun: (){isEmptyCustomerStateid.value=true;},
    );
    }
  }
  getCountryLst() async {
    if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      isEmptyCountry(true);
   await CountryModel().fetchCountry(
      fullLstFun: (value){
        countryList.addAll(value);
        isEmptyCountry(false);
      },
      emptyLstFun: (){isEmptyCountry.value=true;},
    );
    }
  }
  getCityLst() async {
    isEmptyCity(true);
    if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      cityList.clear();
   await CityModel(id:countryId.value ).fetchCity(
      fullLstFun: (value){
        cityList.addAll(value);
        isEmptyCity(false);
      },
      emptyLstFun: (){
        isEmptyCity(true);
        },
    );
    }
  }
  getAreaLst() async {
    isEmptyCity(true);
    if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      areaList.clear();
   await CityModel(id:cityId.value ).fetchArea(
      fullLstFun: (value){
        areaList.addAll(value);
        isEmptyCity(false);
      },
      emptyLstFun: (){
        isEmptyCity(true);
        },
    );
    }
  }
  getTypeServiceRequiredLst() async {
    if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      isEmptyTypeServiceRequireList(true);
      customerActivityLst.clear();
      await LookupModel().fetchTypeServiceRequire(
        fullLstFun: (value){
          typeServiceRequireList.addAll(value);
          isEmptyTypeServiceRequireList(false);
        },
        emptyLstFun: (){isEmptyTypeServiceRequireList.value=true;},
      );
    }
  }

  void saveFun(){
    // FocusManager.instance.primaryFocus?.unfocus();
    if (globalFormKey.currentState!.validate()) {
      CreateCustomerModel(id: "00000000-0000-0000-0000-000000000000",name:employeeName.text,countryID:  countryId.value,cityID: cityId.value,currentSystem:nameSystem.text,
          haveSystem:haveSystemValue.value=="نعم"?true:false,phone:phoneNumber1.text,mobile: phoneNumber2.text,street: street.text,requirments: explanationRequiredSystem.text,
      categoryID:0 ,estimateAmount: 0,status:0,contactJob:"770230104",areaID: areaId.value,regionID: areaId.value,contactName:ownerName.text,activityID: 1,mapPoint1: "110020",mapPoint2: "12012",
      ).addCustomerFun(clearModel: clearData);
    }else {
      ErrorSnackBar(errorMsg: "هناك حقول ضرورية").getSnack();
    }

  }
  void haveSystemFun(value) {
    haveSystemValue.value = value;
    update();
  }
  void customerTypFun(value) {
    customerTypeValue = value;
    update();
  }
  void customerStateFun(value) {
    isEmpty.value=true;
    customerStateValue = value;
    update();
  }
  clearData() {
  }
}