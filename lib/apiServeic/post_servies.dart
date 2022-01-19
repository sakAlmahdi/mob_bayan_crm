import 'package:bayan/global/global_data.dart';
import 'package:bayan/internetChecker/check_net.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

class ApiService extends GetConnect {
  String url;
  var dataSend;
  static const _map={"":""};
  ApiService({required this.url, this.dataSend =_map});

  final Dio _dio = Dio();

  final Duration _runTime = const Duration(seconds: 300);

  getData({required Function(dynamic data) onSuccess, required Function(dynamic error) onError, required Function() onRunTime, Function()? noInterNet}) async {
    if (Get.find<CheckInterNet>().connectionInterNet.value!=0) {
        try {
          var response = await _dio.get(GlobalData.apiDomain + url,
              options:  Options(headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Bearer "+ GlobalData.token
              })).timeout(_runTime);
          // ignore: unnecessary_null_comparison
          print(GlobalData.apiDomain + url,);
          print(response.toString());
          if (response != null) {
            onSuccess(response.data);
          } else {
            onRunTime();
          }
        } on DioError catch (error) {
          print("error\n\n\n"+error.response.toString());

          if(error.response!=null){
            if (error.response!.data.toString() == "{message: The requested resource does not support http method 'GET'.}") {
              GlobalData.token='';
              getToken(onSuccess: (data) {getData(onSuccess: onSuccess, onError: onError, onRunTime: onRunTime,noInterNet: noInterNet);}, onError: (error) => onError(error), onRunTime:onRunTime, noInterNet: noInterNet);
            }
            else {onError(error.response);}
          }
          else {
            onError("unKnowError");}
        }
    }else {
      if (noInterNet != null) noInterNet();
    }
  }

  postData({required Function(dynamic data) onSuccess,required Function(dynamic error) onError,required Function() onRunTime, Function()? noInterNet,Function(dynamic error)? onError201,}) async {
    if (Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      // if(GlobalData.token.isNotEmpty||url=='Account/Login'){
        try {
          print(dataSend.toString());
          print(url.toString());
          var response = await _dio.post(
              GlobalData.apiDomain + url,
              data: dataSend,
              options: Options(headers: {
                // "Content-Type": "application/x-www-form-urlencoded",
                // "Accept-Language": "ar-YE",
                // "Authorization": "Bearer " + GlobalData.token
                "Content-Type": "application/x-www-form-urlencoded",
                "Accept": "text/plains",
                "Accept-Language": "ar-YE",
                "Authorization": "Bearer " + GlobalData.token
              })
          ).timeout(_runTime);
          print("1414");
          // ignore: unnecessary_null_comparison
          print(response.toString());
          if (response != null) {
            if(response.statusCode==201 && onError201 !=null ){
              print(response.data.toString());
              onError201(response.data);
            }else{
              print(response.data.toString());
              onSuccess(response.data);
            }
          } else {
            onRunTime();
          }
        } on DioError catch (error) {
          if(error.response!=null){
            if (error.response!.data.toString() == "{message: The requested resource does not support http method 'GET'.}") {
              print("1");
              GlobalData.token='';
              getToken(onSuccess: (data) {postData(onSuccess: onSuccess, onError: onError, onRunTime: onRunTime,noInterNet: noInterNet);}, onError: (error) => onError(error), onRunTime:onRunTime, noInterNet: noInterNet);
            }
            else {
              print("2");
              print(GlobalData.token);
              print(error.response.toString());
              onError(error.response!.data??"unKnowError");
            }
          }else {
            print("3");
            onError("unKnowError");
          }}
      // }
    // else{
    //     getToken(onSuccess: (data) {postData(onSuccess: onSuccess, onError: onError, onRunTime: onRunTime,noInterNet: noInterNet);}, onError: (error){
    //       // _backToLogin(backError: error,errorFun:onError);
    //       }, onRunTime:onRunTime, noInterNet: noInterNet
    //     );
    //   }
    } else {
      if (noInterNet != null) noInterNet();
    }
  }

  getToken({String userNm ='',String userPass ='',required Function(dynamic data) onSuccess, required Function(dynamic error) onError,required Function() onRunTime, Function()? noInterNet}) async {
    // GetStorage _tokenStorage =GetStorage();
    if (Get.find<CheckInterNet>().connectionInterNet.value!=0) {
      try {
        var response = await _dio.post(
            GlobalData.apiDomain+'Account/Login',
            // data: LoginModel(userName:userNm.isNotEmpty?userNm:_tokenStorage.read(GlobalData.userNameKey).toString() ,password:userPass.isNotEmpty?userPass:_tokenStorage.read(GlobalData.passwordKey).toString()).toJson(),
            options:  Options(headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              "Accept-Language": "ar-YE"
            })).timeout(
            _runTime);
        // ignore: unnecessary_null_comparison
        if (response != null) {
          GlobalData.token = response.data["access_token"].toString();
          onSuccess(response.data);
        } else {
          onRunTime();
        }
      } on DioError catch (error) {
        if(error.response!=null) {
          onError(error.response!.data["error_description"]??"unKnowError");
        } else {
          onError("unKnowError");
        }
      }
    } else {
      if (noInterNet != null) noInterNet();
    }
  }

  // _backToLogin({required var backError,required Function(dynamic error) errorFun}){
  //   {
  //     GetStorage _storage =GetStorage();
  //     if(backError=='The user name or password provided is incorrect.') {
  //       _storage.write(GlobalData.userNameKey, '');
  //       _storage.write(GlobalData.passwordKey,'');
  //       _storage.write(GlobalData.rememberKey, false);
  //       Get.off(() => LoginScreen());
  //       ErrorSnackBar(errorMsg: GlobalData.getLoginAgain).getSnack();
  //     }else errorFun(backError);}
  // }
}

