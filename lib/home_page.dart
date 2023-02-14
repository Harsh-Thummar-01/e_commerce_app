import 'package:badges/badges.dart';
import 'package:e_commerce_app/Model/user_model.dart';
import 'package:e_commerce_app/admin/login_page.dart';
import 'package:e_commerce_app/admin/profile.dart';
import 'package:e_commerce_app/admin_panel.dart';
import 'package:e_commerce_app/cart_screen.dart';
import 'package:e_commerce_app/categories/bag_page.dart';
import 'package:e_commerce_app/categories/jecket_page.dart';
import 'package:e_commerce_app/categories/mobile_page.dart';
import 'package:e_commerce_app/categories/shose_page.dart';
import 'package:e_commerce_app/categories/watch_page.dart';
import 'package:e_commerce_app/favourite_Page.dart';
import 'package:e_commerce_app/local_storage/sharedprefs.dart';
import 'package:e_commerce_app/proividers/cart_Provider.dart';
import 'package:e_commerce_app/proividers/favourite_Provider.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/floating_button.dart';

class HomePage extends StatefulWidget {
  HomePage({
    required this.userModel,
    required this.firebaseUser,
    super.key,
  });
  UserModel userModel;
  User firebaseUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<FavouriteProvider>().getLocalData();
    super.initState();
  }

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(width: 2, color: textColor),
                    //     borderRadius: BorderRadius.circular(45),
                    //   ),
                    //   child: CircleAvatar(
                    //     radius: 40,
                    //     backgroundImage:
                    //         NetworkImage(widget.userModel.imageUrl.toString()),
                    //   ),
                    // ),
                    Text(
                      "${widget.userModel.userName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      widget.userModel.email.toString(),
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
                        return HomePage(
                          userModel: widget.userModel,
                          firebaseUser: widget.firebaseUser,
                        );
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
                    children: [
                      Badge(
                        showBadge:
                            (context.watch<CartProvider>().products.isEmpty)
                                ? false
                                : true,
                        badgeContent: Text(context
                            .watch<CartProvider>()
                            .products
                            .length
                            .toString()),
                        position: BadgePosition.topEnd(top: -12, end: -8),
                        child: const Icon(
                          Icons.shopping_cart,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
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
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) {
              //           return Profile(
              //             userModel: widget.userModel,
              //             firebaseUser: widget.firebaseUser,
              //           );
              //         },
              //       ),
              //     );
              //   },
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              //     child: Row(
              //       children: const [
              //         Icon(Icons.person, color: textColor),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           "Profile",
              //           style: TextStyle(
              //             fontSize: 17,
              //             color: Colors.black,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const FavouritePage();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Row(
                    children: const [
                      Icon(Icons.favorite, color: textColor),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Favourite Page",
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
                        return const AdminPanelPage();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.admin_panel_settings,
                        color: textColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Admin Panel",
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
          title: const Text(
            "E-Shop",
            style: TextStyle(
                fontSize: 23, color: textColor, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const FavouritePage();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.favorite,
                color: textColor,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 10.0),
            //   child: CircleAvatar(
            //     radius: 20,
            //     backgroundImage:
            //         NetworkImage(widget.userModel.imageUrl.toString()),
            //     backgroundColor: textColor,
            //   ),
            // ),
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
