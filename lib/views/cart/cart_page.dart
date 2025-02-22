import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/components/app_back_button.dart';
import '../../core/routes/app_routes.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();

  CartPage({
    super.key,
    this.isHomePage = false,
  });

  final bool isHomePage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isHomePage
          ? null
          : AppBar(
              leading: const AppBackButton(),
              title: const Text('عربة التسوق'),
            ),
      body: SafeArea(
        child: Obx(() {
          if (cartController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (cartController.carts.isEmpty ||
              cartController.carts[0].cartItems.isEmpty) {
            return const Center(
              child: Text('لا يوجد عناصر في عربة التسوق'),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...cartController.carts[0].cartItems.map((item) {
                    return _buildFavoriteItem(context, item);
                  }).toList(),
                  _buildBottomNavigationBar(context),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, cartItem) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Image.network(
                  cartItem.product.image!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                if (cartItem.product.salePrice != null)
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '-10%',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${cartItem.product.price} ر.س',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(cartItem.product.name!),
                  Text('${cartItem.product.unitId}mg'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              cartController.updateItem(
                                  cartItem.id, cartItem.quantity + 1);
                            },
                          ),
                          Text('${cartItem.quantity}'),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if (cartItem.quantity > 1) {
                                cartController.updateItem(
                                    cartItem.id, cartItem.quantity - 1);
                              }
                            },
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cartController.removeItem(cartItem.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    double total = cartController.calculateTotal();
    double deliveryFee = 20.0;
    double grandTotal = total + deliveryFee;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('المجموع'),
              Text('${total.toStringAsFixed(2)} ر.س'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('تكلفة التوصيل'),
              Text('${deliveryFee.toStringAsFixed(2)} ر.س'),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('الاجمالي',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${grandTotal.toStringAsFixed(2)} ر.س',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.checkoutPage);
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text('اتمام الشراء'),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
