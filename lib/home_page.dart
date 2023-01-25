import 'package:e_commerce_app/admin/login_page.dart';
import 'package:e_commerce_app/admin/profile.dart';
import 'package:e_commerce_app/cart_screen.dart';
import 'package:e_commerce_app/categories/bag_page.dart';
import 'package:e_commerce_app/categories/jecket_page.dart';
import 'package:e_commerce_app/categories/mobile_page.dart';
import 'package:e_commerce_app/categories/shose_page.dart';
import 'package:e_commerce_app/categories/watch_page.dart';
import 'package:e_commerce_app/local_storage/sharedprefs.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/floating_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// getFavoriteData() async {

//   QuerySnapshot snapshot  = await FirebaseFirestore.instance.collection("users").doc(uid).collection("favoritedata").get();

//   ProductModel productModel = ProductModel.fromMap(snapshot.docs as Map<String, dynamic>);

//  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        floatingActionButton: const FloatingButton(),
        backgroundColor: Colors.white,
        drawer: Drawer(
          elevation: 10.0,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: color),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: textColor),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(sharedPrefs.imageUrl),
                      ),
                    ),
                    Text(
                      "${sharedPrefs.firstName} ${sharedPrefs.lastName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      sharedPrefs.email,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Row(
                    children: const [
                      Icon(Icons.home, color: textColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const CartScreen();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Row(
                    children: const [
                      Icon(Icons.shopping_cart, color: textColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Shopping cart",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Profile();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Row(
                    children: const [
                      Icon(Icons.person, color: textColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  FirebaseAuth.instance.signOut();
                  sharedPrefs.logOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Row(
                    children: const [
                      Icon(Icons.logout, color: textColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "LogOut",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Image.asset("assets/images/drawer1.png",
                  height: 30, width: 30, color: textColor),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }),
          title: Text(
            "${sharedPrefs.firstName} ${sharedPrefs.lastName}",
            style: const TextStyle(
                fontSize: 23, color: textColor, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(sharedPrefs.imageUrl.toString()),
                backgroundColor: textColor,
              ),
            ),
          ],
        ),
        body: Column(
          children: const [
            TabBar(
              isScrollable: true,
              indicatorColor: textColor,
              tabs: [
                Tab(
                  child: Text(
                    "Shose",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Watch",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Bag",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Mobile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Jecket",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ShosePage(),
                  WatchPage(),
                  BagPage(),
                  MobilePage(),
                  JecKetPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
