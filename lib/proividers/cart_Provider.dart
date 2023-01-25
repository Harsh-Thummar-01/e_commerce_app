import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {

  List<ProductModel> products = [];

  addToCart(ProductModel product) {
    products.add(product);
    notifyListeners();
  }

  removeFromCart(ProductModel product) {
    products.remove(product);
    notifyListeners();
  }

  int getQty(ProductModel product) {
    int qty = 0;
    for (var value in products) {
      if (product.id == value.id) {
        qty++;
      }
    }

    return qty;
  }

  removeQty(ProductModel product) {
    products.removeWhere((element) => element.id == product.id);
    notifyListeners();
  }

  double getTotal() {
    double total = 0;
    for (var element in products) {
      total += element.price;
    }

    return total;
  }

  double getSingleTotal(ProductModel product){

    return product.price * getQty(product);
  }
   }


