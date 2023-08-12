import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nchat/common/pages/application/state.dart';
import 'package:nchat/common/styles/color.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();
  ApplicationController();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  void handlePageChanged(int index) {
    state.page = index;
  }

  void handleBottomNavBarTap(int index) {
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    tabTitles = ['Chat', 'Contact', 'Profile'];
    bottomTabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.message,
          color: AppColor.primaryBlack_40,
        ),
        label: 'Chat',
        activeIcon: const Icon(
          Icons.message,
          color: AppColor.primaryBlack,
        ),
        backgroundColor: AppColor.primaryBG,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.contact_page,
          color: AppColor.primaryBlack_40,
        ),
        label: 'Contact',
        activeIcon: const Icon(
          Icons.contact_page,
          color: AppColor.primaryBlack,
        ),
        backgroundColor: AppColor.primaryBG,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: AppColor.primaryBlack_40,
        ),
        label: 'Profile',
        activeIcon: const Icon(
          Icons.person,
          color: AppColor.primaryBlack,
        ),
        backgroundColor: AppColor.primaryBG,
      ),
    ];
    pageController = PageController(initialPage: state.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
