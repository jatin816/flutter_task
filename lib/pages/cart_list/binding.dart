import 'package:get/get.dart';

import 'logic.dart';

class CartListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartListLogic());
  }
}
