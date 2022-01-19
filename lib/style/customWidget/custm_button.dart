
import 'package:bayan/style/customWidget/custm_text_fild.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:bayan/style/widgetStyle/icons_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  final GestureTapCallback buttonFun;
  final String ?buttonText;
  final double ?widthSize;
  final double ?verticalPadding;
  final double ?horzPad;
  final Color ?buttonColor;
  final double ?txtSize;

   MyButton({Key? key,
    required this.buttonFun,
    this.widthSize,
    this.buttonText, this.buttonColor, this.verticalPadding=10, this.horzPad=2, this.txtSize=10});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: horzPad!.w),
      child: GestureDetector(
        onTap: buttonFun,
        child: Container(
          width: widthSize,
            padding: EdgeInsets.symmetric(horizontal:10.w,vertical: verticalPadding!.h),
            decoration: BoxDecoration(
                color: buttonColor??MyColor().btnClr,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: MyColor().btnClr,width: 1.5)
            ),
            child: MyTextView(text: buttonText,txSize: txtSize,txClr: buttonColor!=null?MyColor().btnClr:MyColor().whiteClr,isAlgCenter: 1,))
      ),
    );
  }
}
///sss

// class MyButton2 extends StatelessWidget {
//   final Function buttonFun;
//   final String buttonText;
//   final double widthSize;
//   final double verticalPadding;
//   final double horzPad;
//   final Color buttonColor;
//   final bool isclick;
//
//   const MyButton2({Key key,
//     this.buttonFun,
//     this.widthSize,
//     this.buttonText, this.buttonColor, this.verticalPadding=10, this.horzPad=2, this.isclick});
//   @override
//   Widget build(BuildContext context) {
//     return  GestureDetector(onTap: buttonFun,
//       child: Card(shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0)),
//         color:isclick==true?Colors.cyan:Colors.red,
//         margin: EdgeInsets.symmetric(horizontal: 5),
//         child: Container(width: 60,height: 35,child: Center(child: MyTextView(isAlgCenter: 1,text: buttonText,txSize: 14,txClr: MyColor().whiteClr,))),),
//     );
//   }
// }


class CustomTextBtn extends StatelessWidget {
  final GestureTapCallback onPressedFun;
  final String buttonText;
    CustomTextBtn({Key ? key, required this.onPressedFun,required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed:onPressedFun,
        child: MyTextView(text: buttonText,));
  }
}

// class CustomIconBtn extends StatelessWidget {
//   final Function onPressedFun;
//   final IconData icn;
//   final Color icnClr;
//   const CustomIconBtn({Key key, @required this.onPressedFun,this.icn, this.icnClr});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//         onPressed: onPressedFun,
//         child: CustomIcons().myIcon(myIcons: icn??Icons.add_reaction_rounded,icnClr:icnClr ));
//   }
// }

class EditBtn extends StatelessWidget {
  final GestureTapCallback  onPressedFun;
  const EditBtn({key,required this.onPressedFun}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed:onPressedFun,
     child: CustomIcons().myIcon(myIcons: Icons.drive_file_rename_outline,icnClr: Colors.black ),);
  }
}
class DeleteBtn extends StatelessWidget {
  final GestureTapCallback onPressedFun;
  const DeleteBtn({key,required this.onPressedFun}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed:onPressedFun,
     child: CustomIcons().myIcon(myIcons: Icons.delete,icnClr: Colors.red ),);
  }
}
// class ShowBtn extends StatelessWidget {
//   final Function onPressedFun;
//   const ShowBtn({key,@required this.onPressedFun}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(onPressed:onPressedFun,
//      child: CustomIcons().myIcon(myIcons: Icons.remove_red_eye,icnClr: Colors.black ),);
//   }
// }
