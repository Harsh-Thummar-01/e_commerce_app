
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls, inference_failure_on_instance_creation, lines_longer_than_80_chars

import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/favorite_page.dart';
import 'package:e_commerce_app/product_show_page.dart';
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
      'id': '1',
      'image': 'assets/images/3.png',
      'name': 'RED FANCY BAG',
      'price': '999.00',
      'favorute': false
    },
    {
      'id': '2',
      'image': 'assets/images/bag2.png',
      'name': 'YELLOW FANCY BAG',
      'price': '1999.00',
      'favorute': false
    },
    {
      'id': '3',
      'image': 'assets/images/bag3.png',
      'name': 'FANCY NEW BAG',
      'price': '2999.00',
      'favorute': false
    },
    {
      'id': '4',
      'image': 'assets/images/bag4.png',
      'name': 'ORANGE FANCY BAG',
      'price': '1999.00',
      'favorute': false
    },
    {
      'id': '5',
      'image': 'assets/images/bag5.png',
      'name': 'GOLD CHAIN BAG',
      'price': '3999.00',
      'favorute': false
    },
    {
      'id': '6',
      'image': 'assets/images/bag6.png',
      'name': 'PLAN BLACK BAG',
      'price': '799.00',
      'favorute': false
    },
  ];
  List<ProductModel> products = List.generate(
      bag.length,
          (index) => ProductModel(
          id: "${bag[index]['id']}",
          imageUrl: "${bag[index]['image']}",
          name: "${bag[index]['name']}",
          price: "${bag[index]['price']}",),);
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
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.redAccent.shade100,
          ),
        ),
        title: Text(
          'Bag',
          style: TextStyle(
            color: Colors.redAccent.shade100,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            // getFavoriteData();
            Navigator.push(context, MaterialPageRoute(builder: (context) =>const FavoritePage(),));
          }, icon: const Icon(Icons.favorite),),
        ],
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
                  color: const Color(0xFFffe9e8),
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
                          products[index].name!,
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '₹',
                                style: TextStyle(
                                  color: Colors.redAccent.shade100,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),),
                            TextSpan(
                              text: products[index].price,
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