// ignore_for_file: public_member_api_docs

class UserModel {
  String? uid;
  String? email;
  String? userName;
  String? firstName;
  String? lastName;
  String? comment;
  String? imageUrl;

  UserModel(
      {this.uid,
        this.email,
        this.userName,
        this.firstName,
        this.lastName,
        this.comment,
        this.imageUrl,});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    email = map['email'];
    userName = map['userName'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    comment = map['comment'];
    imageUrl = map['imageUrl'];
  }



  Map<String, dynamic> toMap() {
    
    return{
      'uid':uid,
      'email':email,
      'userName':userName,
      'firstName':firstName,
      'lastName':lastName,
      'comment':comment,
      'imageUrl':imageUrl
    };
  }
  
}
