
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

import '../routes/names.dart';
import '../store/config.dart';
import '../store/user.dart';

class RouteWelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {

    print(ConfigStore.to.isFirstOpen);

    if (ConfigStore.to.isFirstOpen == false) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      return const RouteSettings(name: AppRoutes.Application);
    } else {
      return const RouteSettings(name: AppRoutes.SignIn);
    }
  }
}