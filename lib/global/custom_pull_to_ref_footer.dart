import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomPullToRefFooter extends GetResponsiveView {
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget? body;
        if (mode == LoadStatus.idle) {
        } else if (mode == LoadStatus.loading) {
          body = SpinKitThreeBounce(
            size: 40.sp,
            color: Theme.of(context).primaryColor,
          );
        } else if (mode == LoadStatus.failed) {
          body = Text(
            "فشل التحميل! انقر فوق إعادة المحاولة!",
            style: Theme.of(context).textTheme.caption,
          );
        } else if (mode == LoadStatus.canLoading) {
          body = const Text(
            "release_to_load_more",
            maxLines: 1,
          );
        } else {
          body = Text(
            "ليس هناك المزيد من البيانات ",
            style: Theme.of(context).textTheme.caption,
          );
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
