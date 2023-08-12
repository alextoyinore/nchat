import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/color.dart';

///  AppBar
AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColor.primaryElement.withOpacity(.9),
          AppColor.primaryElement,
          AppColor.primaryElement.withOpacity(.9),
        ], transform: const GradientRotation(90)),
        // color: AppColor.primaryBlack,
      ),
    ),
    title: title != null ? Center(child: title) : null,
    leading: leading,
    actions: actions,
  );
}

/// 10像素 Divider
Widget divider10Px({Color bgColor = AppColor.secondaryElement}) {
  return Container(
    height: 10.w,
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}
