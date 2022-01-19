import 'package:bayan/apiServeic/post_servies.dart';
import 'package:bayan/global/funcations.dart';
import 'package:bayan/language/translate.dart';
import 'package:bayan/style/customWidget/custm_snack_bar.dart';
import 'package:bayan/style/customWidget/get_dialog_msg.dart';
import 'package:bayan/ui/coustomer/add_customer_view.dart';
import 'package:bayan/ui/home/conter_model.dart';
import 'package:bayan/ui/model/get_coustomer.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<List<CoustomerModel>>{
  late List<CoustomerModel>coustomerData;
  late Rx<CounterModel> counterData;
  late RxBool isTopListEmp,isBtmListEmp;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    coustomerData = List<CoustomerModel>.empty(growable: true).obs;
    counterData = CounterModel(topCounters: [],buttomConter: []).obs;
    isTopListEmp=false.obs;
    isBtmListEmp=false.obs;
    getCoustomer();
    getCounter();
  }

  getCoustomer(){
    // Get.find<AddCustomerController>().costomerUpdate.value="0";
    coustomerData.clear();
    change(null,status: RxStatus.loading());
    CoustomerModel().fetchNewCustomer(
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
  getCounter(){
    isTopListEmp.value=false;
    isBtmListEmp.value=false;
    CounterModel().fetchCounter(
        fullLstFun: (value){
          counterData(value);
          if(value.topCounters!.isEmpty)isTopListEmp.value=true;
          if(value.buttomConter!.isEmpty)isBtmListEmp.value=true;
        },
        emptyLstFun: (){
          isTopListEmp.value=true;
          isBtmListEmp.value=true;
        },
        errorFun:(error) {
        });
  }
  deleteCustomerFun( String id) {
    ApiService(url:'CRM_Customer/Delete/$id').postData(
        onSuccess: (data){
          coustomerData.removeAt(coustomerData.indexWhere((element) => element.id==id));
          change(coustomerData, status: RxStatus.success());
          CustomSnackBar(snackMsg: data ??"تم الحذف بنجاح").getSnack();
        },
        onError: (error){
          ErrorSnackBar(errorMsg:  error!=null&&error.length <= 800? error.toString():"لم يتم الحذف").getSnack();
        },
        onRunTime: (){
          GetDialogMsg().runTimeDialog(tryAgainFun: ()=>deleteCustomerFun(id));
        },
        noInterNet: (){
          ErrorSnackBar(errorMsg:DialogTxtTrns.NoEnterNetDialogMsg.tr).getSnack();
        });
  }

  addCustomer({String? id="0"}){
    Get.find<GtxFun>().customerId.value=id!;
    Get.to(AddCustomerView())!.then((value) => getCoustomer());
  }


}