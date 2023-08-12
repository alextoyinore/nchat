
import 'package:get/get.dart';
import 'package:nchat/common/pages/welcome/state.dart';
import 'package:nchat/common/routes/names.dart';
import 'package:nchat/common/store/config.dart';

class WelcomeController extends GetxController{
  final state = WelcomeState();
  WelcomeController();
  changePage(int index) async {
    state.index.value = index;
  }

  handleSignIn() async{
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.SignIn);
  }
}