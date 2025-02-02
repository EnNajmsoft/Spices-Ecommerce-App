import 'package:Spices_Ecommerce_app/data/model/Product.dart';
import 'package:flutter/material.dart';
import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';
import 'package:get/get.dart';

class PackDetails extends StatelessWidget {
   PackDetails({
    super.key,
     required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.25),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Pack Details',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
          ),
          /* <---- عرض تفاصيل المنتج هنا -----> */
          ListTile(
            leading: AspectRatio(
              aspectRatio: 1 / 1,
              child: NetworkImageWithLoader(
                product.imageUrl!, // صورة المنتج
                fit: BoxFit.fill,
              ),
            ),
            title: Text(product.name!), // اسم المنتج
            trailing: Text(
              '${product.quantity} ${product.unitId}', // الكمية والوحدة
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(height: AppDefaults.padding),
        ],
      ),
    );
  }
}
