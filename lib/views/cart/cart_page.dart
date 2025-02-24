import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/components/app_back_button.dart';
import '../../core/routes/app_routes.dart';
import 'package:Spices_Ecommerce_app/core/components/app_bar.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();
  final bool isHomePage;

  CartPage({super.key, this.isHomePage = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'عربة التسوق',
          showBackButton: true,
          showSearchButton: false,
          backgroundColor: const Color.fromARGB(255, 2, 191, 128)),
      body: SafeArea(
        child: Obx(() {
          if (cartController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (cartController.carts.isEmpty ||
              cartController.carts[0].items!.isEmpty) {
            return _buildEmptyCart(context);
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...cartController.carts[0].items!.map((item) {
                    const SizedBox(height: 16);
                    return _buildCartItem(context, item);
                  }).toList(),
                  _buildTotal(context),
                  _buildCheckoutButton(context),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, cartItem) {
    final NumberFormat formatter =
        NumberFormat.currency(locale: 'ar_SA', symbol: 'ر.س ');
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white, // تحديد لون الكارت إلى الأبيض
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(cartItem.product.image!,
                  width: 70, height: 70, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.product.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(formatter.format(cartItem.product.price),
                      style: const TextStyle(color: Colors.green)),
                  Text('${cartItem.product.unitId}mg',
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (cartItem.quantity > 1) {
                        cartController.updateItem(
                            cartItem.id, cartItem.quantity - 1);
                      }
                    }),
                Text('${cartItem.quantity}'),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      cartController.updateItem(
                          cartItem.id, cartItem.quantity + 1);
                    }),
              ],
            ),
            IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () {
                  cartController.removeItem(cartItem.id);
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildTotal(BuildContext context) {
    final NumberFormat formatter =
        NumberFormat.currency(locale: 'ar_SA', symbol: 'ر.س ');
    double total = cartController.calculateTotal();
    double deliveryFee = 20.0;
    double grandTotal = total + deliveryFee;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white, // تحديد لون الكارت إلى الأبيض
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('المجموع'),
              Text(formatter.format(total))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('تكلفة التوصيل'),
              Text(formatter.format(deliveryFee))
            ]),
            const Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('الاجمالي',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(formatter.format(grandTotal),
                  style: const TextStyle(fontWeight: FontWeight.bold))
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.checkoutPage);
        },
        icon: const Icon(Icons.shopping_cart_checkout),
        label: const Text('اتمام الشراء'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, size: 100, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text('عربة التسوق فارغة', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          const Text('أضف بعض المنتجات إلى عربتك!'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.entryPoint);
            },
            child: const Text('تصفح المنتجات'),
          ),
        ],
      ),
    );
  }
}
