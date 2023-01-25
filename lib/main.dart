import 'package:e_commerce_app/admin/login_page.dart';
import 'package:e_commerce_app/home_page.dart';
import 'package:e_commerce_app/local_storage/sharedprefs.dart';
import 'package:e_commerce_app/proividers/cart_Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await sharedPrefs.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
    ),

  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return const HomePage();
        }
        else
          {
            return const LoginPage();
          }
      },
    );
  }
}
