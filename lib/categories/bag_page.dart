
import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/product_show_page.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  static List<dynamic> bag = [
    {
      'id': 1,
      'image': 'assets/images/3.png',
      'name': 'RED FANCY BAG',
      'price': 999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 2,
      'image': 'assets/images/bag2.png',
      'name': 'YELLOW FANCY BAG',
      'price': 1999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 3,
      'image': 'assets/images/bag3.png',
      'name': 'FANCY NEW BAG',
      'price': 2999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 4,
      'image': 'assets/images/bag4.png',
      'name': 'ORANGE FANCY BAG',
      'price': 1999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 5,
      'image': 'assets/images/bag5.png',
      'name': 'GOLD CHAIN BAG',
      'price': 3999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 6,
      'image': 'assets/images/bag6.png',
      'name': 'PLAN BLACK BAG',
      'price': 799.00,
      "normalPrice": "4599.00",

    },
  ];
  List<ProductModel> products = List.generate(
      bag.length,
          (index) => ProductModel(
          id: bag[index]['id'],
          imageUrl: "${bag[index]['image']}",
          name: "${bag[index]['name']}",
          price: bag[index]['price'],
          normalPrice: "${bag[index]['normalPrice']}",
              quantity: 1),);
  final uid = FirebaseAuth.instance.currentUser!.uid;

  // List selectedData = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon:const Icon(
            Icons.arrow_back_ios_new,
            color: textColor,
          ),
        ),
        title: const Text(
          'Bag',
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
          childAspectRatio: 0.80,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(
            products.length,
                (index) => Card(
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
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