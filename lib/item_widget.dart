import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/product_show_page.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  static List<dynamic> items = [
    {
      "id": 1,
      "image": "assets/images/1.png",
      "name": "NIKE AIR MAX 200",
      "price": 2599.00,
      "normalPrice": "4599.00",
    },
    {
      "id":2,
      "image": "assets/images/w1.png",
      "name": "fASTRACK",
      "price": 1999.00,
      "normalPrice": "4599.00",
    },
    {
      "id":3,
      "image": "assets/images/3.png",
      "name": "RED FANCY BAG",
      "price": 999.00,
      "normalPrice": "4599.00",
    },
    {
      "id":4,
      "image": "assets/images/p1.png",
      "name": "IPHONE 14 PRO MAX",
      "price": 149999.00,
      "normalPrice": "1,89,999.00",
    },
    {
      "id":5,
      "image": "assets/images/5.png",
      "name": "JECKET",
      "price": 1399.00,
      "normalPrice": "4999.00",
    },
  ];
  List<ProductModel> products = List.generate(
      items.length,
      (index) => ProductModel(
            id: items[index]['id'],
            imageUrl: "${items[index]['image']}",
            name: "${items[index]['name']}",
            normalPrice: "${items[index]['normalPrice']}",
            price: items[index]['price'],
          quantity: 1
          ));


  // List selectedData = [];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(

      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
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
                    const Text(
                      "Trending Now",
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: textColor),
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
        );
      },


    );
  }
}

// Row(
//   children: [
//     Icon(
//       Icons.favorite_border,
//       color: Colors.redAccent.shade100,
//     )
//   ],
// ),

// Row(
//   children: [
//     IconButton(
//       onPressed: () {
//         products[index].favorite = !products[index].favorite!;
//
//         favoriteData(index);
//       },
//       icon: Icon(
//         products[index].favorite == true
//             ? Icons.favorite
//             : Icons.favorite_border,
//         color: Colors.redAccent.shade100,
//       ),
//     ),
//   ],
// ),
