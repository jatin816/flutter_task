import 'package:get/get.dart';

import 'logic.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductListLogic());
  }
}
