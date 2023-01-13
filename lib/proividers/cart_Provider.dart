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
    products.forEach((element) {
      total += element.price;
    });
    return total;
  }

  double getSingleTotal(ProductModel product){
    return product.price * getQty(product);
  }

// void addToCart(
//   int id,
//   String name,
//   String price,
//   String quantity,
//   String image
// ) async {
//    FirebaseFirestore.instance
//       .collection("users")
//       .doc(user!.uid)
//       .collection("item")
//       .doc(id.toString())
//       .set({
//     "id": id,
//     "name": name,
//     "price": price,
//     "image": image,
//     "quantity": quantity
//   });
// }
// int _counter = 0;
//
// int get counter => _counter;
//
// double _totalPrice = 0.0;
//
// double get totalPrice => _totalPrice;
//
// late Future<List<ProductModel>> _cart;
//
// Future<List<ProductModel>> get cart => _cart;
//
// void _setPrefItems() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setInt("cart_item", _counter);
//   prefs.setDouble("total_price", _totalPrice);
//   notifyListeners();
// }
//
// void _getPrefItems() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   _counter = prefs.getInt("cart_item") ?? 0;
//   _totalPrice = prefs.getDouble("total_price") ?? 0.0;
//   notifyListeners();
// }
//
// void addTotalPrice(double productPrice) {
//   _totalPrice = _totalPrice + productPrice;
//   _setPrefItems();
//   notifyListeners();
// }
//
// void removeTotalPrice(double productPrice) {
//   _totalPrice = _totalPrice - productPrice;
//   _getPrefItems();
//   notifyListeners();
// }
//
// double getTotalPrice() {
//   _getPrefItems();
//   return _totalPrice;
// }
//
// void addCounter() {
//   _counter++;
//   _setPrefItems();
//   notifyListeners();
// }
//
// void removeCounter(int id) {
//   _counter--;
//   _getPrefItems();
//   notifyListeners();
// }
//
// int getCounter() {
//   _getPrefItems();
//   return _counter;
// }
}
