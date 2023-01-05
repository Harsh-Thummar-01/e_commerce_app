class ProductModel {
  String? id;
  String? imageUrl;
  String? name;
  String? price;

 ProductModel({this.imageUrl,required this.name,required this.price,required this.id});
 ProductModel.fromMap(Map<String,dynamic> map){
  id = map['id'];
  imageUrl = map['imageUrl'];
  name = map['name'];
  price = map['price'];
 }

 Map<String,dynamic>toMap(){
  return{
    'id':id,
    'imageUrl':imageUrl,
    'name':name,
    'price':price,
  };
 }
}
