
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
    // final dataProductModel = FirebaseHelper.getFavoriteData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite",
          style: TextStyle(
              fontSize: 25,
              color: Colors.redAccent.shade100,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      
    );
  }
}
