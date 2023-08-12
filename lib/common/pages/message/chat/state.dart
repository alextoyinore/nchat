/*
Here we declare all our variables
*/

import 'package:get/get.dart';
import 'package:nchat/common/entities/entities.dart';

class ChatState {
  /*
  obs makes a variable observable. If this variable changes,
  ui will be rebuilt.
  Variables used in our login logic will be tracked here so it can be accessed
  upward from controllers
  */

  RxList<MsgContent> msgContentList = <MsgContent>[].obs;
  var to_uid = ''.obs;
  var to_name = ''.obs;
  var to_avatar = ''.obs;
  var to_location = 'Unknown'.obs;
}
