// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // int _itemCount = 1;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.redAccent.shade100,
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'Product Cart',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent.shade100,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('item')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot cartData = snapshot.data!.docs[index];
                  return Card(
                    color: const Color(0xFFffe9e8),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            child: Image.asset("${cartData['image']}"),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData['name'].toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                cartData['price'].toString(),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Qty: ${cartData["quantity"].toString()}",
                                style: const TextStyle(fontSize: 15),
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(5),
                              //       color: Colors.white),
                              //   child: Row(
                              //     children: [
                              //       _itemCount != 1
                              //           ? InkWell(
                              //               onTap: () {
                              //                 setState(() {
                              //                   _itemCount--;
                              //                 });
                              //               },
                              //               child: Container(
                              //                 height: 30,
                              //                 width: 30,
                              //                 decoration: BoxDecoration(
                              //                   borderRadius:
                              //                       BorderRadius.circular(5),
                              //                   color:
                              //                       Colors.redAccent.shade100,
                              //                 ),
                              //                 child: const Icon(
                              //                   Icons.remove,
                              //                   color: Colors.white,
                              //                 ),
                              //               ),
                              //             )
                              //           : Container(
                              //         height: 30,
                              //         width: 30,
                              //         decoration: BoxDecoration(
                              //           borderRadius:
                              //           BorderRadius.circular(5),
                              //           color:
                              //           Colors.redAccent.shade100,
                              //         ),
                              //         child: const Icon(
                              //           Icons.remove,
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 30,
                              //         width: 40,
                              //         child: Center(
                              //           child: Text(
                              //             _itemCount.toString(),
                              //             style: const TextStyle(fontSize: 17),
                              //           ),
                              //         ),
                              //       ),
                              //       InkWell(
                              //         onTap: () {
                              //           setState(() {
                              //             _itemCount++;
                              //           });
                              //         },
                              //         child: Container(
                              //           height: 30,
                              //           width: 30,
                              //           decoration: BoxDecoration(
                              //             borderRadius:
                              //                 BorderRadius.circular(5),
                              //             color: Colors.redAccent.shade100,
                              //           ),
                              //           child: const Icon(
                              //             Icons.add,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user!.uid)
                                  .collection('item')
                                  .doc(cartData['id'].toString())
                                  .delete();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.redAccent.shade100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Empty'),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
