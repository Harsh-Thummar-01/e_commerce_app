// ignore_for_file: public_member_api_docs

class ProductModel {

 ProductModel({this.imageUrl,this.name,this.price,this.id});
 ProductModel.fromMap(Map<String,String> map){
  id = map['id'];
  imageUrl = map['imageUrl'];
  name = map['name'];
  price = map['price'];


 }
  String? id;
  String? imageUrl;
  String? name;
  String? price;
 Map<String,dynamic>toMap(){
  return{
    'id':id,
    'imageUrl':imageUrl,
    'name':name,
    'price':price,
  };
 }
}
