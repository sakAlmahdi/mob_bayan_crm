import 'package:bayan/style/customWidget/custm_button.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/customWidget/custom_circular_progress.dart';
import 'package:bayan/style/customWidget/custom_spnr.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:bayan/ui/follow/controller_follow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class FollowScreen extends StatelessWidget {
  final _controller = Get.put(FollowController());
   FollowScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: MyTextView(text: " المتابعة",txClr: MyColor().whiteClr,txSize: 15,),),
        body:Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
              child: ListView(
                  children: [
                    // MySpinner(listItemLst: _controller.costomerList,isEmptyList:_controller.isEmptyCostomer,selectId:_controller.idCostomer ,selectIndex: _controller.idCostomer.value,selectTxt:_controller.costomerName ,spinnerTxtName: "العميل",),
                    MySpinner(listItemLst: _controller.followUpTypeList,isEmptyList:_controller.isEmptyFollow,selectId:_controller.idFollow ,selectIndex: _controller.idFollow.value,selectTxt:_controller.followTypeTxt ,spinnerTxtName: " طريقة المتابعة الحالية",),
                    InkWell(
                      onTap: () {
                        _controller.getDate();
                      },
                      child: MyTextInput(
                        icon: Icons.date_range_rounded,
                        isRequired: 1,
                        enabledTxt: false,
                        textEditingController: _controller.nextFollowDate,
                        labelText:"تاريخ المتابعة القادمة",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _controller.getTime();
                      },
                      child: MyTextInput(
                        icon: Icons.access_alarm,
                        isRequired: 1,
                        enabledTxt: false,
                        textEditingController: _controller.nextFollowTime,
                        labelText:"وقت المتابعة القادمة",
                      ),
                    ),
                    MySpinner(listItemLst: _controller.purposeFollowList,isEmptyList:_controller.isEmptyPurposeFollow,selectId:_controller.idPurposeFollow ,selectIndex: _controller.idPurposeFollow.value,selectTxt:_controller.purposeFollowTxt ,spinnerTxtName: "الهدف من المتابعة",),
                    MyTextInput(
                      maxline: 3,
                      textEditingController: _controller.goleTxt,
                      labelText:"شرح الهدف من المتابعة ",
                    ),
                    const Center(child: MyTextView(text:"مدى التفاعل",txSize: 14,)),
                    RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 10,
                      itemSize:25,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        int x=rating.toInt();
                        _controller.starts.value= x;
                      },
                    ),
                    MySpinner(listItemLst: _controller.followUpTypeList,isEmptyList:_controller.isEmptyFollow,selectId:_controller.idFollowNext ,selectIndex: _controller.idFollowNext.value,selectTxt:_controller.followTypeNextTxt ,spinnerTxtName: " طريقة المتابعة القادمة",),
                    MyTextInput(
                      maxline: 3,
                      textEditingController: _controller.resultTxt,
                      labelText:"نتيجة المتابعة ",
                    ),
                    MyButton(
                        widthSize: Get.context!.width,
                        buttonText: "حفظ",
                        txtSize: 16,
                        buttonFun: (){
                          _controller.addFollow();
                        })
                  ],
              ),
            ),
            Obx(() =>_controller.isLoading.value
                ? CenterProgress()
                : SizedBox()),
          ],
        ));
  }
}