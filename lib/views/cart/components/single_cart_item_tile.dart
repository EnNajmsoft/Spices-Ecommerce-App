import 'package:Spices_Ecommerce_app/data/model/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';

class SingleCartItemTile extends StatelessWidget {
  const SingleCartItemTile({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onQuantityUpdate,
  });

  final CartItem item;
  final VoidCallback onRemove;
  final Function(int) onQuantityUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// صورة المنتج
              SizedBox(
                width: 70,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: NetworkImageWithLoader(
                    item.product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              /// الكمية واسم المنتج
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          '${item.product.quantity} Ml',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          onQuantityUpdate(item.quantity + 1); // زيادة الكمية
                        },
                        icon: SvgPicture.asset(AppIcons.addQuantity),
                        constraints: const BoxConstraints(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${item.quantity}',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (item.quantity > 1) {
                            onQuantityUpdate(item.quantity - 1); // تقليل الكمية
                          }
                        },
                        icon: SvgPicture.asset(AppIcons.removeQuantity),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),

              /// السعر وحذف العنصر
              Column(
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    onPressed: onRemove, // حذف العنصر
                    icon: SvgPicture.asset(AppIcons.delete),
                  ),
                  const SizedBox(height: 16),
                  Text('\$${item.product.salePrice}'),
                ],
              )
            ],
          ),
          const Divider(thickness: 0.1),
        ],
      ),
    );
  }
}
