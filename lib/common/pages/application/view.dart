import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nchat/common/pages/application/controller.dart';
import 'package:nchat/common/pages/contact/index.dart';
import 'package:nchat/common/pages/message/index.dart';
import 'package:nchat/common/styles/color.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {

    Widget buildPageView(){
      return PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlePageChanged,
        children: const[
          MessagePage(),
          ContactPage(),
          Center(child: Text('Profile')),
        ],
      );
    }

    Widget buildBottomNavigationBar(){
      return Obx(
        () => BottomNavigationBar(
            items: controller.bottomTabs,
          currentIndex: controller.state.page,
          type: BottomNavigationBarType.fixed,
          onTap: controller.handleBottomNavBarTap,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColor.primaryBlack,
          unselectedItemColor: AppColor.primaryBlack_40,
        ),
      );
    }

    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}
