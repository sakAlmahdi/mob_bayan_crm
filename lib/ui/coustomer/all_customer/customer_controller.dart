import 'package:bayan/apiServeic/post_servies.dart';
import 'package:bayan/global/funcations.dart';
import 'package:bayan/language/translate.dart';
import 'package:bayan/style/customWidget/custm_snack_bar.dart';
import 'package:bayan/style/customWidget/get_dialog_msg.dart';
import 'package:bayan/ui/coustomer/add_customer_view.dart';
import 'package:bayan/ui/model/get_coustomer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerController extends GetxController
    with StateMixin<List<CoustomerModel>> {
  final coustomerData = <CoustomerModel>[].obs;
  late TextEditingController customerSearch;
  late RxInt loding;
  late RxBool isloding, isEmpLst;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  int currentPage = 1;

  @override
  void onInit() {
    isloding = false.obs;
    isEmpLst = false.obs;
    loding = 0.obs;

    customerSearch = TextEditingController();
    customerSearch.text = "";
    // getCoustomer();
  }

  void onRefresh() async {
    await getCoustomer();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    getMoreCoustomer();
  }

  getCoustomer() {
    currentPage = 1;
    change(null, status: RxStatus.loading());
    CoustomerModel().fetchCoustomer(
        page: currentPage,
        fullLstFun: (value) {
          coustomerData.addAll(value);
          change(coustomerData, status: RxStatus.success());
        },
        emptyLstFun: () {
          change(coustomerData, status: RxStatus.empty());
          refreshController.loadNoData();
        },
        errorFun: (error) {
          change(null, status: RxStatus.error(error));
          // refreshFailedLoad();
        });
  }

  getMoreCoustomer() {
    currentPage = currentPage + 1;
    CoustomerModel().fetchCoustomer(
        page: currentPage,
        fullLstFun: (value) {
          coustomerData.addAll(value);
          change(coustomerData, status: RxStatus.loadingMore());
          refreshController.loadComplete();
        },
        emptyLstFun: () {
          refreshController.loadNoData();
        },
        errorFun: (error) {
          change(null, status: RxStatus.error(error));
          // refreshFailedLoad();
        });
  }

  refreshFailedLoad() {
    if (currentPage == 1) {
      refreshController.refreshFailed();
    } else {
      refreshController.loadFailed();
    }
  }

  deleteCustomerFun(String id) {
    ApiService(url: 'CRM_Customer/Delete/$id', dataSend: {"": ""}).postData(
        onSuccess: (data) {
      coustomerData.value.removeAt(
          coustomerData.value.indexWhere((element) => element.id == id));
      change(coustomerData.value, status: RxStatus.success());
      CustomSnackBar(snackMsg: data ?? "تم الحذف بنجاح").getSnack();
    }, onError: (error) {
      ErrorSnackBar(
              errorMsg:
                  error != null && error.length <= 800 ? error : "لم يتم الحذف")
          .getSnack();
    }, onRunTime: () {
      GetDialogMsg().runTimeDialog(tryAgainFun: () => deleteCustomerFun(id));
    }, noInterNet: () {
      ErrorSnackBar(errorMsg: DialogTxtTrns.NoEnterNetDialogMsg.tr).getSnack();
    });
  }

  goToAdd({String? id = "0"}) {
    Get.find<GtxFun>().customerId.value = id!;
    Get.to(AddCustomerView());
  }
// Future<bool> getPassengerData({bool isRefresh = false}) async {
//   if (isRefresh) {
//     currentPage = 1;
//     coustomerData.value.clear();
//   } else {
//     if (currentPage >= 10) {
//       print("ASF");
//       refreshController.loadNoData();
//       return false;
//     }
//   }
//   if (customerSearch.text.trim().isNotEmpty) {
//     isloding(true);
//     loding.value = 1;
//     CoustomerModel().fetchCoustomer(txt: customerSearch.text,page: currentPage,
//         fullLstFun: (value) {
//           if (isRefresh) {
//           loding.value = 1;
//           coustomerData.value.addAll(value);
//           isloding(false);
//           if(value.isNotEmpty&&value.length>=10) {
//             currentPage++;
//           }else{
//             customerSearch.clear();
//           }
//         } else {
//             print("bbb");
//             customerSearch.clear();
//           loding.value = 0;
//           coustomerData.value.addAll(value);
//             isloding(false);
//           }
//           loding.value=1;
//           return true;
//         },
//         emptyLstFun: () {
//           isloding(false);
//           loding = 0.obs;
//           change([], status: RxStatus.empty());
//         },
//         errorFun: (error) {
//           isloding(false);
//           loding = 0.obs;
//           change([], status: RxStatus.error());
//         });
//   }
//   // else{
//   //   ErrorSnackBar(errorMsg: "يرجئ ادخال جملة بحث").getSnack();
//   // }
//   return false;
// }
}
