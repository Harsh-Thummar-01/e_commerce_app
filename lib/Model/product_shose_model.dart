
class ProductModel {
  ProductModel({
    required this.id,
    this.imageUrl,
    required this.name,
    required this.price,
    required this.normalPrice,
    required this.quantity,
  });

  int id;
  String? imageUrl;
  String name;
  int price;
  String normalPrice;
  int quantity;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    imageUrl: json["imageUrl"],
    name: json["name"],
    price: json["price"],
    normalPrice: json["normaPrice"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "imageUrl": imageUrl,
    "name": name,
    "price": price,
    "normaPrice": normalPrice,
    "quantity": quantity,
  };
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
