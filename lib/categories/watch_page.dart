// ignore_for_file: public_member_api_docs, strict_raw_type, avoid_dynamic_calls, inference_failure_on_instance_creation, lines_longer_than_80_chars, unnecessary_null_checks

import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/product_show_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme/color_theme.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({super.key});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  static List watchs = [
    {
      "id": 1,
      'image':'assets/images/w1.png',
      'name':'fASTRACK',
      'price':1999.00,
      "normalPrice": "4599.00",
    },

    {
      "id": 2,
      'image':'assets/images/w2.png',
      'name':'TITAN',
      'price':3999.00,
      "normalPrice": "4599.00",
    },

    {
      "id": 3,
      'image':'assets/images/w3.png',
      'name':'RADO',
      'price':2999.00,
      "normalPrice": "4599.00",
    },
    {
      "id": 4,
      'image':'assets/images/w4.png',
      'name':'CITIZEN',
      'price':1599.00,
      "normalPrice": "4599.00",
    },
    {
      "id": 5,
      'image':'assets/images/w5.png',
      'name':'QUARTZ',
      'price':1999.00,
      "normalPrice": "4599.00",
    },
    {
      "id": 6,
      'image':'assets/images/w6.png',
      'name':'YACHT-MASTER',
      'price':3599.00,
      "normalPrice": "4599.00",
    },

  ];

  List<ProductModel> products = List.generate(
      watchs.length,
          (index) => ProductModel(
          id: watchs[index]['id'],
          imageUrl: "${watchs[index]['image']}",
          name: "${watchs[index]['name']}",
          price: watchs[index]['price'],
          normalPrice: "${watchs[index]['normalPrice']}",
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
          'Watch',
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
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                        RichText(
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: '₹',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),),
                              TextSpan(
                                  text: products[index].price.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),),
                            ],),),
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
