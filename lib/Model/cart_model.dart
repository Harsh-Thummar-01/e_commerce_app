
// ignore_for_file: public_member_api_docs, duplicate_ignore

class CartModel{

  CartModel({this.id, this.name, this.price, this.image, this.quantity});

  CartModel.fromMap(Map<String,String> map){
    id = map['id'];
    image = map['image'];
    name = map['name'];
    price = map['price'];
    quantity = map['quantity'];
  }
  // ignore: public_member_api_docs
  String? id;
  // ignore: public_member_api_docs
  String? name;
  String? price;
  String? quantity;
  String? image;
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
