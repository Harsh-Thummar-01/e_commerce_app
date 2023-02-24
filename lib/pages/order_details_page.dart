import 'package:e_commerce_app/pages/google_map.dart';
import 'package:flutter/material.dart';
import '../Model/product_shose_model.dart';
import '../theme/color_theme.dart';

class OrderPage extends StatefulWidget {
  final ProductModel productModel;

  const OrderPage({Key? key, required this.productModel}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Your Orders",
          style: TextStyle(color: textColor, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            height: 180,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 50),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.productModel.imageUrl.toString()),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomGoogleMap(),
                  ));
            },
            child: const Text("select location"),
          ),
        ],
      ),
    );
  }
}
