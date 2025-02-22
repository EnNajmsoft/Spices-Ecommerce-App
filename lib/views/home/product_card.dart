import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:Spices_Ecommerce_app/data/model/Product.dart';
import 'package:Spices_Ecommerce_app/views/home/ProductDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProductCard extends StatefulWidget {
  final Product product;
  final CartController cartController = Get.find();

  ProductCard({super.key, required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _showQuantity = false;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
       try {
      final cart = widget.cartController.carts.isNotEmpty
          ? widget.cartController.carts.first
          : null;
      if (cart != null &&
          cart.cartItems != null &&
          cart.cartItems.isNotEmpty) {
        final cartItem = cart.cartItems
            .firstWhereOrNull((item) => item.productId == widget.product.id);
        if (cartItem != null) {
          _showQuantity = true;
          _quantity = cartItem.quantity;
        }
      }
    } catch (e) {
      print('Error in initState: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailsPage(product: widget.product));      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(widget.product.image!,
                      height: 170, width: double.infinity, fit: BoxFit.cover),
                ),
                if (widget.product.createdAt != null &&
                    DateTime.parse(widget.product.createdAt!).isAfter(
                        DateTime.now().subtract(const Duration(days: 7))))
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('جديد',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // أضف إلى المفضلة
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name!,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text('\$${widget.product.price}',
                      style: const TextStyle(fontSize: 12)),
                  if (!_showQuantity)
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showQuantity = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('أضف إلى السلة',
                              style: TextStyle(fontSize: 10)),
                        ),
                      ),
                    ),
                  if (_showQuantity)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, size: 18),
                              onPressed: () {
                                if (_quantity > 1) {
                                  setState(() {
                                    _quantity--;
                                  });
                                  widget.cartController.updateItem(
                                      widget.product.id!,
                                      _quantity); // تعديل الكمية في السلة
                                }
                              },
                            ),
                            Text('$_quantity', style: TextStyle(fontSize: 12)),
                            IconButton(
                              icon: Icon(Icons.add, size: 18),
                              onPressed: () {
                                setState(() {
                                  _quantity++;
                                });
                                widget.cartController.updateItem(
                                    widget.product.id!,
                                    _quantity); // تعديل الكمية في السلة
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            widget.cartController
                                .addItem(widget.product.id!, _quantity);
                            setState(() {
                              _showQuantity = false;
                              _quantity = 1;
                            });
                          },
                          child: Text('إضافة', style: TextStyle(fontSize: 10)),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
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
