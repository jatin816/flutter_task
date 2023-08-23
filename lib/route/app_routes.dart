import 'package:flutter_task/pages/cart_list/binding.dart';
import 'package:flutter_task/pages/cart_list/view.dart';
import 'package:flutter_task/pages/product_detail/binding.dart';
import 'package:flutter_task/pages/product_detail/view.dart';
import 'package:flutter_task/pages/product_list/binding.dart';
import 'package:flutter_task/pages/splash/view.dart';
import 'package:get/get.dart';

import '../pages/login/binding.dart';
import '../pages/login/view.dart';
import '../pages/product_list/view.dart';

class AppPages {
  AppPages._();

  static const login = '/Login';
  static const productList = '/ProductList';
  static const productDetails = '/ProductDetails';
  static const cartDetail = '/CareDetail';

  static final routes = [
    GetPage(name: '/', page: () => SplashPage()),
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: productList, page: () => ProductListPage(), binding: ProductListBinding()),
    GetPage(name: productDetails, page: () => ProductDetailPage(), binding: ProductDetailBinding()),
    GetPage(name: cartDetail, page: () => CartListPage(), binding: CartListBinding()),
  ];
}
