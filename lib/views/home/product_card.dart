import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:Spices_Ecommerce_app/controller/FavoriteController.dart';
import 'package:Spices_Ecommerce_app/data/model/Product.dart';
import 'package:Spices_Ecommerce_app/views/home/ProductDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final CartController cartController = Get.find();
  final FavoriteController favoriteController = Get.find();

  ProductCard({super.key, required this.product});

  bool _isProductInCart(int productId) {
    if (cartController.carts.isNotEmpty &&
        cartController.carts.first.items != null) {
      return cartController.carts.first.items!
          .any((item) => item.productId == productId);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool isInCart = _isProductInCart(product.id!);

    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailsPage(product: product));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: 6.0, vertical: 4.0), // Reduced margin
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // Reduced border radius
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Reduced shadow opacity
              spreadRadius: 1, // Reduced spread radius
              blurRadius: 5, // Reduced blur radius
              offset: const Offset(0, 2), // Reduced offset
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 24 / 26.3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12)), // Reduced border radius
                    child: Image.network(product.image!,
                        width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 6, // Reduced top position
                  right: 6, // Reduced right position
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(63, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius:
                          BorderRadius.circular(18), // Reduced border radius
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero, // Remove default padding
                      constraints:
                          const BoxConstraints(), // Remove default constraints
                      iconSize: 20, // Reduced icon size
                      icon: Obx(() => Icon(
                          favoriteController
                                  .isProductInFavorites(product.id ?? 0)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favoriteController
                                  .isProductInFavorites(product.id ?? 0)
                              ? const Color.fromARGB(255, 255, 127, 118)
                              : Colors.grey)),
                      onPressed: () {
                        if (favoriteController
                            .isProductInFavorites(product.id ?? 0)) {
                          favoriteController.removeFavorite(product.id ?? 0);
                        } else {
                          favoriteController.addFavorite(product.id ?? 0);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 8.0), // Adjusted padding
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16, // Reduced font size
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6), // Adjusted space
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14, // Reduced font size
                              color: Colors.green,
                            ),
                            children: [
                              TextSpan(text: '\$${product.price}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6), // Adjusted space
                  if (isInCart)
                    const Icon(Icons.check_circle,
                        color: Colors.green, size: 24) // Reduced icon size
                  else
                    IconButton(
                      padding: EdgeInsets.zero, // Remove default padding
                      constraints:
                          const BoxConstraints(), // Remove default constraints
                      iconSize: 24, // Reduced icon size
                      onPressed: () {
                        cartController.addItem(product.id!, 1);
                      },
                      icon: const Icon(Icons.add_shopping_cart,
                          color: Colors.green, size: 24), // Reduced icon size
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
