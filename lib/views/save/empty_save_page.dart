import 'package:Spices_Ecommerce_app/controller/FavoriteController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EmptySavePage extends StatelessWidget {
  const EmptySavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No favorites found'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final favoriteController = Get.find<FavoriteController>();
              favoriteController.fetchFavorites();
            },
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
