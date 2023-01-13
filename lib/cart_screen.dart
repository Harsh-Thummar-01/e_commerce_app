import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/cart_model.dart';
import 'package:e_commerce_app/components/cart_button.dart';
import 'package:e_commerce_app/proividers/cart_Provider.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  int _itemCount = 1;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final productList=cart.products.toSet().toList();

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
        actions: [
          IconButton(
            onPressed: () {
              // print("------------${data1}----------------------");
            },
            icon: const Icon(
              Icons.add,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.products.isEmpty
                ? const Center(
                    child: Text("Nothing here, Please add something"),
                  )
                : ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final cartModel = productList.elementAt(index);
                      return Card(
                        color: color,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: Image.asset("${cartModel.imageUrl}"),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartModel.name.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    cartModel.price.toString(),
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  CartButton(product: cartModel)
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  cart.removeQty(cartModel);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          //
          Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    cart.getTotal().toString(),
                    style: TextStyle(
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

// StreamBuilder(
//   stream: FirebaseFirestore.instance
//       .collection("users")
//       .doc(user!.uid)
//       .collection("item")
//       .snapshots(),
//   builder: (context, snapshot) {
//     if (snapshot.hasData) {
//       return Expanded(
//         child: ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//              final cartModel =
//                 CartModel.fromMap(snapshot.data!.docs[index].data());
//
//             return Card(
//               color: color,
//               margin: const EdgeInsets.symmetric(
//                   horizontal: 10, vertical: 5),
//               elevation: 10,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 8,
//                   horizontal: 8,
//                 ),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       height: 70,
//                       width: 70,
//                       child: Image.asset("${cartModel.image}"),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           cartModel.name.toString(),
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 6,
//                         ),
//                         Text(
//                           cartModel.price.toString(),
//                           style: const TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 6,
//                         ),
//
//                         Row(
//                           children: [
//                             InkWell(
//                               onTap: () async {
//                                   _itemCount != 1
//                                       ? setState((){
//                                     _itemCount--;
//                                   })
//                                       :  Icon(Icons.remove);
//
//
//                                  await FirebaseFirestore.instance
//                                       .collection("users")
//                                       .doc(user!.uid)
//                                       .collection("item")
//                                       .doc(cartModel.id!.toString())
//                                       .update({
//                                     "quantity": _itemCount,
//                                   });
//
//
//                               },
//                               child: Container(
//                                 height: 30,
//                                 width: 30,
//                                 decoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.circular(10),
//                                   color: iconColor,
//                                 ),
//                                 child: const Icon(Icons.remove),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 50,
//                               height: 30,
//                               child: Center(
//                                   child: Text(
//                               cartModel.quantity.toString(),
//                                 style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             InkWell(
//                               onTap: () async {
//                                 setState(() {
//                                   _itemCount++;
//                                 });
//
//                                 FirebaseFirestore.instance
//                                       .collection("users")
//                                       .doc(user!.uid)
//                                       .collection("item")
//                                       .doc(cartModel.id.toString())
//                                       .update({
//                                     "quantity": _itemCount,
//                                   });
//
//
//                               },
//                               child: Container(
//                                 height: 30,
//                                 width: 30,
//                                 decoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.circular(10),
//                                   color: textColor,
//                                 ),
//                                 child: const Icon(
//                                   Icons.add,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//
//
//                        ],
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       onPressed: () async {
//                         await FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(user!.uid)
//                             .collection('item')
//                             .doc(cartModel.id.toString())
//                             .delete();
//                       },
//                       icon: const Icon(
//                         Icons.close,
//                         color: textColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//     return const Text("data");
//   },
// ),

// Center(
//   child: Text(
//     'Empty cart',
//     style: TextStyle(
//         fontSize: 17,
//         fontWeight: FontWeight.bold,
//         fontStyle: FontStyle.italic,
//         color: Colors.grey),
//   ),
// );
