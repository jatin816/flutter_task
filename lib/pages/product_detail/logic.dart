import 'package:flutter_task/model/product_model.dart';
import 'package:flutter_task/utils/app_constant.dart';
import 'package:get/get.dart';

import 'state.dart';

class ProductDetailLogic extends GetxController {
  var cartCount = 0;
  final ProductDetailState state = ProductDetailState();
  ProductModel productDetails = ProductModel();
  var selectedIndex = 0;
  @override
  void onInit() {
    super.onInit();
    selectedIndex = Get.arguments[AppConstant.productIndex];
    update();
  }
}
