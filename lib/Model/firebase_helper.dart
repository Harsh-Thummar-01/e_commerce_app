import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/user_model.dart';

class FirebaseHelper {

  static Future getUserModelbyId(String uid) async {
    UserModel? userModel;
    DocumentSnapshot docsnapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();


    if (docsnapshot.data() != null) {
      userModel = UserModel.fromMap(docsnapshot.data() as Map<String, dynamic>);
    }
    return userModel;
  }

}