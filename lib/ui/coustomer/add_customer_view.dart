import 'package:bayan/global/funcations.dart';
import 'package:bayan/style/customWidget/custm_button.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/customWidget/custom_circular_progress.dart';
import 'package:bayan/style/customWidget/custom_spnr.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:bayan/ui/coustomer/add_customer_controller.dart';
import 'package:group_radio_button/group_radio_button.dart';
import '../../style/customWidget/custom_text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCustomerView extends StatelessWidget {
  final _controller = Get.put(AddCustomerController());
  final List<String> _haveSystemList = ["نعم", "لا"];
  final List<String> _customerStateList = ["نشط", "متوقف"];

  AddCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _controller.costomerUpdate.value = Get
        .find<GtxFun>().customerId.value;
    print("customerId\n" + Get
        .find<GtxFun>()
        .customerId
        .value);
    return Scaffold(
      appBar: AppBar(title: MyTextView(
        text: "سجل اعمال المسوقين", txSize: 15, txClr: MyColor().whiteClr,),),
      body: WillPopScope(
        onWillPop: () => _controller.goBack(),
        child: Stack(
          children: [
            _controller.obx((state) =>
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Form(
                    key: _controller.globalFormKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: ListView(
                      children: [
                        const Center(child: CustomTxtView(
                          text: "بيانات العميل", txSize: 19,)),
                        const Divider(
                          height: 5, color: Color(0xFF0F8361), thickness: 2,),
                        MySpinner(listItemLst: _controller.customerActivityLst,
                          isEmptyList: _controller.isEmptyFacilityType,
                          selectId: _controller.facilityTypeId,
                          selectIndex: _controller.facilityTypeId.value,
                          selectTxt: _controller.facilityType,
                          spinnerTxtName: "نوع المنشأة",),
                        MyTextInput(
                          isRequired: 1,
                          textEditingController: _controller.facilityName,
                          labelText: "اسم المنشأة",
                        ),
                        MyTextInput(
                          textEditingController: _controller.ownerName,
                          labelText: "اسم المالك",
                        ),
                        MyTextInput(
                          isRequired: 1,
                          textEditingController: _controller.employeeName,
                          labelText: "اسم الموظف المسؤول",
                        ),

                        // MySpinner(listItemLst: [],isEmptyList:_controller.isEmpty,selectId:_controller.id ,selectIndex: _controller.id.value,selectTxt:_controller.namejope ,spinnerTxtName: "الوطيفة",),
                        MySpinner(
                          listItemLst: _controller.countryList,
                          isEmptyList: _controller.isEmptyCountry,
                          selectId: _controller.countryId,
                          selectIndex: _controller.countryId.value,
                          selectTxt: _controller.countryTxt,
                          spinnerTxtName: "الدول",
                          onChanged: (value) {
                            _controller.countryId.value = value.id;
                            _controller.getCityLst();
                            _controller.cityTxt.value = "";
                          },),
                        Obx(() =>
                        _controller.countryId.value != 0 ? MySpinner(
                          listItemLst: _controller.cityList,
                          isEmptyList: _controller.isEmptyCity,
                          selectId: _controller.cityId,
                          selectIndex: _controller.cityId.value,
                          selectTxt: _controller.cityTxt,
                          spinnerTxtName: "المدن",
                          onChanged: (value) {
                            _controller.getAreaLst();
                          },) : const SizedBox()),
                        Obx(() => _controller.cityId.value != 0 ? MySpinner(
                          listItemLst: _controller.areaList,
                          isEmptyList: _controller.isEmptyCity,
                          selectId: _controller.areaId,
                          selectIndex: _controller.areaId.value,
                          selectTxt: _controller.areaTxt,
                          spinnerTxtName: "الحي",) : const SizedBox()),
                        // MySpinner(listItemLst:  [],isEmptyList:_controller.isEmpty,selectId:_controller.start ,selectIndex: 0,selectTxt:'المديريات' ,spinnerTxtName: "المديرية",),

                        MyTextInput(
                          isRequired: 1,
                          textEditingController: _controller.street,
                          labelText: "الشارع",
                        ),
                        MyTextInput(
                          isRequired: 1,
                          textEditingController: _controller.phoneNumber1,
                          labelText: "رقم الهاتف1",
                        ),
                        MyTextInput(
                          textEditingController: _controller.phoneNumber2,
                          labelText: "رقم الهاتف 2",
                        ),
                        const Center(child: CustomTxtView(
                          text: "تقييم العميل", txSize: 19,)),
                        const Divider(
                          height: 5, color: Color(0xFF0F8361), thickness: 2,),

                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const MyTextView(text: "يملك نظام", txSize: 14,),
                            GetBuilder<AddCustomerController>(
                              builder: (_controller) =>
                              RadioGroup<String>.builder(
                                direction: Axis.horizontal,
                                //horizontalAlignment:MainAxisAlignment.spaceAround,
                                activeColor: MyColor().btnClr,
                                groupValue: _controller.haveSystemValue.value,
                                onChanged: _controller.haveSystemFun,
                                itemBuilder: (item) =>
                                    RadioButtonBuilder(
                                      item,
                                    ),
                                items: _haveSystemList,
                              ),
                            ),
                          ],
                        ),
                        Obx(() =>
                        _controller.haveSystemValue.value == "نعم" ?
                        Column(
                          children: [
                            MyTextInput(
                              textEditingController: _controller.nameSystem,
                              labelText: "اسم النظام",
                            ),
                            MyTextInput(
                              maxline: 3,
                              textEditingController: _controller.systemCons,
                              labelText: "سلبيات النظام الموجود ",
                            ),
                            MyTextInput(
                              maxline: 3,
                              textEditingController: _controller
                                  .systemAdvantages,
                              labelText: "ايجابيات النظام الموجود ",
                            ),
                          ],
                        ) : SizedBox(),
                        ),
                        MySpinner(listItemLst: _controller.customerTypeList,
                          isEmptyList: _controller.isEmptyCustomerType,
                          selectId: _controller.customerTypeId,
                          selectIndex: _controller.customerTypeId.value,
                          selectTxt: _controller.customerTypeTxt,
                          spinnerTxtName: " نوع العميل",),

                        MySpinner(
                          listItemLst: _controller.typeServiceRequireList,
                          isEmptyList: _controller
                              .isEmptyTypeServiceRequireList,
                          selectId: _controller.typeServiceRequireId,
                          selectIndex: _controller.typeServiceRequireId.value,
                          selectTxt: _controller.typeServiceRequireTxt,
                          spinnerTxtName: "نوع الخدمة المطلوبة",),

                        MyTextInput(
                          maxline: 3,
                          isRequired: 1,
                          textEditingController: _controller
                              .explanationRequiredSystem,
                          labelText: "شرح عن الخدمة المطلوبة",
                        ),
                        // MySpinner(listItemLst: _controller.customerStateList,isEmptyList:_controller.isEmptyCustomerStateid,selectId:_controller.customerStateid ,selectIndex: _controller.customerStateid.value,selectTxt:_controller.customerStateTxt ,spinnerTxtName: " حالة العميل",),

                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const MyTextView(text: "حالة العميل", txSize: 14,),
                            GetBuilder<AddCustomerController>(
                              builder: (_controller) =>
                              RadioGroup<String>.builder(
                                direction: Axis.horizontal,
                                activeColor: MyColor().btnClr,
                                groupValue: _controller.customerStateValue,
                                onChanged: _controller.customerStateFun,
                                itemBuilder: (item) =>
                                    RadioButtonBuilder(
                                      item,
                                    ),
                                items: _customerStateList,
                              ),
                            ),
                          ],
                        ),

                        Obx(()=>Get.find<GtxFun>().customerScreen.value==2?
                        SizedBox():MyButton(
                            widthSize: Get.context!.width,
                            buttonText: "حفظ",
                            txtSize: 16,
                            buttonFun: () {
                              _controller.saveFun();
                            })
                        )
                      ],
                    ),
                  ),
                ),
            ),

            Obx(() =>
            _controller.isLoading.value
                ? CenterProgress()
                : const SizedBox()),
          ],
        ),
      ),
    );
  }
}
