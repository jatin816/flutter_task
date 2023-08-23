import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task/model/product_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../enums/endpoint.dart';
import '../../enums/http_method.dart';
import '../../enums/log_severity.dart';
import '../../model/rest_error.dart';
import '../../services/rest_api_service.dart';
import '../../services/service_locator.dart';
import '../../utils/app_constant.dart';
import '../../utils/log_util.dart';
import 'state.dart';

class ProductListLogic extends GetxController {
  final ProductListState state = ProductListState();
  List<ProductModel> cartItemList = [];
  BuildContext context = Get.context as BuildContext;

  @override
  void onInit() {
    productListApiCall(context);
    super.onInit();
  }

  Future<void> productListApiCall(BuildContext context) async {
    try {
      context.loaderOverlay.show();
      var listData = await productListUseCase();
      state.productList.clear();
      state.productList.addAll(listData);
      context.loaderOverlay.hide();
      manageCartItemCount();
      update();
    } on RestError catch (error) {
      context.loaderOverlay.hide();
      LogUtil.printLog(
          message: 'Error Occurred: ${error.toString()} ',
          methodName: 'productListApiCall',
          className: 'ProductListLogic',
          logSeverity: LogSeverity.Error);
    }
  }

  Future<List<ProductModel>> productListUseCase() async {
    try {
      var response = await locator<RestApiService>().makeRestCall(
          AppConstant.baseUrl,
          Endpoint.products,
          HttpMethod.Get,
          null,
          null,
          null);
      var responseData = response.data;

      if (responseData != null && response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return (response.data as List)
            .map((x) => ProductModel.fromJson(x))
            .toList();
      }

      throw RestError(
          statusCode: response.statusCode,
          message: response.statusMessage ?? '');
    } catch (error) {
      context.loaderOverlay.hide();
      rethrow;
    }
  }

  void manageCartItemCount() {
    if(GetStorage().read(AppConstant.cartItemCountKey) == null){
      return;
    }

    cartItemList.clear();
    List<ProductModel>? result = GetStorage().read<List<ProductModel>>(AppConstant.cartItemCountKey) ?? [];
    cartItemList.addAll(result ?? []);
    update();
    for (int index = 1; index < state.productList.length; index++) {
      for (int subIndex = 1; subIndex < cartItemList.length; subIndex++) {
        if (cartItemList[subIndex].id.toString() ==
            state.productList[index].id.toString()) {
            state.productList[index].setCartCount = cartItemList[subIndex].cartCount;
        }
      }
    }
  }
}
