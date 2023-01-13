import 'package:e_commerce_app/Model/product_shose_model.dart';
import 'package:e_commerce_app/proividers/cart_Provider.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartButton extends StatefulWidget {
  const CartButton({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return cart.getQty(widget.product) > 0
        ? Row(
            children: [
              InkWell(
                onTap: () async {
                  cart.removeFromCart(widget.product);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: iconColor,
                  ),
                  child: const Icon(Icons.remove),
                ),
              ),
              SizedBox(
                width: 50,
                height: 30,
                child: Center(
                    child: Text(
                  cart.getQty(widget.product).toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),
              InkWell(
                onTap: () async {
                  cart.addToCart(widget.product);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: textColor,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        : InkWell(
            onTap: () async {
              context.read<CartProvider>().addToCart(widget.product);
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: textColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Add to Cart",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }
}
