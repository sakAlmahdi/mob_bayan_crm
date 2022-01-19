import 'package:bayan/global/global_data.dart';
import 'package:bayan/helpr_model.dart';
import 'package:bayan/style/customWidget/custm_snack_bar.dart';
import 'package:bayan/ui/login/login_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey();
  late TextEditingController memberNum, password;
  late RxBool isLoading = false.obs;
  var rememberMe = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    memberNum = TextEditingController(text: kDebugMode ? '0549000191' : null);
    password = TextEditingController(text: kDebugMode ? '0549000191' : null);
    rememberMe(false);
    isLoading(false);
  }

  loginBtnFun() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (loginFormKey.currentState!.validate()) {
      isLoading(true);
      Login(
              username: memberNum.text.trim().toString(),
              password: password.text.trim().toString(),
              grantType: "password")
          .fetchTokenLogin(successFun: (data) {
        isLoading(false);
        GetStorage storage = GetStorage();
        storage.write(GetStorageText.userName, memberNum.text.trim());
        storage.write(GetStorageText.password, password.text.trim());
        storage.write(GetStorageText.rememberMe, "${rememberMe.value}");
        Get.offAllNamed(MyRoutScreen.home);
        deleteControllers();
      });
    } else {
      ErrorSnackBar(errorMsg: "هناك حقول ضرورية").getSnack();
    }
  }

  restoreFun(String restoreType) {
    print("restorPass");
    // Get.toNamed("${MyRoutScreen.restorePass}?${GetParametersName.title}=${RestorePassTxtTrns.Title.tr} $restoreType");
  }

  goBack() {
    Get.back();
    onClose();
  }

  _clearDesign() {
    rememberMe(false);
    memberNum.clear();
    password.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _clearDesign();
  }

  deleteControllers() {
    _clearDesign();
    Get.delete<LoginController>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    memberNum.dispose();
    password.dispose();
  }
}
