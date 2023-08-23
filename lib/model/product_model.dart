import 'dart:ffi';

class ProductModel {
  int? _id;
  String? _title;
  dynamic _price;
  String? _description;
  String? _category;
  String? _image;
  Rating? _rating;
  int? _cartCount = 0;

  ProductModel();

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get cartCount => _cartCount;
  set setCartCount(int? id) => _cartCount = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  dynamic get price => _price;
  set price(dynamic price) => _price = price;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get category => _category;
  set category(String? category) => _category = category;
  String? get image => _image;
  set image(String? image) => _image = image;
  Rating? get rating => _rating;
  set rating(Rating? rating) => _rating = rating;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _price = json['price'];
    _description = json['description'];
    _category = json['category'];
    _image = json['image'];
    _rating =
    json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['price'] = _price;
    data['description'] = _description;
    data['category'] = _category;
    data['image'] = _image;
    if (_rating != null) {
      data['rating'] = _rating!.toJson();
    }
    return data;
  }
}

class Rating {
  dynamic _rate;
  int? _count;

  Rating({double? rate, int? count}) {
    if (rate != null) {
      _rate = rate;
    }
    if (count != null) {
      _count = count;
    }
  }

  dynamic get rate => _rate;
  set rate(dynamic rate) => _rate = rate;
  int? get count => _count;
  set count(int? count) => _count = count;

  Rating.fromJson(Map<String, dynamic> json) {
    _rate = json['rate'];
    _count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = _rate;
    data['count'] = _count;
    return data;
  }
}
