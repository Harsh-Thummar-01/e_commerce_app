


class CartModel{
  int? id;
  String? name;
  double? price;
  int? quantity;
  String? image;

  CartModel({this.id, this.name, this.price, this.image, this.quantity});

  CartModel.fromMap(Map<String,dynamic> map){
    id = map['id'];
    image = map['image'];
    name = map['name'];
    price = map['price'];
    quantity = map['quantity'];
  }


  Map<String,dynamic>toMap(){
    return{
      'id':id,
      'image':image,
      'name':name,
      'price':price,
      'quantity':quantity
    };
  }

}
