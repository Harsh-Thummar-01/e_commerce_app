// ignore_for_file: public_member_api_docs, strict_raw_type, avoid_dynamic_calls, inference_failure_on_instance_creation, lines_longer_than_80_chars, unnecessary_null_checks

import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/product_show_page.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JecKetPage extends StatefulWidget {
  const JecKetPage({super.key});

  @override
  State<JecKetPage> createState() => _JecKetPageState();
}

class _JecKetPageState extends State<JecKetPage> {
  static List jecket = [
    {
      'id': 1,
      'image': 'assets/images/j1.png',
      'name': 'BLACK FANCY JECKET',
      'price': 599.00,
      "normalPrice": "4599.00",
      'quantity':1
    },
    {
      'id': 2,
      'image': 'assets/images/j2.png',
      'name': 'BLACK LEGTHER JECKET',
      'price': 999.00,
      "normalPrice": "4599.00",
      'quantity':1
    },
    {
      'id': 3,
      'image': 'assets/images/j3.png',
      'name': 'RED FANCY JECKET',
      'price': 1999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 4,
      'image': 'assets/images/j4.png',
      'name': 'BROWN FANCY JECKET',
      'price': 2999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 5,
      'image': 'assets/images/j5.png',
      'name': 'ORANGE FANCY JECKET',
      'price': 1999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 6,
      'image': 'assets/images/j6.png',
      'name': 'MAROON FANCY JECKET',
      'price': 799.00,
      "normalPrice": "4599.00",

    },
  ];
  List<ProductModel> products = List.generate(
      jecket.length,
          (index) => ProductModel(
          id: jecket[index]['id'],
          imageUrl: "${jecket[index]['image']}",
          name: "${jecket[index]['name']}",
          price: jecket[index]['price'],
          normalPrice: "${jecket[index]['normalPrice']}",
              quantity:1),);
  final uid = FirebaseAuth.instance.currentUser!.uid;

  // List selectedData = [];

  Future<void> favoriteData(int index) async {


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: textColor,
          ),
        ),
        title: Text(
          'Jecket',
          style: TextStyle(
            color: textColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body: SingleChildScrollView(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.76,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(
            products.length,
                (index) => Card(
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductShowPage(
                                productModel: products[index],
                              ),
                            ),);
                      },
                      child: Image.asset(
                        products[index].imageUrl!,
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
                          products[index].name,
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
                              products[index].price.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          products[index].normalPrice.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: mrpColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
