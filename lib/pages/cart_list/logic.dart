import 'package:flutter_task/model/product_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/app_constant.dart';
import '../product_list/logic.dart';
import 'state.dart';

class CartListLogic extends GetxController {
  final CartListState state = CartListState();
  final productLogic = Get.find<ProductListLogic>();
  List<ProductModel> cartItemList = [];
  double itemTotalAmount = 0.0;

  @override
  void onInit() {
    getCartItemList();
    super.onInit();
  }

  void getCartItemList(){
    var result = productLogic.state.productList.where((element) => element.cartCount != 0).toList();
    cartItemList.clear();
    cartItemList.addAll(result);
    update();
  }

  void removeFromCart(int id) {
    int index = productLogic.state.productList.indexWhere((element) => element.id == id);
    productLogic.state.productList[index].setCartCount = 0;
    update();
    List<ProductModel> result = productLogic.state.productList.where((element) => element.cartCount != 0).toList();
    GetStorage().write(AppConstant.cartItemCountKey, result);
    if(cartItemList.isEmpty){
      Get.back();
    }
  }

  void calculateTotalAmount(){
    itemTotalAmount = 0;
    for (var element in cartItemList) {
      if(element.cartCount != 0) {
        var qty = element.cartCount ?? 0.0;
        var price = element.price;
        itemTotalAmount = itemTotalAmount + (qty * price);
      }
    }
    update();
  }

  void updateCartQty(int? id, int? cartCount) {
    int index = productLogic.state.productList.indexWhere((element) => element.id == id);
    productLogic.state.productList[index].setCartCount = cartCount;
    calculateTotalAmount();
  }
}