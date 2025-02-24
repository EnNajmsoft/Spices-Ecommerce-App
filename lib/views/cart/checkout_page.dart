import 'package:Spices_Ecommerce_app/core/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:Spices_Ecommerce_app/controller/OrderController.dart';
import '../../core/constants/app_defaults.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartController cartController = Get.find();
  final OrderController orderController = Get.put(OrderController());
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _couponController = TextEditingController();
  final RxString _paymentMethod = 'cod'.obs;
  final RxMap<String, dynamic> _couponData = <String, dynamic>{}.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'اتمام الشراء',
          showBackButton: true,
          showSearchButton: false,
          backgroundColor: const Color.fromARGB(255, 2, 191, 128)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            _buildAddressSection(),
            const SizedBox(height: 16),
            _buildPaymentMethodSection(),
            const SizedBox(height: 16),
            _buildCouponSection(),
            const SizedBox(height: 16),
            _buildOrderSummary(),
            const SizedBox(height: 24),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        leading: const Icon(Icons.location_on),
        title: Text(
          _addressController.text.isEmpty
              ? 'أضف عنوان الشحن'
              : _addressController.text,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            // _showAddressDialog()
          },
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Obx(() => Card(
          elevation: 2,
          color: Colors.white,
          child: Column(
            children: [
              RadioListTile<String>(
                title: const Text('الدفع عند الاستلام'),
                value: 'cod',
                groupValue: _paymentMethod.value,
                onChanged: (value) => _paymentMethod.value = value!,
              ),
              RadioListTile<String>(
                title: const Text('الدفع الإلكتروني (Stripe)'),
                value: 'stripe',
                groupValue: _paymentMethod.value,
                onChanged: (value) => _paymentMethod.value = value!,
              ),
            ],
          ),
        ));
  }

  Widget _buildCouponSection() {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('كود الخصم',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _couponController,
              decoration: const InputDecoration(
                hintText: 'أدخل كود الخصم',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await orderController
                    .validateCoupon(_couponController.text);
                if (result.containsKey('error')) {
                  Get.snackbar('خطأ', result['error']);
                  _couponData.clear();
                } else {
                  Get.snackbar('نجاح', 'تم تطبيق الكوبون بنجاح');
                  _couponData.value = result;
                }
              },
              child: const Text('تطبيق الكوبون'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    final cart = cartController.carts.firstOrNull;
    if (cart == null || cart.items!.isEmpty) return const SizedBox.shrink();

    double totalAmount = cart.totalAmount!;
    double discountAmount = 0.0;

    if (_couponData.isNotEmpty && _couponData.containsKey('discount_amount')) {
      discountAmount = double.parse(_couponData['discount_amount'].toString());
      totalAmount -= discountAmount;
    }

    return Card(
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            ...cart.items!.map((item) => ListTile(
                  title: Text(item.product!.name!),
                  trailing: Text(
                      '${(item.product!.price! * item.quantity!).toStringAsFixed(2)} ر.س'),
                  subtitle: Text('الكمية: ${item.quantity}'),
                )),
            const Divider(),
            _buildTotalRow('المجموع', cart.subtotal!),
            _buildTotalRow('التوصيل', cart.deliveryAmount!),
            _buildTotalRow('الخصم', discountAmount),
            _buildTotalRow('الإجمالي', totalAmount, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isTotal
                  ? Theme.of(Get.context!).textTheme.titleMedium
                  : null),
          Text('${value.toStringAsFixed(2)} ر.س',
              style: isTotal
                  ? Theme.of(Get.context!).textTheme.titleMedium
                  : null),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.green,
        ),
        onPressed: () {
          if (_addressController.text.isEmpty) {
            Get.snackbar('خطأ', 'الرجاء إضافة عنوان الشحن');
            return;
          }
          orderController.createOrder(
            address: _addressController.text,
            paymentMethod: _paymentMethod.value,
            coupon: _couponData.isNotEmpty ? _couponController.text : null,
          );
        },
        child: const Text('إتمام الطلب'),
      ),
    );
  }
}
