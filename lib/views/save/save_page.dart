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
        title: const Text('Favorites'),
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
            child: ListView.builder(
              itemCount: favoriteController.favorites.length,
              itemBuilder: (context, index) {
                final favorite = favoriteController.favorites[index];
                return ListTile(
                  leading: Image.network(favorite.product.imageUrl!),
                  title: Text(favorite.product.name!),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      favoriteController.removeFavorite(favorite.id);
                    },
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}