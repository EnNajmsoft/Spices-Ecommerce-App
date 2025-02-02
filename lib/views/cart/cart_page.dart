import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/components/app_back_button.dart';
import '../../core/constants/app_defaults.dart';
import '../../core/routes/app_routes.dart';
import 'components/coupon_code_field.dart';
import 'components/items_totals_price.dart';
import 'components/single_cart_item_tile.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
    this.isHomePage = false,
  });

  final bool isHomePage;

  @override
  Widget build(BuildContext context) {
    final CartController cartController =
        Get.find(); // الحصول على CartController

    return Scaffold(
      appBar: isHomePage
          ? null
          : AppBar(
              leading: const AppBackButton(),
              title: const Text('Cart Page'),
            ),
      body: SafeArea(
        child: Obx(() {
          if (cartController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                // عرض العناصر في العربة
                ...cartController.carts.map((cart) {
                  return Column(
                    children: cart.items.map((item) {
                      return SingleCartItemTile(
                        item: item,
                        onRemove: () {
                          cartController.removeItem(item.id); // حذف العنصر
                        },
                        onQuantityUpdate: (newQuantity) {
                          cartController.updateItem(
                              item.id, newQuantity); // تحديث الكمية
                        },
                      );
                    }).toList(),
                  );
                }).toList(),

                // إجمالي السعر
                const ItemTotalsAndPrice(),

                // زر الدفع
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.checkoutPage);
                      },
                      child: const Text('Checkout'),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
