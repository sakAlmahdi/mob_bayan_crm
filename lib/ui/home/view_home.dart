import 'package:bayan/dealWithScreenSize/responsbal_screen_size.dart';
import 'package:bayan/global/funcations.dart';
import 'package:bayan/style/customWidget/check_net.dart';
import 'package:bayan/style/customWidget/custm_button.dart';
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/customWidget/custom_circular_progress.dart';
import 'package:bayan/style/customWidget/custom_container_icon_buttom.dart';
import 'package:bayan/style/customWidget/customer_card.dart';
import 'package:bayan/style/customWidget/get_dialog_msg.dart';
import 'package:bayan/style/customWidget/not_data.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:bayan/style/widgetStyle/icons_style.dart';
import 'package:bayan/ui/coustomer/all_customer/customer_view.dart';
import 'package:bayan/ui/follow/follow_today/follow_today_view.dart';
import 'package:bayan/ui/follow/screen_follow.dart';
import 'package:bayan/ui/home/controller_home.dart';
import 'package:bayan/ui/model/get_coustomer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
   final _controller = Get.put(HomeController());
   @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      floatingActionButton:FloatingActionButton(backgroundColor: MyColor().btnClr,onPressed: () {
        Get.find<GtxFun>().customerScreen.value=0;
        _controller.addCustomer(id:"0");
      },child:const Icon(Icons.add,size: 40,) ,) ,
      body: Padding(
        padding:   EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          children: [
            SizedBox(
              height: SizeScreen.isSmallScreen()?150:Get.width/15,
              child: Obx(
                ()=>_controller.counterData.value.topCounters!.isNotEmpty? ListView.builder(
                    itemCount: _controller.counterData.value.topCounters!.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx,index){
                  return CustomHomBtm(txt1:_controller.counterData.value.topCounters![index].text??"",btnClr:  index==1?const Color(0xFFAF3535):index==2?const Color(0xFFF78E00):const Color(0xFF0D9872) ,btnFun: (){},txt2: _controller.counterData.value.buttomConter![index].text??"",icon1:index==1?Icons.record_voice_over_outlined:index==2?Icons.repeat: Icons.people_alt_outlined );
                }):!_controller.isTopListEmp.value?Center(child: CenterProgress()):const Text('nodata'),
              ),
            ),

            Row(
              children:  [
                Expanded(
                  child: Container(margin: const EdgeInsets.symmetric(horizontal: 8),child: Row(
                    children: const [
                      MyTextView(text: "العملاء",txSize: 13,),
                      SizedBox(width: 5,),
                      MyTextView(text: "اخر عملاء تم اضافتهم ",txClr: Colors.grey,),
                    ],
                  )),
                ),
                const Icon(Icons.add),
                MyButton(txtSize: 10  ,buttonFun: () {Get.to(CustomerScreen());
                },verticalPadding: 2,horzPad: 2,buttonText: "عرض الكل",),
                const SizedBox(width: 10,),
              ],
            ) ,
            Expanded(child:_controller.obx((value) => ListView.builder(padding: EdgeInsets.only(bottom: 60),itemCount: value!.length,itemBuilder: (context, index) =>
                Padding(
                padding: const EdgeInsets.all(2.0),
                child: Slidable(
                  actionPane: SlidableScrollActionPane(),
                  actions: <Widget>[
                    CustomTextBtn(onPressedFun: (){
                      Get.find<GtxFun>().customerId.value=value[index].id??"0";
                      Get.to(FollowScreen());}, buttonText: "متابعة"),
                     EditBtn(onPressedFun: (){
                       Get.find<GtxFun>().customerScreen.value=1;
                       _controller.addCustomer(id:value[index].id! );
                     }),
                    DeleteBtn(onPressedFun:() {
                      GetDialogMsg().deleteWarningDialog(deleteFun: () {_controller.deleteCustomerFun(value[index].id!);});
                      },)
                  ],
                  child: MyCard(name: value[index].name??"", mobile:value[index].mobile??"", followType: value[index].nextFollowType??"",
                    requirment:value[index].requirments??"", contactName: value[index].contactName??"", date:value[index].createDate??"",),
                ),
              ),),onLoading: const CheckNetAndProgressFotFetchData(),
                onEmpty: const Center(child: NoData()),onError:(error) => const Text("error")

            ))
          ],
        ),

      ),
    );
  }
}
class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({ Key? key }) : super(key: key);
  @override
  State<MyTabbedPage> createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
  static const List<Widget> myTabs = <Tab>[
    Tab(text: 'الرئيسية',),
    Tab(text: 'جدول المتابعة'),
  ];

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          TabBar(labelColor: Colors.black,indicatorColor: Colors.green,indicatorSize: TabBarIndicatorSize.label ,padding: const EdgeInsets.symmetric(horizontal: 20),
            controller: _tabController,
            labelPadding: const EdgeInsets.all(10),
            // tabs: myTabs,
            tabs: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.home),
                  SizedBox(width: 10,),
                  MyTextView(text:"الرئيسية" ,txSize: 12,),
                ],
              ),
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.date_range_rounded),
                  SizedBox(width: 10,),
                  MyTextView(text: "جدول المتابعة",txSize: 12,),
                ],
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:[
                HomeView(),
                FollowTodayScreen()

              ]
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(backgroundColor: Colors.white,centerTitle: true,title: const MyTextView(text: "بيان - نطام علاقات العملاء",txSize: 15,txClr: Colors.black,),
    //     bottom: TabBar(labelColor: Colors.black,indicatorColor: Colors.green,indicatorSize: TabBarIndicatorSize.label ,padding: const EdgeInsets.symmetric(horizontal: 20),
    //       controller: _tabController,
    //       labelPadding: const EdgeInsets.all(10),
    //       // tabs: myTabs,
    //       tabs: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: const [
    //             Icon(Icons.home),
    //             SizedBox(width: 10,),
    //             MyTextView(text:"الرئيسية" ,txSize: 12,),
    //           ],
    //         ),
    //         //
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: const [
    //             Icon(Icons.date_range_rounded),
    //             SizedBox(width: 10,),
    //             MyTextView(text: "جدول المتابعة",txSize: 12,),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    //   body: TabBarView(
    //     controller: _tabController,
    //     children:[
    //       HomeView(),
    //       FollowTodayScreen()
    //
    //     ]
    //   ),
    // );
  }
}

