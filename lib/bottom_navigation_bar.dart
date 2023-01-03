// ignore_for_file: public_member_api_docs

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class  BottomBar extends StatelessWidget {
  const  BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  ConvexAppBar(
        backgroundColor: Colors.white,
        color: Colors.redAccent.shade100,
        activeColor: Colors.redAccent.shade100,
        
        items:const [
          TabItem(icon: Icons.home,),
          TabItem(icon: Icons.shopping_cart),
          TabItem(icon: Icons.favorite),
          TabItem(icon: Icons.person),
        ],
      
    );
  }
}
