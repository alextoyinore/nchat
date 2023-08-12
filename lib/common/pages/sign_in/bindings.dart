/*
* Here we declare our bindings
* */

import 'package:get/get.dart';
import 'package:nchat/common/pages/sign_in/controller.dart';

class SignInBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }

}

