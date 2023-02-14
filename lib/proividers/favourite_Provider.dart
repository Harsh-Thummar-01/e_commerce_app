import 'dart:convert';
import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteProvider with ChangeNotifier {
  List<int> favouriteProducts = [];
  List<ProductModel> favProductModel = [];
  void addToFavProduct(ProductModel product) {
    favouriteProducts.add(product.id);
    favProductModel.add(product);
    setLocalData();
    notifyListeners();
  }

  void remToFavProduct(ProductModel product) {
    favouriteProducts.remove(product.id);
    favProductModel.removeWhere((e) => e.id == product.id);
    setLocalData();
    notifyListeners();
  }

  bool isFavProduct(ProductModel product) {
    return favouriteProducts.contains(product.id);
  }

  Future<void> setLocalData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(
        "favouriteId", favouriteProducts.map((e) => e.toString()).toList());
    final String productData = encode(favProductModel);
    pref.setString("favourite", productData);
    notifyListeners();
  }

  Future<void> getLocalData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    favouriteProducts =
        pref.getStringList("favouriteId")!.map(int.parse).toList();
    final String productString = pref.getString("favourite") ?? "";
    favProductModel = decode(productString);

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

  // Future<void> encodeData() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setStringList(
  //       "favouriteId", favouriteProducts.map((e) => e.toString()).toList());
  //   String public =
  //       jsonEncode(favProductModel.map((e) => ProductModel.toMap(e)).toList());
  //   await pref.setString("favour", public);
  //   notifyListeners();
  // }

  // Future<void> decodeData() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   favouriteProducts =
  //       pref.getStringList("favouriteId")!.map(int.parse).toList();
  //   String private = pref.getString("favour") ?? "";

  //   notifyListeners();
  // }
}
