import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/local_storage/sharedprefs.dart';
import 'package:e_commerce_app/pages/cart_screen.dart';
import 'package:e_commerce_app/pages/google_map.dart';
import 'package:e_commerce_app/pages/home_page.dart';
import 'package:e_commerce_app/proividers/cart_Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../theme/color_theme.dart';

class OrderPage extends StatefulWidget {
  final ProductModel productModel;
  const OrderPage({Key? key, required this.productModel}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _totalPrice = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userName.text = sharedPrefs.userName;
    _email.text = sharedPrefs.email;
    _address.text = sharedPrefs.pickAddress;
    _totalPrice.text = context.read<CartProvider>().getTotal().toString();
  }

  Future<void> orderComplete() async {
    Fluttertoast.showToast(
      msg: "Order Successful",
      gravity: ToastGravity.BOTTOM,
      fontSize: 17,
      textColor: Colors.white,
      backgroundColor: textColor,
      toastLength: Toast.LENGTH_SHORT,
    );
    context.read<CartProvider>().removeAllData(widget.productModel);
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(user!.uid)
        .collection("cartorder")
        .get()
        .then((value) {
      for (final doc in value.docs) {
        doc.reference.delete();
      }
    });
    addData();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  Future<void> addData() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(user!.uid)
        .collection("conformOrder")
        .doc(widget.productModel.id.toString())
        .set({
      "id": widget.productModel.id,
      "imageUrl": widget.productModel.imageUrl,
      "name": widget.productModel.name,
      "price": widget.productModel.price,
      "normalPrice": widget.productModel.normalPrice,
      "quantity": widget.productModel.quantity,
      "category": widget.productModel.category
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final productList = cart.products.toSet().toList();
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Order Product >",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final cartModel = productList.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: MediaQuery.of(context).size.width * 0.03,
                          child: Text("×${cart.getQty(cartModel)}"),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1.5,
                              color: textColor,
                            ),
                          ),
                          child: Image.asset(cartModel.imageUrl.toString()),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "User Details :",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  textFormField(_userName, "User Name"),
                  textFormField(_email, "Email"),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Product Total Price :",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  textFormField(_totalPrice, "Total Price"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Address :",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                sharedPrefs.addressClear();
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Select Location >",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  textFormField(_address, "Street"),
                ],
              ),
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.70,
              shape: const StadiumBorder(),
              color: textColor,
              onPressed: orderComplete,
              child: const Text(
                "Order Now",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding textFormField(var cotroller, String hintText) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: textColor,
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: cotroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintText: hintText,
            ),
          ),
        ),
      );
}
