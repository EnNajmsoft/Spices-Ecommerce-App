import 'package:Spices_Ecommerce_app/controller/ProductController.dart';
import 'package:Spices_Ecommerce_app/core/components/bundle_tile_square.dart';
import 'package:Spices_Ecommerce_app/core/components/title_and_action_button.dart';
import 'package:Spices_Ecommerce_app/core/constants/app_defaults.dart';
import 'package:Spices_Ecommerce_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularPacks extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  PopularPacks({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.productList.isEmpty) {
          return Center(child: Text('No products found'));
        } else {
          return Column(
            children: [
              TitleAndActionButton(
                title: 'Popular Packs22',
                onTap: () => Get.toNamed(AppRoutes.popularItems),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(left: AppDefaults.padding),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.productList.map((product) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(right: AppDefaults.padding),
                      child: BundleTileSquare(data: product),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
