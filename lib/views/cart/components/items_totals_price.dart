import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/dotted_divider.dart';
import '../../../core/constants/constants.dart';
import 'item_row.dart';

class ItemTotalsAndPrice extends StatelessWidget {
  const ItemTotalsAndPrice({
    super.key,
  });

  // دالة لحساب الإجماليات
  Map<String, dynamic> calculateTotals(CartController cartController) {
    double totalPrice = 0;
    int totalItems = 0;
    double totalWeight = 0;

    for (var cart in cartController.carts) {
      // for (var item in cart.items) {
      //   totalItems += item.quantity!;
      //   totalPrice += item.product!.salePrice * item.quantity;
      //   totalWeight += item.product!.quantity * item.quantity;
      // }
    }

    return {
      'totalItems': totalItems,
      'totalWeight': totalWeight,
      'totalPrice': totalPrice,
    };
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Obx(() {
      // التحقق من وجود عناصر في العربة
      if (cartController.carts.isEmpty ||
          cartController.carts.first.items!.isEmpty) {
        return const Center(child: Text('Your cart is empty'));
      }

      // حساب الإجماليات
      final totals = calculateTotals(cartController);

      return Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            ItemRow(
              title: 'Total Item',
              value: '${totals['totalItems']}',
            ),
            ItemRow(
              title: 'Weight',
              value: '${totals['totalWeight']} Kg',
            ),
            ItemRow(
              title: 'Price',
              value: '\$${totals['totalPrice'].toStringAsFixed(2)}',
            ),
            const DottedDivider(),
            ItemRow(
              title: 'Total Price',
              value: '\$${totals['totalPrice'].toStringAsFixed(2)}',
            ),
          ],
        ),
      );
    });
  }
}
