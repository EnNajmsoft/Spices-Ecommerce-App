import 'package:Spices_Ecommerce_app/controller/CategoryController.dart';
import 'package:flutter/material.dart';

import '../../core/components/app_back_button.dart';
import '../../core/components/product_tile_square.dart';
import '../../core/constants/constants.dart';
import 'package:get/get.dart';

class CategoryProductPage extends StatelessWidget {
  final CategoryController categoryController = Get.find<CategoryController>(); 

   CategoryProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vegetables'),
        leading: const AppBackButton(),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.only(top: AppDefaults.padding),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: 16,
        itemBuilder: (context, index) {
          return ProductTileSquare(
            data: Dummy.products.first,
          );
        },
      ),
    );
  }
}
