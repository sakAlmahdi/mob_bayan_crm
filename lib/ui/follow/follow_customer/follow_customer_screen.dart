import 'package:bayan/global/funcations.dart';
import 'package:bayan/style/customWidget/check_net.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/customWidget/not_data.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:bayan/ui/follow/follow_customer/follow_customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class FollowCustomerScreen extends StatelessWidget {
   FollowCustomerScreen({Key? key}) : super(key: key);
  final _controller = Get.put(FollowCustomerController());
  @override
  Widget build(BuildContext context) {
    _controller.idCustomer.value=Get.find<GtxFun>().customerId.value;
    return Scaffold(backgroundColor: const Color(0xFFF4F4F4),
     appBar: AppBar(title: MyTextView(text: "المتابعات",txClr: MyColor().whiteClr,txSize: 15),),
        body:WillPopScope(
          onWillPop: () => _controller.goBack(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2),
              child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _controller.obx((data) => Expanded(
                    child: ListView.builder(itemCount: data!.length,itemBuilder: (context, index) => Slidable(
                      actionPane: SlidableScrollActionPane(),
                      actions: <Widget>[
                        // DeleteBtn(onPressedFun:() {
                        //   GetDialogMsg().deleteWarningDialog(deleteFun: () {
                        //     // _controller.deleteCustomerFun(value[index].id!);
                        //   });
                        // },)
                      ],
                      child:Row(
                        children: [
                          SizedBox(width: 5,child: Divider(thickness: 105,height: 105,color: Colors.red,)),
                          Expanded(
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical:5,),
                              color:Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    const MyTextView(text: "تاجر",txSize: 11,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        MyTextView(text:data[index].typeName,txSize: 10,txClr: Colors.grey,),
                                        Card(color: Colors.black,child: MyTextView(text: "  تجارية  ",txSize: 10,txClr: Colors.grey,)),
                                      ],
                                    ),
                                    const Divider(thickness: 1,color: Colors.green,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        MyTextView(text: data[index].nextFollowType,txSize: 11,txClr: Colors.black,),
                                        MyTextView(text: data[index].followDate,txSize: 10,txClr: Colors.black,isAlgCenter: 1),
                                      ],
                                    ),
                                    // MyTextView(text:data[index].requirments,txSize: 10,txClr: Colors.black,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),),
                  ),
                      onEmpty: const Expanded(child: Center(child: NoData())),
                      onError:(error) => const Text("error"),
                      onLoading: Expanded(child: const CheckNetAndProgressFotFetchData())
                  ),],
              )
          ),
        )
    );
  }
}
