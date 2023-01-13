import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/product_show_page.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShosePage extends StatefulWidget {
  const ShosePage({
    super.key,
  });

  @override
  State<ShosePage> createState() => _ShosePageState();
}

class _ShosePageState extends State<ShosePage> {
  static List shoses = [
    {
      "id": 1,
      "image": "assets/images/1.png",
      "name": "NIKE AIR MAX 200",
      "price": 2599.00,
      "normalPrice": "4599.00",

    },
    {
      "id": 2,
      "image": "assets/images/shose1.png",
      "name": "CASUAL Pradeep",
      "price": 5999.00,
      "normalPrice": "9599.00",

    },
    {
      "id": 3,
      "image": "assets/images/shose2.png",
      "name": "CASUAL ORANGE",
      "price": 999.00,
      "normalPrice": "4599.00",

    },
    {
      "id": 4,
      "image": "assets/images/shose3.png",
      "name": "SPORT SHOSE",
      "price": 1999.00,
      "normalPrice": "4599.00",

    },
    {
      "id": 5,
      "image": "assets/images/shose4.png",
      "name": "PUMA",
      "price": 3999.00,
      "normalPrice": "4599.00",

    },
    {
      "id": 6,
      "image": "assets/images/shose5.png",
      "name": "PLAN BLUE",
      "price": 799.00,
      "normalPrice": "4599.00",

    },
  ];
  List<ProductModel> products = List.generate(
    shoses.length,
    (index) => ProductModel(
      id: shoses[index]['id'],
      imageUrl: "${shoses[index]['image']}",
      name: "${shoses[index]['name']}",
      price: shoses[index]['price'],
      normalPrice: "${shoses[index]['normalPrice']}",
        quantity: 1
    ),
  );
  final uid = FirebaseAuth.instance.currentUser!.uid;

  // @override
  // Widget build(BuildContext context) {

  //   throw UnimplementedError();
  // }

  // List selectedData = [];

  // void favoriteData(int index) async {
  //   ProductModel productModel = ProductModel(
  //     id: products[index].id,
  //     imageUrl: products[index].imageUrl,
  //     name: products[index].name,
  //     price: products[index].price,
  //   );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: textColor,
          ),
        ),
        title: const Text(
          "Shose",
          style: TextStyle(
            color: textColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                            ));
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
                    )
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
