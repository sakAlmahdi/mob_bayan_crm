import 'package:bayan/apiServeic/post_servies.dart';
import 'package:bayan/global/global_data.dart';
import 'package:bayan/style/customWidget/custm_snack_bar.dart';
import 'package:bayan/style/customWidget/get_dialog_msg.dart';
import 'package:bayan/ui/login/controller_login.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class Login {
 late String _grantType;
late  String _password;
 late String _username;
  Login({String ?grantType, String ?password, String ?username}) {
    _grantType = grantType!;
    _password = password!;
    _username = username!;
  }

  String get grantType => _grantType;

  set grantType(String grantType) => _grantType = grantType;

  String get password => _password;

  set password(String password) => _password = password;

  String get username => _username;

  set username(String username) => _username = username;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grant_type'] = _grantType;
    data['password'] = _password;
    data['username'] = _username;
    return data;
  }

  fetchTokenLogin({required Function(dynamic data) successFun}) {
      ApiService(url: 'account/Login', dataSend: toJson()).postData(
        onError: (error) {
          print(error.toString());
          Get.find<LoginController>().isLoading(false);
          ErrorSnackBar(errorMsg: error.toString() ).getSnack();
          // ErrorSnackBar(errorMsg: "${error["error_description"]}".toString() ).getSnack();
        },
        onRunTime: () {
          Get.find<LoginController>().isLoading(false);
          GetDialogMsg().runTimeDialog(tryAgainFun: () => fetchTokenLogin(successFun: successFun));
        },
        noInterNet: () {
          Get.find<LoginController>().isLoading(false);
          ErrorSnackBar(errorMsg: "لايوجد اتصال بلانترنت").getSnack();
        },
        onSuccess: (data) {
          GlobalData.token = data["access_token"] as String;
          successFun(data);
        },
      );
  }
}