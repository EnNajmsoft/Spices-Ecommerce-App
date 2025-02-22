import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:Spices_Ecommerce_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Spices_Ecommerce_app/data/model/Product.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final CartController cartController = Get.find();
  final RxInt quantity = 1.obs;
  bool _showQuantity = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المنتج'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.toNamed(AppRoutes.cartPage);
                },
              ),
              Obx(() => cartController.carts.isNotEmpty
                  ? Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartController.carts[0].cartItems.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : SizedBox.shrink()),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            Image.network(
              widget.product.image!,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المنتج والسعر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name!,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.product.price} ر.س',
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // التقييم وعدد التقييمات
                  // Row(
                  //   children: [
                  //     Icon(Icons.star, color: Colors.amber),
                  //     Text(
                  //         '${widget.product.rating ?? 0.0} (${widget.product.reviewCount ?? 0} تقييم)'),
                  //   ],
                  // ),
                  SizedBox(height: 16),
                  // وصف المنتج
                  Text(
                    widget.product.description!,
                    style: TextStyle(fontSize: 16),
                  ),
                  // SizedBox(height: 24),
                  // // معلومات إضافية
                  // ListTile(
                  //   leading: Icon(Icons.branding_watermark),
                  //   title: Text('العلامة التجارية'),
                  //   subtitle: Text(widget.product.brand! ?? 'غير محدد'),
                  // ),
                  // ListTile(
                  //   leading: Icon(Icons.balance),
                  //   title: Text('الوزن'),
                  //   subtitle: Text(widget.product.weight! ?? 'غير محدد'),
                  // ),
                  // ListTile(
                  //   leading: Icon(Icons.flag),
                  //   title: Text('بلد المنشأ'),
                  //   subtitle: Text(widget.product.country ?? 'غير محدد'),
                  // ),
                  SizedBox(height: 24),
                  // زر إضافة إلى العربة
                  if (!_showQuantity)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showQuantity = true;
                        });
                      },
                      child: Center(child: Text('أضف للعربة')),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (quantity.value > 1) {
                                  quantity.value--;
                                }
                              },
                            ),
                            Obx(() => Text('${quantity.value}')),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                quantity.value++;
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            cartController.addItem(
                                widget.product.id!, quantity.value);
                            setState(() {
                              _showQuantity = false;
                              quantity.value = 1;
                            });
                          },
                          child: Text('إضافة'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
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
