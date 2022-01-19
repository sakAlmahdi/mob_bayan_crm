import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:flutter/material.dart';


class NoData extends StatelessWidget {
  final double icnSize;
  final Color ? icnClr;
  final Color ? txtClr;
  const NoData({Key? key, this.icnSize=30,this.icnClr=Colors.grey, this.txtClr=Colors.black}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.do_not_disturb_alt,size:icnSize ,color: icnClr,),
        MyTextView(text:"لايوجد بيانات",txClr:txtClr,)
      ],
    );
  }
}
