/*
Here we declare all our variables
*/

import 'package:get/get.dart';
import 'package:nchat/common/entities/user.dart';

class ContactState {
  /*
  obs makes a variable observable. If this variable changes,
  ui will be rebuilt.
  Variables used in our login logic will be tracked here so it can be accessed
  upward from controllers
  */

  var count = 0.obs;
  RxList<UserData> contactList = <UserData>[].obs;
}