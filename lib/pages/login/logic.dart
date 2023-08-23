import 'package:flutter_task/utils/app_constant.dart';
import 'package:flutter_task/utils/helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../route/app_routes.dart';
import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  managePasswordVisibility() {
    state.passwordVisible = !state.passwordVisible;
    update();
  }

  void loginUser() {
    var checkValidation = loginValidation();
    if(checkValidation){
      GetStorage().write(AppConstant.email, state.emailController.text.toString());
      Get.toNamed(AppPages.productList);
    }
  }

  loginValidation() {
    var allValidate = false;
    if(!validateEmail(state.emailController.text)){
      allValidate = false;
    } else if(!validatePassword(state.passwordController.text)){
      allValidate = false;
    } else {
      allValidate = true;
    }
    return allValidate;
  }
}
