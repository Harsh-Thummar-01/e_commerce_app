import 'dart:convert';

import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<ProductModel> products = [];

  addToCart(ProductModel product) {
    products.add(product);
    setLocalProductData();
    notifyListeners();
  }

  removeFromCart(ProductModel product) {
    products.remove(product);
    setLocalProductData();
    notifyListeners();
  }

  removeAllData(ProductModel product) {
    products.clear();
    setLocalProductData();
  }

  int getQty(ProductModel product) {
    int qty = 0;
    for (var value in products) {
      if (product.id == value.id) {
        qty++;
      }
    }
    setLocalProductData();
    return qty;
  }

  removeQty(ProductModel product) {
    products.removeWhere((element) => element.id == product.id);
    setLocalProductData();
    notifyListeners();
  }

  double getTotal() {
    double total = 0;
    for (var element in products) {
      total += element.price;
    }
    setLocalProductData();
    return total;
  }

  int getSingleTotal(ProductModel product) {
    int singleTotal = product.price * getQty(product);
    setLocalProductData();
    return singleTotal;
  }

  Future<void> setLocalProductData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String productData = encode(products);
    pref.setString("products", productData);
    notifyListeners();
  }

  Future<void> getLocalProductData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final String productString = pref.getString("products") ?? "";
    products = decode(productString);

    notifyListeners();
  }

  static String encode(List<ProductModel> productModel) => jsonEncode(
        productModel
            .map((productModels) => ProductModel.toMap(productModels))
            .toList(),
      );

  static List<ProductModel> decode(String productModel) =>
      (jsonDecode(productModel) as List<dynamic>)
          .map<ProductModel>((item) => ProductModel.fromMap(item))
          .toList();
}
