
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nchat/common/pages/sign_in/controller.dart';
import 'package:nchat/common/styles/color.dart';
import 'package:nchat/common/values/shadows.dart';
import 'package:nchat/common/widgets/button.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {

    Widget buildLogo(){
      return Column(
          children: [
            Container(
              width: 76.w,
              height: 76.w,
              margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 84.h),
              decoration: BoxDecoration(
                  color: Colors.teal,
                  boxShadow: const [AppShadows.primaryBoxShadow],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/ic_launcher.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(40)
              ),
            ),
          ],
        );
    }

    Widget buildThirdPartyLogin(){
      return Container(
        width: 295.w,
        margin: EdgeInsets.only(bottom: 300.h),
        child: Column(
          children: [
            Text(
              'Sign in with Google',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1,
              color: AppColor.primaryBlack,
              ),
            ),

            Padding(
                padding: EdgeInsets.only(top: 20.h, left: 50.w, right: 50.w),
              child: btnFlatButtonWidget(
                width: 250.w,
                  height: 50.w,
                  title: 'Google Sign In',
                  onPressed: (){
                    controller.handleSignIn();
                  }),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            buildLogo(),
            Container(
              margin: EdgeInsets.only(top: 30.h),
              child: Text('Let\'s chat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  color: AppColor.primaryBlack,
                ),
              ),
            ),
            const Spacer(),
            buildThirdPartyLogin(),
          ],
        ),
      ),
    );
  }
}
