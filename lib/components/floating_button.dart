import 'package:badges/badges.dart' as badge;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/cart_screen.dart';
import '../proividers/cart_Provider.dart';
import '../theme/color_theme.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: textColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CartScreen(),
          ),
        );
      },
      child: badge.Badge(
        showBadge:
            (context.watch<CartProvider>().products.isEmpty) ? false : true,
        position: BadgePosition.topEnd(top: -14, end: -4),
        badgeContent: Text(
          context.watch<CartProvider>().products.length.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        badgeAnimation: const BadgeAnimation.fade(),
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }
}
