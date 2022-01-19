import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/widgetStyle/icons_style.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
 final String contactName;
 final String date;
 final String mobile;
 final String name;
 final String requirment;
 final String followType;
   MyCard({Key? key, required this.contactName, required this.date, required this.mobile, required this.name, required this.requirment, required this.followType}) : super(key: key);

  @override
  Widget build(BuildContext context,) {

    return Card(
      // margin: const EdgeInsets.symmetric(vertical:5),
      // elevation: 1,
      // shape:  RoundedRectangleBorder(side:BorderSide(width: 1,color:Color(0xFFBDBDBD)) ),
      color:Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:6.0,vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Row(
              children: [
                Expanded(child: MyTextView(text: contactName.toString(),txSize: 12,)),
                MyTextView(text: date.toString(),txSize: 12,txClr: Colors.grey,),
                CustomIcons().myIcon(myIcons: Icons.date_range_rounded,iconSiz: 20),
              ],
            ),
            Row(
              children: [
                // CustomIcons().myIcon(myIcons: Icons.title,iconSiz: 20),
                Expanded(child: MyTextView(text:name.toString(),txSize: 10,txClr: Colors.grey,)),
                MyTextView(text: mobile.toString(),txSize: 12,),
                CustomIcons().myIcon(myIcons: Icons.phone,iconSiz: 20)
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Expanded(flex: 2,child: MyTextView(text:requirment.toString(),txSize: 10,txClr: Colors.grey,)),
                Expanded(child: Card(color: Colors.black,child: MyTextView(text: followType.toString(),isAlgCenter: 1,txSize: 11,txClr: Colors.grey,))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
