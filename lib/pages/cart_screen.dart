import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/cart_model.dart';
import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/proividers/cart_Provider.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/cart_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final productList = cart.products.toSet().toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: textColor,
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          'Product Cart',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.products.isEmpty
                ? const Center(
                    child: Text("No more Items!"),
                  )
                : ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final cartModel = productList.elementAt(index);
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                            color: color,
                            // border: Border.all(color: textColor, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(cartModel.imageUrl.toString()),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartModel.name.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(cartModel.price.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                                CartButton(product: cartModel),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                cart.removeQty(cartModel);
                                await FirebaseFirestore.instance
                                    .collection("orders")
                                    .doc(cartModel.id.toString())
                                    .delete();
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          cart.products.isEmpty
              ? const SizedBox()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        cart.getTotal().toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ))
        ],
      ),
    );
  }
}

// ListView.builder(
// itemCount: productList.length,
// itemBuilder: (context, index) {
// final cartModel = productList.elementAt(index);
// return Container(
// margin: const EdgeInsets.symmetric(
// vertical: 5, horizontal: 10),
// padding: const EdgeInsets.symmetric(
// vertical: 5, horizontal: 5),
// decoration: BoxDecoration(
// color: color,
// // border: Border.all(color: textColor, width: 1),
// borderRadius: BorderRadius.circular(15)),
// child: Row(
// children: [
// Container(
// height: 80,
// width: 80,
// decoration: BoxDecoration(
// image: DecorationImage(
// image:
// AssetImage(cartModel.imageUrl.toString()),
// ),
// ),
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// cartModel.name.toString(),
// style: const TextStyle(
// fontSize: 16,
// fontWeight: FontWeight.bold),
// ),
// const SizedBox(
// height: 5,
// ),
// Text(cartModel.price.toString()),
// const SizedBox(
// height: 5,
// ),
// CartButton(product: cartModel),
// ],
// ),
// const Spacer(),
// IconButton(
// onPressed: () async {
// cart.removeQty(cartModel);
// await FirebaseFirestore.instance.collection("orders").doc(cartModel.id.toString()).delete();
// },
// icon: const Icon(
// Icons.delete_forever,
// color: textColor,
// ),
// ),
// ],
// ),
// );
//
// },
// ),
