import 'package:Spices_Ecommerce_app/controller/FavoriteController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'empty_save_page.dart';

class SavePage extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  SavePage({
    super.key,
    this.isHomePage = false,
  });

  final bool isHomePage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
      ),
      body: Obx(() {
        if (favoriteController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (favoriteController.favorites.isEmpty) {
          return const EmptySavePage();
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await favoriteController.fetchFavorites();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7, // تحسين نسبة العرض إلى الارتفاع
              ),
              itemCount: favoriteController.favorites.length,
              itemBuilder: (context, index) {
                final favorite = favoriteController.favorites[index];
                return _buildFavoriteItem(context, favorite);
              },
            ),
          );
        }
      }),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, favorite) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // يمكنك إضافة إجراء عند النقر على المنتج هنا
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 1, // يحافظ على نسبة العرض إلى الارتفاع
                child: Image.network(
                  favorite.product.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favorite.product.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          favoriteController.removeFavorite(favorite.id);
                        },
                      ),
                    ],
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
