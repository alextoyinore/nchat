
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nchat/common/styles/color.dart';

import '../values/radii.dart';

Widget btnFlatButtonWidget({
  required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color bgColor = AppColor.primaryElement,
  Color fontColor = AppColor.primaryBG,
  String title = 'Button',
  double fontSize = 16,
  String fontName = 'Montserrat',
  FontWeight fontWeight = FontWeight.w400
}){
  return SizedBox(
    width: width,
    height: height,
    child: TextButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 16.sp),
        ),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.focused) &&
              !states.contains(MaterialState.pressed)){
            return AppColor.primaryElement;
          }else if(states.contains(MaterialState.pressed)){
            return AppColor.secondaryElement;
          }
          return AppColor.primaryElement;
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return AppColor.secondaryElement;
          }
          return bgColor;
        }),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: Radii.k6pxRadius,
        ))
      ),
      onPressed: onPressed,
      child: Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontWeight: fontWeight,
          fontSize: fontSize.sp,
          height: 1,
        ),
      ),
    ),
  );
}

Widget btnFlatButtonBorderOnlyWidget({
  required VoidCallback onPressed,
  double width = 88,
  double height = 44,
  required String iconFileName,
}){
  return SizedBox(
    width: width,
    height: height,
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
          borderRadius: Radii.k6pxRadius,
        )),
      ),
      onPressed: onPressed,
      child: Image.asset('assets/images/$iconFileName.png'),
    ),
  );
}