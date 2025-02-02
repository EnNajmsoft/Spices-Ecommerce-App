import 'package:Spices_Ecommerce_app/controller/ProductController.dart';
import 'package:flutter/material.dart';

import '../../../core/components/product_tile_square.dart';
import '../../../core/components/title_and_action_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import 'package:get/get.dart';

class OurNewItem extends StatelessWidget {
final ProductController productController = Get.put(ProductController());

   OurNewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndActionButton(
          title: 'Our New Item',
          // onTap: () => Navigator.pushNamed(context, AppRoutes.newItems),
           onTap: () => Get.toNamed(AppRoutes.popularItems),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: AppDefaults.padding),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              Dummy.products.length,
              (index) => ProductTileSquare(data: Dummy.products[index]),
            ),
          ),
        ),
      ],
    );
  }
}
