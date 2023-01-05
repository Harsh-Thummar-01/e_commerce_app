import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:flutter/cupertino.dart';

class FavProvider with ChangeNotifier {
  List<ProductModel> fav = [];

  bool isFav(ProductModel model) {
    return fav.contains(model);
  }
}
