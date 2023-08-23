import 'package:get/get.dart';

import 'logic.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailLogic());
  }
}
