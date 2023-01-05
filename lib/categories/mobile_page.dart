// ignore_for_file: public_member_api_docs, strict_raw_type, avoid_dynamic_calls, inference_failure_on_instance_creation, lines_longer_than_80_chars, unnecessary_null_checks

import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/product_show_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobilePage extends StatefulWidget {
  const MobilePage({super.key});

  @override
  State<MobilePage> createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
  static List mobile = [
    {
      'id': '1',
      'image': 'assets/images/p1.png',
      'name': 'IPHONE 14 PRO MAX',
      'price': '1,49,999.00',
      'favorute': false
    },
    {
      'id': '2',
      'image': 'assets/images/p2.png',
      'name': 'VIVO V23 PRO',
      'price': '29,999.00',
      'favorute': false
    },
    {
      'id': '3',
      'image': 'assets/images/p3.png',
      'name': 'OPPO A16',
      'price': '15,999.00',
      'favorute': false
    },
    {
      'id': '4',
      'image': 'assets/images/p4.png',
      'name': 'MI 11X 5G',
      'price': '14,999.00',
      'favorute': false
    },
    {
      'id': '5',
      'image': 'assets/images/p5.png',
      'name': 'SAMSUNG M53 5G',
      'price': '13,999.00',
      'favorute': false
    },
    {
      'id': '6',
      'image': 'assets/images/p6.png',
      'name': 'NOTHING PHONE',
      'price': '37,999.00',
      'favorute': false
    },
  ];
  List<ProductModel> products = List.generate(
      mobile.length,
          (index) => ProductModel(
          id: "${mobile[index]['id']}",
          imageUrl: "${mobile[index]['image']}",
          name: "${mobile[index]['name']}",
          price: "${mobile[index]['price']}",),);
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
            color: Colors.redAccent.shade100,
          ),
        ),
        title: Text(
          'Mobile',
          style: TextStyle(
            color: Colors.redAccent.shade100,
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
                  color: const Color(0xFFffe9e8),
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
