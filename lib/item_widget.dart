import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/product_show_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {

  static List items = [
    {
      // "id": "1",
      "image": "assets/images/1.png",
      "name": "NIKE AIR MAX 200",
      "price": "2599.00",
      "favorute": false
    },
    {
      "image": "assets/images/w1.png",
      "name": "fASTRACK",
      "price": "1999.00",
      "favorute": false
    },
    {
      "image": "assets/images/3.png",
      "name": "RED FANCY BAG",
      "price": "999.00",
      "favorute": false
    },
    {
      "image": "assets/images/p1.png",
      "name": "IPHONE 14 PRO MAX",
      "price": "1,49,999.00",
      "favorute": false
    },
    {
      "image": "assets/images/5.png",
      "name": "JECKET",
      "price": "1399.00",
      "favorute": false
    },
  ];


  const ItemWidget({super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  List<ProductModel> products = List.generate(
      ItemWidget.items.length,
      (index) => ProductModel(
          id: ItemWidget.items[index]['id'],
          imageUrl: ItemWidget.items[index]['image'],
          name: ItemWidget.items[index]['name'],
          price: ItemWidget.items[index]['price'],));

  final uid = FirebaseAuth.instance.currentUser!.uid;

  // List selectedData = [];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics:const NeverScrollableScrollPhysics(),
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
                      products[index].name!,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Trending Now",
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.shade100),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "₹",
                              style: TextStyle(
                                color: Colors.redAccent.shade100,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(
                            text: products[index].price,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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
