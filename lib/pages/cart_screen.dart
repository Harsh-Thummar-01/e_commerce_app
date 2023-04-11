import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/local_storage/sharedprefs.dart';
import 'package:e_commerce_app/pages/google_map.dart';
import 'package:e_commerce_app/pages/order_details_page.dart';
import 'package:e_commerce_app/proividers/cart_Provider.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_place_picker/flutter_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../components/cart_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final LatLng _initialCameraPosition = const LatLng(20.5934, 78.9629);
  ProductModel? productModel;
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final productList = cart.products.toSet().toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: textColor,
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          'Product Cart',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.products.isEmpty
                ? const Center(
                    child: Text("No more Items!"),
                  )
                : ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final cartModel = productList.elementAt(index);
                      productModel = ProductModel(
                          id: cartModel.id,
                          name: cartModel.name,
                          price: cartModel.price,
                          quantity: cartModel.quantity,
                          category: cartModel.category,
                          imageUrl: cartModel.imageUrl);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderPage(productModel: productModel!),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                              color: color,
                              // border: Border.all(color: textColor, width: 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        cartModel.imageUrl.toString()),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartModel.name.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(cartModel.price.toString()),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CartButton(product: cartModel),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  cart.removeQty(cartModel);
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          cart.products.isEmpty
              ? const SizedBox()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.08),
                        offset: const Offset(0, -6),
                        blurRadius: 14,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            cart.getTotal().toString(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          shape: const StadiumBorder(),
                          height: 30,
                          color: textColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FlutterPlacePicker(
                                  apiKey:
                                      "AIzaSyAZZ5PoV8EfLwq9gao8rBDGVahMkcPtEJw", // Put YOUR OWN KEY here.
                                  onPlacePicked: (result) {
                                    print(
                                        "+++++++++++++++++++++++++++++++++${result.addressComponents}");
                                    setState(() {
                                      sharedPrefs.pickAddress =
                                          result.formattedAddress.toString();
                                    });

                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => OrderPage(
                                          productModel: productModel!),
                                    ));
                                  },
                                  initialPosition: _initialCameraPosition,
                                  useCurrentLocation: true,
                                ),
                              ),
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return
                            //       // return PlacePickeredPage(productModel: productModel!,);
                            //       // if (sharedPrefs.currentStreet.isEmpty ||
                            //       //     sharedPrefs.currentLocality.isEmpty ||
                            //       //     sharedPrefs.currentCountry.isEmpty) {
                            //       //   return CustomGoogleMap(
                            //       //       productModel: productModel!);
                            //       // } else {
                            //       //   return OrderPage(productModel: productModel!);
                            //       // }
                            //     },
                            //   ),
                            // );
                          },
                          child: const Text(
                            "Order Now",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ))
        ],
      ),
    );
  }
}
