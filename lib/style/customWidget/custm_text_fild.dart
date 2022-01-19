import 'package:auto_size_text/auto_size_text.dart';
import 'package:bayan/dealWithScreenSize/responsbal_screen_size.dart';
import 'package:bayan/style/widgetStyle/custom_colors.dart';
import 'package:bayan/style/widgetStyle/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MyTextInput extends StatelessWidget {
  const MyTextInput(
      {Key ? key,
      required this.textEditingController,
      this.obscureText=false,
      this.icon,
      this.labelText="",
      this.keyboardType,
      this.icon2,
      this.suffixText,
      this.maxLength,
      this.isRequired = 0,
      this.errorTxt,
      this.enabledTxt=true, this.autofocusText=false, this.maxline=1,});

  final TextEditingController textEditingController;
  final bool obscureText;
  final bool autofocusText;
  final bool enabledTxt;
  final IconData ?icon;
  final Widget? icon2;
  final String ?labelText, suffixText;
  final int ?maxLength,isRequired,maxline;
  final TextInputType ?keyboardType;
  final FormFieldValidator<String> ?errorTxt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextView(
            text: labelText!.tr,
          ),
          TextFormField(
            maxLines: maxline,
            enabled: enabledTxt,
            autofocus: autofocusText,
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColor().whiteClr,
              errorMaxLines: 2,
              contentPadding: icon!=null?EdgeInsets.zero:EdgeInsets.symmetric(horizontal: 2),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: MyColor().btnClr, width: 1.5.r)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: MyColor().btnClr, width: 1.5),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: MyColor().btnClr, width: 1.5)),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1.5, color: Colors.red)),
              errorStyle: MyTextStyle(textColor:Colors.red,fontSize: 11).myTextStyle(),
              hintText: labelText!.tr,
              hintStyle: MyTextStyle(textColor: MyColor().txtHntClr.withOpacity(0.4),fontSize: 12).myTextStyle(),
              prefixText: icon==null?"  ":null,
              prefixIcon: icon!=null?Container(
                  height: 25.h.w,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.0.r),
                            topRight: Radius.circular(10.0.r)),
                    color: MyColor().icnInputTxtClr,
                  ),
                  child: Icon(icon,color: Colors.white,)):null,
                  // child: CustomIcons().myIcon(myIcons: icon,)):null,
              suffixText: suffixText,
              suffixStyle: MyTextStyle(textColor: MyColor().txtHntClr.withOpacity(0.4),fontSize: 13).myTextStyle(),
              suffixIcon: icon2,
            ),
            style: MyTextStyle(fontSize: 13).myTextStyle(),
            maxLength: maxLength,
            textInputAction: TextInputAction.next,
            keyboardType: keyboardType,
            controller: textEditingController,
            cursorColor: MyColor().btnClr,
            obscureText: obscureText,
            validator: (x) => x!.isEmpty && isRequired == 1
                ?"يرجئ ادخال "+ labelText!.tr
                : errorTxt != null && isRequired == 1
                    ? errorTxt!(x)
                    : null,
          ),
        ],
      ),
    );
  }
}


class NoteTextInput extends StatelessWidget {
  const NoteTextInput(
      {Key ? key,
      required this.textEditingController,
      this.labelText="", this.txtName:"", this.maxLine:5,});

  final TextEditingController textEditingController;
  final String labelText;
  final String txtName;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextView(
          text: txtName.tr,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.transparent,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: MyColor().whiteClr,
              contentPadding: EdgeInsets.all(2),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: MyColor().btnClr, width: 1.5),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: MyColor().btnClr, width:1.5)),
              prefixText: "  ",
              hintText: " ${labelText.tr}",
              hintStyle: MyTextStyle(textColor: MyColor().txtHntClr.withOpacity(0.4),fontSize: 12).myTextStyle(),
            ),
            style: MyTextStyle(fontSize: 13).myTextStyle(),
            controller: textEditingController,

            cursorColor: MyColor().btnClr,
            minLines:1,
            maxLines:maxLine,
          ),
        ),
      ],
    );
  }
}


class MyPasswordTxtFld extends StatefulWidget {
  final TextEditingController textEditingController;
  final String ?text;
  final bool ?isLogin;
  final bool ?isChangePass;
  final int isRequiredTxt;
  final bool enabledText;
  final FormFieldValidator<String> ?errorPassTxt;

  MyPasswordTxtFld({required this.textEditingController, this.text="كلمة السر", this.isLogin, this.isRequiredTxt=1, this.enabledText=true, this.errorPassTxt, this.isChangePass});

  @override
  _MyPasswordTxtFldState createState() => _MyPasswordTxtFldState();
}

class _MyPasswordTxtFldState extends State<MyPasswordTxtFld> {
   bool showPass = true;
  @override
  Widget build(BuildContext context) {
    return  MyTextInput(
      enabledTxt: widget.enabledText,
          isRequired: widget.isRequiredTxt,
          textEditingController: widget.textEditingController,
          labelText: widget.text,
          obscureText: showPass,
          icon: Icons.lock_open_outlined,
          errorTxt: (x) {
            if(widget.isLogin == true) {
              return null;
            } else if(x!.trim().length<6) {
              return "هذا الحقل تاقض";
            } else if(widget.errorPassTxt!=null){
              return widget.errorPassTxt!(x);
            }
            else return null;
          },
          // => widget.isLogin == true
          //     ? null
          //     : widget.errorPassTxt!=null?widget.errorPassTxt(x):Get.find<GtxFun>().validatePassword(passTxt: x),
          icon2: IconButton(
            onPressed: () {
              setState(() {
                showPass =!showPass;
              });
            },
            icon:Icon(showPass? Icons.visibility_off :Icons.visibility) ,
            // icon: CustomIcons().myIcon(
            //     myIcons:showPass
            //         ? Icons.visibility_off
            //         : Icons.visibility),
          ),
        );
  }
}


class MyTextView extends StatelessWidget {
  const MyTextView(
      {Key ?key, this.text, this.isAlgCenter, this.txClr, this.txSize=10, this.bgClr, this.txtFontWeight});
   final String ?text;
  final int ?isAlgCenter;
  final double ?txSize;
  final Color ?txClr;
  final Color ?bgClr;
  final FontWeight ?txtFontWeight;

  @override
  Widget build(BuildContext context) {
    return
      AutoSizeText(
      text!.tr,
      minFontSize: 7,
      maxFontSize:16,
      softWrap: true,
      wrapWords: true,
      textAlign:  isAlgCenter == 1 ? TextAlign.center : TextAlign.start,
      style:TextStyle(color:txClr??Colors.black,fontSize:SizeScreen.isSmallScreen()?txSize:txSize!.sp,fontWeight:txtFontWeight??FontWeight.normal,fontFamily: "Cairo",) ,
    );
    //   Text(
    //   text.tr,
    //   style: MyTextStyle(textColor: txClr??Colors.black,fontSize:txSize??11,fontWeight: txtFontWeight??FontWeight.normal ).myTextStyle(),
    //   textAlign: isAlgCenter == 1 ? TextAlign.center : TextAlign.start,
    // );
  }
}
