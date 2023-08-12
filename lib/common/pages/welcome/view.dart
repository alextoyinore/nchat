
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nchat/common/pages/welcome/controller.dart';
import 'package:nchat/common/styles/color.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>SizedBox(
        width: 360.w,
        height: 780.w,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              reverse: false,
              onPageChanged: (index) => controller.changePage(index),
              controller: PageController(
                  initialPage: 0,
                  keepPage: false,
                  viewportFraction: 1
              ),
              pageSnapping: true,
              physics: const ClampingScrollPhysics(),
              children: [
                // Intro banner 1
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/banner1.png'),
                        fit: BoxFit.fill,
                      )
                  ),
                ),

                // Intro banner 2
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/banner2.png'),
                        fit: BoxFit.fill,
                      )
                  ),
                ),

                // Intro banner 3
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/banner3.png'),
                        fit: BoxFit.fill,
                      )
                  ),

                  // Login Button

                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        bottom: 100,
                        child:
                        ElevatedButton(
                          onPressed: () => controller.handleSignIn(),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(AppColor.primaryBG),
                              foregroundColor: MaterialStateProperty.all(AppColor.primaryBlack),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              )),
                              fixedSize: MaterialStateProperty.all(Size(250.w, 50.w))
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                    bottom: 50,
                    child: DotsIndicator(
                      dotsCount: 3,
                      decorator: DotsDecorator(
                        color: AppColor.primaryBG.withOpacity(.2),
                        activeColor: AppColor.primaryBG,
                        size: const Size.square(9),
                        activeSize: const Size(18, 9),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      position: controller.state.index.value.toInt(),
                    )
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
