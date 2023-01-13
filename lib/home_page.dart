import 'package:e_commerce_app/Model/user_model.dart';
import 'package:e_commerce_app/admin/login_page.dart';
import 'package:e_commerce_app/admin/profile.dart';
import 'package:e_commerce_app/cart_screen.dart';
import 'package:e_commerce_app/categories.dart';
import 'package:e_commerce_app/item_widget.dart';
import 'package:e_commerce_app/local_storage/info_plus.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const HomePage({
    super.key,
    required this.userModel,
    required this.firebaseUser,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

// getFavoriteData() async {

//   QuerySnapshot snapshot  = await FirebaseFirestore.instance.collection("users").doc(uid).collection("favoritedata").get();

//   ProductModel productModel = ProductModel.fromMap(snapshot.docs as Map<String, dynamic>);

//  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      border: Border.all(
                          width: 2, color: textColor),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(widget.userModel.imageUrl!),
                    ),
                  ),
                  Text(
                    "${widget.userModel.firstName} ${widget.userModel.lastName}",
                    style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    widget.userModel.email!,
                    style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                          firebaseUser: widget.firebaseUser);
                    },
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Row(
                  children:const [
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
                      return CartScreen();
                    },
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Row(
                  children:const [
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Profile(userModel: widget.userModel, firebaseUser: widget.firebaseUser);
                },),);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Row(
                  children:const [
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>const LoginPage(),
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Row(
                  children:const [
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
            Text("V ${info.packageInfo!.version}")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    return IconButton(
                      icon: Image.asset("assets/images/drawer1.png",
                          height: 30,
                          width: 30,
                          color: textColor),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    );
                  }),
                  Column(
                    children: [
                      Text(
                        "${widget.userModel.firstName!} ${widget.userModel.lastName!}",
                        style:const TextStyle(
                            fontSize: 20,
                            color: textColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.userModel.email!,
                        style:const TextStyle(
                          fontSize: 15,
                          color: textColor
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: textColor),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(
                              widget.userModel.imageUrl.toString()),
                      backgroundColor: textColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Categories(),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  alignment: Alignment.centerLeft,
                  child:const Text(
                    "Best Selling",
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                ItemWidget(),
              ],
            )
          ],
        ),
      ),
      // bottomNavigationBar: BottomBar(),
    );
  }
}

//
// appBar: AppBar(
// automaticallyImplyLeading: false,
// leading: IconButton(
// onPressed: () {
// Navigator.of(context).pop();
// },
// icon: Icon(
// Icons.arrow_back_ios_new,
// color: Colors.redAccent.shade100,
// ),
// ),
// title: Text(
// "Watch",
// style: TextStyle(
// color: Colors.redAccent.shade100,
// fontSize: 25,
// fontWeight: FontWeight.bold,
// ),
// ),
// centerTitle: true,
// backgroundColor: Colors.transparent,
// elevation: 0.0,
// ),

// Container(
//   alignment: Alignment.centerLeft,
//   margin: EdgeInsets.symmetric(
//     vertical: 10,
//     horizontal: 10,
//   ),
//   child: Text(
//     "Categories",
//     style: TextStyle(
//         fontSize: 25,
//         fontWeight: FontWeight.bold,
//         color: Colors.redAccent.shade100),
//   ),
// ),
