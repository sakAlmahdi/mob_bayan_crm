import 'package:bayan/global/funcations.dart';
import 'package:bayan/style/customWidget/check_net.dart';
import 'package:bayan/style/customWidget/custm_button.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/customWidget/get_dialog_msg.dart';
import 'package:bayan/style/customWidget/not_data.dart';
import 'package:bayan/ui/follow/follow_customer/follow_customer_screen.dart';
import 'package:bayan/ui/follow/follow_today/follow_today_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
class FollowTodayScreen extends StatelessWidget {
  final _controller = Get.put(FollowTodayController());
  FollowTodayScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFFF4F4F4),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2),
          child:Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    _controller.getDate();
                  },child: MyTextInput(
          icon: Icons.date_range_rounded,
          isRequired: 1,
          enabledTxt: false,
          textEditingController: _controller.followDate,
          labelText:"تاريخ المتابعة القادمة",
        ),),
              _controller.obx((data) => Expanded(
                child: ListView.builder(itemCount: data!.length,itemBuilder: (context, index) => Slidable(
                  actionPane: SlidableScrollActionPane(),
                  actions: <Widget>[
                    CustomTextBtn(onPressedFun: (){
                      Get.find<GtxFun>().customerId.value=data[index].id!;
                      Get.to( FollowCustomerScreen());
                      }, buttonText: "المتابعات"),
                    CustomTextBtn(onPressedFun: (){
                      Get.find<GtxFun>().customerScreen.value=2;
                      _controller.showCustomer(id:data[index].id);
                      }, buttonText: "التفاصيل"),
                    DeleteBtn(onPressedFun:() {
                      GetDialogMsg().deleteWarningDialog(deleteFun: () {
                        // _controller.deleteCustomerFun(value[index].id!);
                      });
                    },)
                  ],
                  child:Row(
                    children: [
                      SizedBox(width: 5,child: Divider(thickness: 105,height: 105,color: Colors.red,)),
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical:5,),
                          // elevation: 4,
                          // shape:  RoundedRectangleBorder(side:BorderSide(width: 1,color:const Color(0xFFBDBDBD)) ),
                          color:Colors.white,
                          child: InkWell(onTap: () {},
                            // child: InkWell(onTap: () => _controller.getIdLookUpFun(data[index].id),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  const MyTextView(text: "تاجر",txSize: 11,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      MyTextView(text:data[index].name,txSize: 10,txClr: Colors.grey,),
                                      Card(color: Colors.black,child: MyTextView(text: "  تجارية  ",txSize: 10,txClr: Colors.grey,)),
                                    ],
                                  ),
                                  const Divider(thickness: 1,color: Colors.green,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      MyTextView(text: data[index].nextFollowType,txSize: 11,txClr: Colors.black,),
                                      MyTextView(text: data[index].createDate,txSize: 10,txClr: Colors.black,isAlgCenter: 1),
                                    ],
                                  ),
                                   MyTextView(text:data[index].requirments,txSize: 10,txClr: Colors.black,)
                                ],
                              ),
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
                  // onError:(error) =>GetDialogMsg().runTimeDialog(tryAgainFun: () => _controller.getCoustomerFollow(_controller.followDate.text)),
                  onLoading: const Expanded(child: Center(child: CheckNetAndProgressFotFetchData()))
                ),],
          )
        )
    );
  }
}