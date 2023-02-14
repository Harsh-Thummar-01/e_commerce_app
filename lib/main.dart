import 'package:e_commerce_app/Model/firebase_helper.dart';
import 'package:e_commerce_app/Model/user_model.dart';
import 'package:e_commerce_app/admin/login_page.dart';
import 'package:e_commerce_app/home_page.dart';
import 'package:e_commerce_app/proividers/cart_Provider.dart';
import 'package:e_commerce_app/proividers/favourite_Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser!;
  // ignore: unnecessary_null_comparison
  if (currentUser != null) {
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelbyId(currentUser.uid);

    if (thisUserModel != null) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => FavouriteProvider(),
            ),
          ],
          child: MyApp(userModel: thisUserModel, firebaseUser: currentUser),
        ),
      );
    } else {
      runApp(
        const MyAppLogging(),
      );
    }
  } else {
    runApp(
      const MyAppLogging(),
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
  }) : super(key: key);
  User firebaseUser;
  UserModel userModel;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(
          userModel: widget.userModel, firebaseUser: widget.firebaseUser),
    );
  }
}

class MyAppLogging extends StatefulWidget {
  const MyAppLogging({super.key});

  @override
  State<MyAppLogging> createState() => _MyAppLoggingState();
}

class _MyAppLoggingState extends State<MyAppLogging> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
