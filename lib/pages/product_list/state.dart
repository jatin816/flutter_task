import 'package:flutter/material.dart';
import 'package:flutter_task/model/product_model.dart';

class ProductListState {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<ProductModel> productList = [];

  ProductListState() {
    ///Initialize variables
  }
}
