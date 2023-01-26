// ignore_for_file: public_member_api_docs, strict_raw_type, avoid_dynamic_calls, inference_failure_on_instance_creation, lines_longer_than_80_chars, unnecessary_null_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/components/cart_button.dart';
import 'package:e_commerce_app/product_show_page.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/floating_button.dart';

class JecKetPage extends StatefulWidget {
  const JecKetPage({super.key});

  @override
  State<JecKetPage> createState() => _JecKetPageState();
}

class _JecKetPageState extends State<JecKetPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection("jecket").snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: textColor),
          );
        }

        return SingleChildScrollView(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: size,
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot product = snapshot.data!.docs[index];
              ProductModel productModel = ProductModel(
                  id: product['id'],
                  imageUrl: product['image'],
                  name: product['name'],
                  price: product['price'],
                  normalPrice: product['normalPrice'],
                  quantity: 1);
              return Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductShowPage(
                                  productModel: productModel,
                                ),
                              ));
                        },
                        child: Image.asset(
                          productModel.imageUrl.toString(),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            productModel.name,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "₹",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: textColor),
                              ),
                              Text(
                                productModel.price.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            productModel.normalPrice.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: mrpColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      CartButton(product: productModel),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
