import 'package:bayan/global/custom_pull_to_ref_footer.dart';
import 'package:bayan/global/funcations.dart';
import 'package:bayan/style/customWidget/custm_button.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/customWidget/custom_circular_progress.dart';
import 'package:bayan/style/customWidget/customer_card.dart';
import 'package:bayan/style/customWidget/get_dialog_msg.dart';
import 'package:bayan/ui/coustomer/all_customer/customer_controller.dart';
import 'package:bayan/ui/follow/screen_follow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen({Key? key}) : super(key: key);
  final _controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const MyTextView(
          text: "العملاء",
          txSize: 15,
          txClr: Colors.white,
        ),
      ),
      body: SmartRefresher(
        physics: const BouncingScrollPhysics(),
        controller: _controller.refreshController,
        enablePullUp: true,
        enableTwoLevel: true,
        enablePullDown: true,
        footer: CustomPullToRefFooter(),
        onRefresh: _controller.onRefresh,
        onLoading: _controller.onLoading,
        child: ListView(
          children: [
            // MyTextInput(
            //   textEditingController: _controller.customerSearch,
            //   isRequired: 1,
            //   labelText: "العميل",
            //   icon2: InkWell(
            //     child: const Icon(
            //       Icons.search,
            //     ),
            //     onTap: () => _controller.getCoustomer(),
            //   ),
            // ),
            _controller.obx((state) => Column(
                  children: List.generate(state!.length, (index) {
                    return Slidable(
                      actionPane: const SlidableScrollActionPane(),
                      actions: <Widget>[
                        CustomTextBtn(
                            onPressedFun: () {
                              Get.find<GtxFun>().customerId.value =
                                  state[index].id ?? "0";
                              Get.to(FollowScreen());
                            },
                            buttonText: "متابعة"),
                        EditBtn(onPressedFun: () {
                          Get.find<GtxFun>().customerScreen.value = 1;
                          _controller.goToAdd(id: state[index].id);
                        }),
                        DeleteBtn(
                          onPressedFun: () {
                            GetDialogMsg().deleteWarningDialog(deleteFun: () {
                              _controller.deleteCustomerFun(state[index].id!);
                            });
                          },
                        )
                      ],
                      child: MyCard(
                        name: state[index].name ?? "",
                        mobile: state[index].mobile ?? "",
                        followType: state[index].nextFollowType ?? "",
                        requirment: state[index].requirments ?? "",
                        contactName: state[index].contactName ?? "",
                        date: state[index].createDate ?? "",
                      ),
                    );
                  }),
                )),

            // Expanded(
            //   child: SmartRefresher(
            //     controller: _controller.refreshController,
            //     enablePullUp: true,
            //     enablePullDown: true,
            //     footer: CustomPullToRefFooter(),
            //     onRefresh:_controller.onRefresh,
            //     onLoading:_controller.onLoading,

            //     child:Container()
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(children: [
// MyTextInput(textEditingController:_controller.customerSearch,isRequired:1 ,labelText: "العميل",icon2:InkWell(child: Icon(Icons.search,),onTap: ()=>_controller.getCoustomer(),) ,),
// Obx(()=>_controller.loding.value==1? Expanded(child: _controller.obx((data)=> ListView.builder(itemCount: data!.length,itemBuilder: (context, index) =>
// Padding(
// padding: const EdgeInsets.all(2.0),
// child: Slidable(
// actionPane: SlidableScrollActionPane(),
// actions: <Widget>[
// CustomTextBtn(onPressedFun: (){ Get.to(FollowScreen());}, buttonText: "متابعة"),
// EditBtn(onPressedFun: (){
// print("edeit");
// // _controller.getIdSeasonFun(value[index].id);
// }),
// DeleteBtn(onPressedFun:() {
// print("delet");
// // GetDialogMsg().deleteWarningDialog(deleteFun: () {_controller.deleteCustomerFun(value[index].id!);});
// },)
// ],
// child: SizedBox(width: Get.width,
// child: Card(
// // margin: const EdgeInsets.symmetric(vertical:5),
// // elevation: 1,
// shape:  RoundedRectangleBorder(side:BorderSide(width: 1,color:Color(0xFFBDBDBD)) ),
// color:Colors.white,
// child: InkWell(onTap: () {
// // Get.to(FollowScreen());
// },
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal:8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children:  [
// const MyTextView(text: "تاجر",txSize: 12,),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children:  [
// MyTextView(text:data[index].name.toString(),txSize: 10,txClr: Colors.grey,),
// Card(color: Colors.black,child: const MyTextView(text: "  تجارية  ",txSize: 12,txClr: Colors.grey,)),
// ],
// ),
// ],
// ),
// ),
// ),
// ),
// ),
// ),
// ),),onLoading:CheckNetAndProgressFotFetchData() ,onEmpty: NoData() ,
// )):SizedBox(),
// )
// ],),
// ),

}
