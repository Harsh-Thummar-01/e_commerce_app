import 'package:badges/badges.dart' as badge;
import 'package:badges/badges.dart';
import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/components/cart_button.dart';
import 'package:e_commerce_app/proividers/cart_Provider.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class ProductShowPage extends StatefulWidget {
  final ProductModel productModel;

  const ProductShowPage({super.key, required this.productModel});

  @override
  State<ProductShowPage> createState() => _ProductShowPageState();
}

class _ProductShowPageState extends State<ProductShowPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final cartUid = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              image: DecorationImage(
                image: AssetImage(widget.productModel.imageUrl!),
              ),
            ),
          ),
          Positioned(
            right: 25,
            top: 25 + MediaQuery.of(context).padding.top,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              child: ClipOval(
                child: Container(
                  height: 42,
                  width: 41,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Center(
                    child: badge.Badge(
                      showBadge:
                          (context.watch<CartProvider>().products.isEmpty)
                              ? false
                              : true,
                      badgeContent: Text(context
                          .watch<CartProvider>()
                          .products
                          .length
                          .toString()),
                      position: BadgePosition.topEnd(top: -12, end: -4),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: textColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 25,
            top: 25 + MediaQuery.of(context).padding.top,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: ClipOval(
                child: Container(
                  height: 42,
                  width: 41,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .47,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    offset: const Offset(0, -4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 24,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.productModel.name,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 24,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "₹",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: textColor),
                        ),
                        Text(
                          widget.productModel.price.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.productModel.normalPrice.toString(),
                          style: const TextStyle(
                            fontSize: 17,
                            color: mrpColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 24,
                      right: 20,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "shopped directly from factory",
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          offset: const Offset(0, -4),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: context
                                      .watch<CartProvider>()
                                      .getSingleTotal(widget.productModel) ==
                                  0
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Total"),
                                    Text(
                                      context
                                          .watch<CartProvider>()
                                          .getSingleTotal(widget.productModel)
                                          .toString(),
                                      // widget.productModel.price!,
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        CartButton(product: widget.productModel)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



// InkWell(
//   onTap: (){
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) {
//           return const CartScreen();
//         },
//       ),
//     );
//   },
//   child: Stack(
//     children: [
//       Positioned(
//         right: 25,
//         top: 30 + MediaQuery.of(context).padding.top,
//         child: const ImageIcon(AssetImage("assets/images/carticon.png"),color: textColor),
//       ),
//       Positioned(
//           right: 30,
//           top: 30 + MediaQuery.of(context).padding.top,
//           child: Text(
//             context.watch<CartProvider>().products.length.toString(),
//             style: const TextStyle(
//               color: Colors.red,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           )),
//     ],
//   ),
// ),
