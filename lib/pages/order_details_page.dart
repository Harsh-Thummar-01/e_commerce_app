import 'package:e_commerce_app/local_storage/sharedprefs.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _street = TextEditingController();
  final _locality = TextEditingController();
  final _country = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userName.text = sharedPrefs.userName;
    _email.text = sharedPrefs.email;
    _street.text = sharedPrefs.currentStreet;
    _locality.text = sharedPrefs.currentLocality;
    _country.text = sharedPrefs.currentCountry;
  }

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image(
              image: AssetImage(
                widget.productModel.imageUrl.toString(),
              ),
              height: 250,
              width: 250,
            ),
            const SizedBox(
              height: 10,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CustomGoogleMap(),
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
                  textFormField(_street, "Street"),
                  textFormField(_locality, "Locality"),
                  textFormField(_country, "Country"),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(""),
                    ),
                  )
                ],
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
              width: 2,
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
