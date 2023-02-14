


class CartModel{
  int id;
  String name;
  int price;
  int quantity;
  String? image;

  CartModel({required this.id, required this.name, required this.price, this.image, required this.quantity});

  factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    price: json["price"],
    quantity: json["quantity"],
  );



  static Map<String, dynamic> toMap(CartModel cartModel) => {
    "id": cartModel.id,
    "imageUrl": cartModel.image,
    "name": cartModel.name,
    "price": cartModel.price,
    "quantity": cartModel.quantity,
  };

}
