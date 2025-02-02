import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:Spices_Ecommerce_app/controller/QuantityController.dart';
import 'package:Spices_Ecommerce_app/data/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/components/app_back_button.dart';
import '../../core/components/buy_now_row_button.dart';
import '../../core/components/price_and_quantity.dart';
import '../../core/components/product_images_slider.dart';
import '../../core/constants/constants.dart';
import 'components/bundle_meta_data.dart';

class BundleProductDetailsPage extends StatelessWidget {
  const BundleProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.arguments == null) {
      return Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('No product data found.'),
        ),
      );
    }

    // استقبال المنتج الممرر
    final Product product = Get.arguments;

    // التحقق من أن المنتج يحتوي على بيانات صحيحة
    if (product.name == null ||
        product.imageUrl == null ||
        product.price == null ||
        product.salePrice == null) {
      return Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Invalid product data.'),
        ),
      );
    }

    // الحصول على QuantityController
    final QuantityController quantityController =
        Get.put(QuantityController());
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('تفاصيل المنتج '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImagesSlider(
              images: [
                product.imageUrl!, // استخدام صورة المنتج
                product.imageUrl!, // يمكنك إضافة صور إضافية هنا
              ],
              product: product,
            ),
            /* <---- Product Data -----> */
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.name!, // اسم المنتج
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  PriceAndQuantityRow(
                    currentPrice: product.price!.toDouble(), // السعر الحالي
                    orginalPrice: product.salePrice!.toDouble(), // السعر الأصلي
                  ),
                  const SizedBox(height: AppDefaults.padding / 2),
                  BundleMetaData(product: product),
                  BuyNowRow(
                    onBuyButtonTap: () {},
                    onCartButtonTap: () {
                      // إضافة المنتج إلى العربة بالكمية المحددة
                      final CartController cartController = Get.find();
                      cartController.addItem(
                          product.id!, quantityController.quantity.value);
                      Get.snackbar('Success', 'Product added to cart',
                          snackPosition: SnackPosition.BOTTOM);
                    },
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
