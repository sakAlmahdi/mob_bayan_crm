//
// import 'package:bayan/helpr_model.dart';
// import 'package:bayan/style/customWidget/custom_text_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// class RegisterView extends StatelessWidget {
//
//   const RegisterView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Column(
//         children:   const [
//           Center(
//             child: CustomTxtView(text: "Register View",txSize: 19,),
//           ),
//           NewWidget(
//             screenName: MyRoutScreen.home,),
//         ],
//       ),
//     );
//   }
// }
//
// class NewWidget extends StatelessWidget {
//   final String ?txt1;
//   final IconData ?icon1;
//   final String ?screenName;
//   final int ?isLargWidth;
//   final Function ?btnFun;
//   const NewWidget({
//     Key? key,
//     Function, this.txt1, this.icon1, this.screenName, this.isLargWidth, this.btnFun
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//         onPressed: () => Get.toNamed(MyRoutScreen.home,),
//         child: InkWell(
//             onTap: () {
//               btnFun != null
//                   ? btnFun!() : Get.toNamed(screenName!);
//             },child: const Text("home")));
//   }
// }
