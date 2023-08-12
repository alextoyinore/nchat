/*
* Here we declare our bindings
* */

import 'package:get/get.dart';
import 'package:nchat/common/pages/contact/controller.dart';
import 'package:nchat/common/pages/message/controller.dart';
import 'controller.dart';

class ApplicationBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<MessageController>(() => MessageController());
  }

}
