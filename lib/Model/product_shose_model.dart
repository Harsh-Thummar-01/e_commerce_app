import 'dart:convert';

class ProductModel {
  ProductModel(
      {required this.id,
      this.imageUrl,
      required this.name,
      required this.price,
      this.normalPrice,
      required this.quantity,
      required this.category});

  int id;
  String? imageUrl;
  String name;
  int price;
  String? normalPrice;
  int quantity;
  String category;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        imageUrl: json["imageUrl"],
        name: json["name"],
        price: json["price"],
        normalPrice: json["normaPrice"],
        quantity: json["quantity"],
        category: json["category"],
      );

  static Map<String, dynamic> toMap(ProductModel productModel) => {
        "id": productModel.id,
        "imageUrl": productModel.imageUrl,
        "name": productModel.name,
        "price": productModel.price,
        "normaPrice": productModel.normalPrice,
        "quantity": productModel.quantity,
        "category": productModel.category
      };

  // static String encode(List<ProductModel> productModel) => json.encode(
  //       productModel
  //           .map<Map<String, dynamic>>(
  //               (ProductModels) => ProductModel.toMap(ProductModels))
  //           .toList(),
  //     );

  // static List<ProductModel> decode(String productModel) =>
  //     (json.decode(productModel) as List<dynamic>)
  //         .map<ProductModel>((item) => ProductModel.fromMap(item))
  //         .toList();
}











// class ProductModel {
//   int id;
//   String? imageUrl;
//   String? name;
//   double? price;
//   String? normalPrice;
//   int? quantity;
//
//  ProductModel({required this.imageUrl,required this.name,required this.price,required this.id, this.normalPrice,this.quantity});
//  factory ProductModel.fromMap(Map<String?,dynamic> map){
//   id = map['id'];
//   imageUrl = map['imageUrl'];
//   name = map['name'];
//   price = map['price'];
//   normalPrice = map['normalPrice'];
//  }
//
//  Map<String,dynamic>toMap(){
//   return{
//     'id':id,
//     'imageUrl':imageUrl,
//     'name':name,
//     'price':price,
//     'normalPrice':normalPrice
//   };
//  }
// }
