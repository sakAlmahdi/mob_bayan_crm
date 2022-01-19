import 'package:bayan/apiServeic/post_servies.dart';
import 'package:bayan/global/models_lst.dart';
import 'package:bayan/style/customWidget/custm_snack_bar.dart';
import 'package:bayan/style/customWidget/custom_dialog_fun.dart';
import 'package:bayan/style/customWidget/get_dialog_msg.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:bayan/ui/coustomer/add_customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CreateCustomerModel {
  String ?id;
  int ?activityID;
  int ?categoryID;
  String ?name;
  String ?email;
  String ?phone;
  String ?mobile;
  int ?status;
  String ?contactName;
  String ?contactJob;
  int ?countryID;
  int ?regionID;
  int ?cityID;
  int ?areaID;
  String ?street;
  String ?building;
  String ?mapPoint1;
  String ?mapPoint2;
  String ?img;
  String ?requirments;
  double ?estimateAmount;
  bool ?haveSystem;
  String ?currentSystem;
  String ?currentIssues;

  CreateCustomerModel(
      {this.id,
        this.activityID,
        this.categoryID,
        this.name,
        this.email,
        this.phone,
        this.mobile,
        this.status,
        this.contactName,
        this.contactJob,
        this.countryID,
        this.regionID,
        this.cityID,
        this.areaID,
        this.street,
        this.building,
        this.mapPoint1,
        this.mapPoint2,
        this.img,
        this.requirments,
        this.estimateAmount,
        this.haveSystem,
        this.currentSystem,
        this.currentIssues});

  CreateCustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityID = json['activity_ID'];
    categoryID = json['category_ID'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    mobile = json['mobile'];
    status = json['status'];
    contactName = json['contact_Name'];
    contactJob = json['contact_Job'];
    countryID = json['country_ID'];
    regionID = json['region_ID'];
    cityID = json['city_ID'];
    areaID = json['area_ID'];
    street = json['street'];
    building = json['building'];
    mapPoint1 = json['map_Point1'];
    mapPoint2 = json['map_Point2'];
    img = json['img'];
    requirments = json['requirments'];
    estimateAmount = json['estimate_Amount'];
    haveSystem = json['have_System'];
    currentSystem = json['current_System'];
    currentIssues = json['current_Issues'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['activity_ID'] = activityID;
    data['category_ID'] = categoryID;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['mobile'] = mobile;
    data['status'] = status;
    data['contact_Name'] = contactName;
    data['contact_Job'] = contactJob;
    data['country_ID'] = countryID;
    data['region_ID'] = regionID;
    data['city_ID'] = cityID;
    data['area_ID'] = areaID;
    data['street'] = street;
    data['building'] = building;
    data['map_Point1'] = mapPoint1;
    data['map_Point2'] = mapPoint2;
    data['img'] = img;
    data['requirments'] = requirments;
    data['estimate_Amount'] = estimateAmount;
    data['have_System'] = haveSystem;
    data['current_System'] = currentSystem;
    data['current_Issues'] = currentIssues;
    return data;
  }
  fetchCustomerById({required Function(CreateCustomerModel value) fullLstFun,required Function(dynamic errorData) errorFun}){
    ApiService(url:'CRM_Customer/GetById/$id').getData(
        onSuccess: (data){fullLstFun(CreateCustomerModel.fromJson(data));},
        onError: (error){errorFun(error);},
        onRunTime: (){errorFun(null);});
  }
  addCustomerFun({required Function() clearModel}){
    ApiService(url:id=="00000000-0000-0000-0000-000000000000"?'CRM_Customer/Create':'CRM_Customer/Update',dataSend:toJson()).postData(
      onError201: (error) {
        Get.find<AddCustomerController>().isLoading(false);
        CustomDialog(title: error?? "خطاء", iconClr: MyColor().icnClrWrong).oneBtn(firstFun: Get.back);
        },
        onSuccess: (data){
          Get.find<AddCustomerController>().isLoading(false);
          CustomDialog(title: data?? "تم حفظ البيانات", icon: Icons.check_circle_outline_sharp, iconClr: MyColor().icnClrSuccess).oneBtn(firstFun: Get.back);
          clearModel();
        },
        onError: (error){
          Get.find<AddCustomerController>().isLoading(false);
          ErrorSnackBar(errorMsg:error.toString()).getSnack();
          },
        onRunTime: (){
          Get.find<AddCustomerController>().isLoading(false);
          GetDialogMsg().runTimeDialog(tryAgainFun: () => print("onRunTime"));

        },
        noInterNet: (){
          Get.find<AddCustomerController>().isLoading(false);
          ErrorSnackBar(errorMsg:"لا يوجد انترنت").getSnack();

        }
    );
  }
}
