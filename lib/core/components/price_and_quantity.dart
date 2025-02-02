import 'package:Spices_Ecommerce_app/controller/QuantityController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceAndQuantityRow extends StatelessWidget {
  final double currentPrice;
  final double orginalPrice;

  const PriceAndQuantityRow({
    super.key,
    required this.currentPrice,
    required this.orginalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final QuantityController quantityController = Get.put(QuantityController());
    return Row(
      children: [
        Obx(() {
          return Text(
            '\$${(currentPrice * quantityController.quantity.value).toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
          );
        }),
        const Spacer(),
        IconButton(
          onPressed: () {
            quantityController.decreaseQuantity(); // تقليل الكمية
          },
          icon: const Icon(Icons.remove),
        ),
        Obx(() {
          return Text(
            '${quantityController.quantity.value}',
            style: Theme.of(context).textTheme.titleLarge,
          );
        }),
        IconButton(
          onPressed: () {
            quantityController.increaseQuantity(); // زيادة الكمية
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
