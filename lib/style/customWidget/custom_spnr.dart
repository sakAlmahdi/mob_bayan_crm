import 'package:bayan/dealWithScreenSize/responsbal_screen_size.dart';
import 'package:bayan/internetChecker/check_net.dart';
import 'package:bayan/spner_model.dart';
import 'package:bayan/style/customWidget/check_net.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/customWidget/not_data.dart';
import 'package:bayan/style/widgetStyle/coustom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySpinner extends StatelessWidget {
  final String spinnerTxtName;
  final List<dynamic> listItemLst;
  final ValueChanged<SpinnerModels>? onChanged;

  final RxInt selectId;
  final int selectIndex;
  final RxString ?selectTxt;
  final RxBool isEmptyList;
  final int withNoValidator;
  MySpinner({
    Key? key,
    this.onChanged,
    required this.listItemLst,
    required this.spinnerTxtName, this.withNoValidator=0, required this.selectId, required this.isEmptyList, required this.selectIndex,  this.selectTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(()=> Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
              height: 48,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: selectId.value!=0?Colors.indigo:Colors.red,width: 1.5),
                  borderRadius: BorderRadius.circular(10.r)
              ),
              child: ListTile(
                onTap: (){
                  Get.find<CheckInterNet>().spinnerSearchStart.value=false;
                  Get.find<CheckInterNet>().spinnerSearchLst.clear();
                  Get.find<CheckInterNet>().spinnerSearchLst.addAll(listItemLst);
                  CustomSpnr(
                      spinnerTxtName: spinnerTxtName,
                      withNoValidator: withNoValidator,
                      emptyLst: isEmptyList,
                      spnLst: listItemLst,
                      selectTxt:selectTxt,
                      selectId: selectId,
                      onChanged: (data){
                        if(onChanged!=null)onChanged!(data);}).getLst();
                },
                dense: true,
                trailing: const Icon(Icons.keyboard_arrow_down_sharp,),
                title: Obx(()=> selectId.value!=0?MyTextView(text: selectTxt!.value,txSize: 14,txClr: Colors.black,isAlgCenter: 1)
                    :Text(" اختار ${spinnerTxtName.tr}",style: CoustomTextStyle(
                    fntSize: 12,clr: Colors.black.withOpacity(0.5)).setTextStyle(),),),
              )),
        )),
        Obx(()=>selectId.value==0&&withNoValidator!=1?Text("${spinnerTxtName.tr}  مطلوب ",style:const CoustomTextStyle(
            clr: Colors.red,fntSize: 11).setTextStyle()):const SizedBox()),
      ],
    );
  }
}

class CustomSpnr{
  final String spinnerTxtName;
  final List<dynamic> spnLst;
  final ValueChanged<dynamic>? onChanged;
  final RxInt selectId;
  final RxBool emptyLst;
  final RxString ?selectTxt;
  final int withNoValidator;
  const CustomSpnr( {
    Key? key,
    this.onChanged,
    required this.spnLst,
    required this.spinnerTxtName, this.withNoValidator=0, required this.selectTxt,required this.selectId, required this.emptyLst,
  });

  getLst(){
    return Get.bottomSheet(
      Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: const BoxDecoration(
            borderRadius:  BorderRadius.vertical(
                top: Radius.circular(20)),
            color:Colors.white,
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing:15.h,
            children: [
              MyTextView(text: spinnerTxtName,isAlgCenter : 1,txSize: 12,),
              SizedBox(
                height: 48,
                width: Get.context!.width,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Colors.indigo, width: 1.5)),
                      hintText: "بحث",
                      prefixIcon: const Icon( Icons.search,),
                      hintStyle:CoustomTextStyle(fntSize: 12,clr: Colors.black.withOpacity(0.5)).setTextStyle(),),
                  cursorColor: Colors.indigo,
                  style: const  CoustomTextStyle(fntSize: 14).setTextStyle(),
                  onChanged: (value){
                    if(value.trim().isNotEmpty){
                      Get.find<CheckInterNet>().spinnerSearchStart.value=true;
                    }else{
                      Get.find<CheckInterNet>().spinnerSearchStart.value=false;
                    }
                    Get.find<CheckInterNet>().spinnerSearchLst.clear();
                    spnLst.forEach((element) {
                      if(element.arabicValue.startsWith(value)||element.arabicValue.contains(value)){
                        Get.find<CheckInterNet>().spinnerSearchLst.add(element);
                      }
                    });
                  },
                ),
              ),
              Obx(()=>spnLst.isNotEmpty?
              Container(
                constraints: BoxConstraints(
                    maxHeight: Get.height/2
                ),
                child: ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                    shrinkWrap: true,
                    itemCount: !Get.find<CheckInterNet>().spinnerSearchStart.value?spnLst.length:Get.find<CheckInterNet>().spinnerSearchLst.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      var dataLst = !Get.find<CheckInterNet>().spinnerSearchStart.value?spnLst:Get.find<CheckInterNet>().spinnerSearchLst;
                      return Column(
                        children: [
                          ListTile(
                            onTap: (){
                              selectTxt!.value=dataLst[index].arabicValue;
                              Get.back();
                              if(selectId.value!=spnLst[index].id&&!Get.find<CheckInterNet>().spinnerSearchStart.value){
                                selectId.value = spnLst[index].id;
                                spnLst.insert(0,spnLst[index]);
                                spnLst.removeAt(index+1);
                                if(onChanged!=null)onChanged!(spnLst[index]);
                              }else if (selectId.value!=Get.find<CheckInterNet>().spinnerSearchLst[index].id){
                                selectId.value = Get.find<CheckInterNet>().spinnerSearchLst[index].id!;
                                spnLst.removeWhere((element) => element==Get.find<CheckInterNet>().spinnerSearchLst[index]);
                                spnLst.insert(0,Get.find<CheckInterNet>().spinnerSearchLst[index]);
                                if(onChanged!=null)onChanged!(spnLst[index]);
                              }
                            },
                            trailing:Icon(index==0&&selectId.value!=0?Icons.radio_button_checked_sharp:Icons.radio_button_off_sharp,size: SizeScreen.isSmallScreen()?20:25,color:  Colors.indigo,),
                            title: MyTextView(text: dataLst[index].arabicValue, txSize: 12,txClr: Colors.black,),
                          ),
                          const Divider(
                            color: Colors.indigo,
                          )
                        ],
                      );
                    }),
              ):!emptyLst.value?SizedBox(height: Get.context!.height/2,child: const CheckNetAndProgressFotFetchData()):SizedBox(height: Get.context!.height/2.5,child: const NoData()),
              ),

            ],
          )
      ),
      isScrollControlled: true,
    );
  }
}
