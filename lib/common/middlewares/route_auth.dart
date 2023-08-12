
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../routes/names.dart';
import '../store/user.dart';

class RouteAuthMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin || route == AppRoutes.SignIn || route == AppRoutes
        .Initial) {
      return null;
    } else {
      Future.delayed(
          const Duration(seconds: 1), () => Get.snackbar("提示", "登录过期,请重新登录"));
      return const RouteSettings(name: AppRoutes.SignIn);
    }
  }
}
