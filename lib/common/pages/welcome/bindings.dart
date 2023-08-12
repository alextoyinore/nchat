/*
* Here we declare our bindings
* */

import 'package:get/get.dart';
import 'package:nchat/common/pages/welcome/controller.dart';

class WelcomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}

