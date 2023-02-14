import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/components/cart_button.dart';
import 'package:e_commerce_app/components/floating_button.dart';
import 'package:e_commerce_app/product_show_page.dart';
import 'package:e_commerce_app/proividers/favourite_Provider.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShosePage extends StatefulWidget {
  const ShosePage({
    super.key,
  });

  @override
  State<ShosePage> createState() => _ShosePageState();
}

class _ShosePageState extends State<ShosePage> {
  late List<ProductModel> productModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection("shose").snapshots(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              if (context
                                  .read<FavouriteProvider>()
                                  .isFavProduct(productModel)) {
                                context
                                    .read<FavouriteProvider>()
                                    .remToFavProduct(productModel);
                              } else {
                                context
                                    .read<FavouriteProvider>()
                                    .addToFavProduct(productModel);
                              }
                            },
                            child: context
                                    .watch<FavouriteProvider>()
                                    .isFavProduct(productModel)
                                ? const Icon(
                                    Icons.favorite,
                                    color: textColor,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: textColor,
                                  ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductShowPage(
                                productModel: productModel,
                              ),
                            ),
                          );
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
