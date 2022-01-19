import 'package:bayan/global/funcations.dart';
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

class AddCustomerController extends GetxController with StateMixin<List>{
  GlobalKey<FormState> globalFormKey = GlobalKey();
  late CreateCustomerModel selectCostomer;
  late List<SpinnerModels> customerActivityLst,customerTypeList,customerStateList,countryList,cityList,areaList,typeServiceRequireList ;
  String customerTypeValue = "عادي";String customerStateValue = "نشط";
  late TextEditingController facilityName,ownerName,employeeName,street,phoneNumber1,phoneNumber2,nameSystem,systemCons,systemAdvantages,explanationRequiredSystem;
  late RxInt cityId,areaId,facilityTypeId,countryId,customerTypeId,typeServiceRequireId;
  late RxString facilityType,customerTypeTxt,countryTxt,cityTxt,areaTxt,typeServiceRequireTxt,mapPoint1,mapPoint2,haveSystemValue,costomerUpdate ;
  late RxBool isEmptyCountry,isEmptyCity,isEmptyCustomerType,isEmptyCustomerStateid,isEmptyTypeServiceRequireList,isLoading,isEmptyFacilityType;
  @override
  void onInit() {
    facilityTypeId=0.obs;
    cityId=0.obs;
    areaId=0.obs;
    typeServiceRequireId=0.obs;
    customerTypeId=0.obs;
    countryId=0.obs;

    customerActivityLst = List<SpinnerModels>.empty(growable: true).obs;
    typeServiceRequireList = List<SpinnerModels>.empty(growable: true).obs;
    customerTypeList = List<SpinnerModels>.empty(growable: true).obs;
    customerStateList = List<SpinnerModels>.empty(growable: true).obs;
    countryList = List<SpinnerModels>.empty(growable: true).obs;
    cityList = List<SpinnerModels>.empty(growable: true).obs;
    areaList = List<SpinnerModels>.empty(growable: true).obs;
    typeServiceRequireTxt="".obs;
    areaTxt="".obs;
    costomerUpdate="0".obs;
    mapPoint1="12012".obs;
    mapPoint2="12012".obs;
    isEmptyTypeServiceRequireList=false.obs;
    isLoading=false.obs;
    isEmptyCustomerType=false.obs;
    isEmptyCustomerStateid=false.obs;
    isEmptyFacilityType=false.obs;
    isEmptyCountry=false.obs;
    isEmptyCity=false.obs;
    facilityType=''.obs;
    customerTypeTxt=''.obs;
    countryTxt=''.obs;
    cityTxt=''.obs;
    haveSystemValue = "نعم".obs;
    facilityName =TextEditingController();
    ownerName =TextEditingController();
    employeeName =TextEditingController();
    street =TextEditingController();
    phoneNumber1 =TextEditingController();
    phoneNumber2 =TextEditingController();
    nameSystem =TextEditingController();
    systemCons =TextEditingController();
    systemAdvantages =TextEditingController();
    explanationRequiredSystem =TextEditingController();
    phoneNumber2.text="0";
    if(typeServiceRequireList.isEmpty)getTypeServiceRequiredLst();
    getCustomerActivityLst();
    getCustomerTypeLst();
    getCustomerStateLst();
    getCountryLst();
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (Get.find<GtxFun>().customerScreen.value != 0) {
      getSelectCostomer(id:Get.find<GtxFun>().customerId.value );
    } else {
      change([], status: RxStatus.success());
    }
    ever(costomerUpdate, (_){
      if(Get.find<GtxFun>().customerScreen.value != 0){
        print("editedit");
        getSelectCostomer(id:Get.find<GtxFun>().customerId.value );
      }else{
        print("3");
        change([], status: RxStatus.success());
      }
    });
  }
  getSelectCostomer({required String id}) {
    change([], status: RxStatus.loading());
    if (Get.find<CheckInterNet>().connectionInterNet.value != 0) {
      selectCostomer=CreateCustomerModel();
      CreateCustomerModel(id:id).fetchCustomerById(
          fullLstFun: (value){
            selectCostomer=value;
            // facilityName.text=value.name!;
            // countryId.value=value.countryID!;
            // cityId.value=value.cityID??0;
            // areaId.value=value.regionID??0;
            haveSystemValue.value=value.haveSystem==true?"نعم":"لا";
            street.text=value.street!;
            phoneNumber1.text=value.mobile!;
            phoneNumber2.text=value.phone!;
            ownerName.text=value.contactName!;
            employeeName.text=value.name!;
            mapPoint1.value=value.mapPoint1!;
            mapPoint2.value=value.mapPoint2!;
            systemCons.text=value.currentIssues??"";
            nameSystem.text=value.currentSystem??"";
            explanationRequiredSystem.text=value.requirments??"";
            change([], status: RxStatus.success());
          },
          errorFun: (error){
            change(error, status: RxStatus.error());
          });
    }
  }

  getCustomerActivityLst() async {
    if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
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
      emptyLstFun: (){isEmptyCity(true);},
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
    FocusManager.instance.primaryFocus?.unfocus();
    if (globalFormKey.currentState!.validate()) {
      isLoading(true);
      CreateCustomerModel(id:Get.find<GtxFun>().customerScreen.value==0? "00000000-0000-0000-0000-000000000000":Get.find<GtxFun>().customerId.value,name:employeeName.text,countryID:  countryId.value,cityID: cityId.value,currentSystem:nameSystem.text,
         currentIssues: systemCons.text, haveSystem:haveSystemValue.value=="نعم"?true:false,phone:phoneNumber2.text,mobile:phoneNumber1.text,street: street.text,requirments: explanationRequiredSystem.text,
      categoryID:0 ,estimateAmount: 0,status:0,contactJob:phoneNumber1.text,areaID: areaId.value,regionID: areaId.value,contactName:ownerName.text,activityID: 1,mapPoint1: mapPoint1.value,mapPoint2: mapPoint2.value,
      ).addCustomerFun(clearModel: clearData);
    }else {
      ErrorSnackBar(errorMsg: "هناك حقول ضرورية").getSnack();
    }
  }
  goBack(){
    Get.find<GtxFun>().customerScreen.value=0;
    clearData();
    Get.back();
    costomerUpdate.value="0";
    Get.find<GtxFun>().customerId.value="0";
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
    isEmptyCustomerStateid.value=true;
    customerStateValue = value;
    update();
  }
  clearData() {
    areaId.value=0;
    cityId.value=0;
    countryId.value=0;
    facilityTypeId.value=0;
    typeServiceRequireId.value=0;
    customerTypeId.value=0;
    street.clear();
    phoneNumber1.clear();
    nameSystem.clear();
    phoneNumber2.clear();
    ownerName.clear();
    employeeName.clear();
    facilityType.value="";
    facilityName.clear();
    street.clear();
    phoneNumber1.clear();
    phoneNumber2.clear();
    nameSystem.clear();
    systemCons.clear();
    systemAdvantages.clear();
    explanationRequiredSystem.clear();
    Get.find<GtxFun>().customerId.value="0";
  }
}