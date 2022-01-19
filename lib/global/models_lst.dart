import 'package:get/get.dart';


class ModelsList extends GetxService {
  late RxBool isLoading;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading=false.obs;
  }

}
