/*
Here we declare all our variables
*/

import 'package:get/get.dart';

class ApplicationState {
  /*
  obs makes a variable observable. If this variable changes,
  ui will be rebuilt.
  Variables used in our login logic will be tracked here so it can be accessed
  upward from controllers
  */

  // Tab index
  final _page = 0.obs;
  int get page => _page.value;
  set page(value) => _page.value = value;
}