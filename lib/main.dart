import 'package:e_commerce_app/Model/firebase_helper.dart';
import 'package:e_commerce_app/Model/user_model.dart';
import 'package:e_commerce_app/admin/login_page.dart';

import 'package:e_commerce_app/home_page.dart';
import 'package:e_commerce_app/proividers/fav_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelbyId(currentUser.uid);
        // ProductModel? thisProductModel = await FirebaseHelper.getFavoriteData(currentUser.uid);
    if (thisUserModel != null) {
      runApp(MainScreen(
        firebaseUser: currentUser,
        userModel: thisUserModel,
      ));
    } else {
      runApp(const MyApp());
    }
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;


  const MainScreen(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => FavProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          home:   HomePage(userModel: userModel, firebaseUser: firebaseUser,)),
    );
  }
}
