import 'package:bayan/apiServeic/post_servies.dart';
import 'package:bayan/style/customWidget/custm_snack_bar.dart';
import 'package:bayan/style/customWidget/custom_dialog_fun.dart';
import 'package:bayan/style/customWidget/get_dialog_msg.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:bayan/ui/follow/controller_follow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowUpModel {
  String ?customerID;
  int ?typeId;
  int ?targetId;
  String ?followDate;
  String ?followTime;
  int ?interactionRange;
  String ?goal;
  String ?result;
  String ?nextFollowDate;
  String ?nextFollowTime;
  int ?nextFollowTypeId;

  FollowUpModel(
      {
        this.customerID,
        this.typeId,
        this.targetId,
        this.followDate,
        this.followTime,
        this.interactionRange,
        this.goal,
        this.result,
        this.nextFollowDate,
        this.nextFollowTime,
        this.nextFollowTypeId,
       });

  FollowUpModel.fromJson(Map<String, dynamic> json) {
    customerID = json['customer_ID'];
    typeId = json['type_Id'];
    targetId = json['target_Id'];
    followDate = json['followDate'];
    followTime = json['followTime'];
    interactionRange = json['interaction_Range'];
    goal = json['goal'];
    result = json['result'];
    nextFollowDate = json['nextFollowDate'];
    nextFollowTime = json['nextFollowTime'];
    nextFollowTypeId = json['nextFollowTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_ID'] = customerID;
    data['type_Id'] = typeId;
    data['target_Id'] = targetId;
    data['followDate'] = followDate;
    data['followTime'] = followTime;
    data['interaction_Range'] = interactionRange;
    data['goal'] = goal;
    data['result'] = result;
    data['nextFollowDate'] = nextFollowDate;
    data['nextFollowTime'] = nextFollowTime;
    data['nextFollowTypeId'] = nextFollowTypeId;
    return data;
  }
  createFollow({required Function(dynamic data) successFun}) {
    Get.find<FollowController>().isLoading(true);
    ApiService(url: 'CRM_FollowUpHistory/Create',dataSend: toJson()).postData(
      onError: (error) {
        print(error.toString());
        Get.find<FollowController>().isLoading(false);
        ErrorSnackBar(errorMsg: error != null && error.toString().length < 800 ? error.toString() : "خطاء").getSnack();
      },
      onRunTime: () {
        Get.find<FollowController>().isLoading(false);
        GetDialogMsg().runTimeDialog(tryAgainFun: () => createFollow(successFun: successFun));
      },
      noInterNet: () {
        Get.find<FollowController>().isLoading(false);
        ErrorSnackBar(errorMsg:"لا يوجد انترنت").getSnack();
      },
      onSuccess: (data) {
        Get.find<FollowController>().isLoading(false);
        CustomDialog(title: data?? "تم حفظ البيانات", icon: Icons.check_circle_outline_sharp, iconClr: MyColor().icnClrSuccess).oneBtn(firstFun: Get.back);
        successFun(data);
      },
    );
  }
}
