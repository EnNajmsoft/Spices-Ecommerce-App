import 'package:Spices_Ecommerce_app/data/model/Product.dart';
import 'package:flutter/material.dart';
class BundleMetaData extends StatelessWidget {
  const BundleMetaData({
    super.key,
    required this.product, // تمرير المنتج كمعامل
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /* <---- Weight -----> */
          Column(
            children: [
              Text(
                // '${product.weight!} Kg', // وزن المنتج
          " حجم المنتج",


                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              Text(
                'Weight',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),

          /* <---- Size -----> */
          Column(
            children: [
              Text(
                // product.size!, // حجم المنتج
" حجم المنتج",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              Text(
                'Size',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),

          /* <---- Items -----> */
          Column(
            children: [
              Text(
                '${product.quantity}', // عدد العناصر
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              Text(
                'Items',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
