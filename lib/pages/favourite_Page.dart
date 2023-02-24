import 'package:e_commerce_app/components/cart_button.dart';
import 'package:e_commerce_app/components/floating_button.dart';
import 'package:e_commerce_app/pages/product_show_page.dart';
import 'package:e_commerce_app/proividers/favourite_Provider.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        'Favourite',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      centerTitle: true,
    ),
      floatingActionButton: const FloatingButton(),
      body: context.watch<FavouriteProvider>().favouriteProducts.isNotEmpty
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: size,
              ),
              itemCount:
                  context.watch<FavouriteProvider>().favProductModel.length,
              itemBuilder: (context, index) {
                final favProduct =
                    context.watch<FavouriteProvider>().favProductModel[index];
                return InkWell(
                  onLongPress: () {
                    context
                        .read<FavouriteProvider>()
                        .remToFavProduct(favProduct);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (context
                                      .read<FavouriteProvider>()
                                      .isFavProduct(favProduct)) {
                                    context
                                        .read<FavouriteProvider>()
                                        .remToFavProduct(favProduct);
                                  } else {
                                    context
                                        .read<FavouriteProvider>()
                                        .addToFavProduct(favProduct);
                                  }
                                },
                                child: Icon(
                                  context
                                          .watch<FavouriteProvider>()
                                          .isFavProduct(favProduct)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductShowPage(
                                      productModel: favProduct,
                                    ),
                                  ));
                            },
                            child: Image.asset(
                              favProduct.imageUrl.toString(),
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
                                favProduct.name,
                                style: const TextStyle(fontSize: 13),
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
                                    favProduct.price.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                favProduct.normalPrice.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: mrpColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          CartButton(product: favProduct),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                "No more favourite Product",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w100,
                  color: textColor
                ),
              ),
            ),
    );
  }
}
