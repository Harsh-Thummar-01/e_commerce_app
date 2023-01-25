
import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/components/cart_button.dart';
import 'package:e_commerce_app/product_show_page.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/floating_button.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  static List<dynamic> bag = [
    {
      'id': 21,
      'image': 'assets/images/3.png',
      'name': 'RED FANCY BAG',
      'price': 999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 22,
      'image': 'assets/images/bag2.png',
      'name': 'YELLOW FANCY BAG',
      'price': 1999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 23,
      'image': 'assets/images/bag3.png',
      'name': 'FANCY NEW BAG',
      'price': 2999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 24,
      'image': 'assets/images/bag4.png',
      'name': 'ORANGE FANCY BAG',
      'price': 1999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 25,
      'image': 'assets/images/bag5.png',
      'name': 'GOLD CHAIN BAG',
      'price': 3999.00,
      "normalPrice": "4599.00",

    },
    {
      'id': 26,
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
    return SingleChildScrollView(
       child:GridView.count(
         physics: const NeverScrollableScrollPhysics(),
         childAspectRatio: size,
         crossAxisCount: 2,
         shrinkWrap: true,
         children: List.generate(
           products.length,
               (index) => Container(

                decoration: BoxDecoration(
                  color: color,
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
                   CartButton(product: products[index]),
                 ],
               ),
             ),
           ),
         ),
       ),
    );
  }
}