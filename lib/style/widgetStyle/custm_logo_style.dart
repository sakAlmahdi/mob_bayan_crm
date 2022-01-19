import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  final double ?logoWth;
  final String ?logoImg;
  final String ?bgImage;

  const MyLogo({Key ?key, this.logoWth, this.bgImage, this.logoImg:'asset/img/cntnrLogo.png'});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: logoWth!/1.5,
      backgroundColor: Colors.transparent,
      backgroundImage:bgImage!=null?AssetImage(bgImage!):null,
      child: Image(
        alignment: Alignment.center,
        image: AssetImage(logoImg!),
        fit: BoxFit.contain,
        height: logoWth,
        width: logoWth,
      ),
    );
  }
}
