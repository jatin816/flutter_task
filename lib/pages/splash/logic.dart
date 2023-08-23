import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../route/app_routes.dart';
import '../../utils/app_constant.dart';
import 'state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();

  @override
  void onInit() {
    super.onInit();
    gotoNextScreen();
  }

  gotoNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isUserLoggedIn = GetStorage().read(AppConstant.email) ?? false;
    if (isUserLoggedIn) {
      Get.offAndToNamed(AppPages.productList);
    } else {
      Get.offAndToNamed(AppPages.login);
    }
  }
}
