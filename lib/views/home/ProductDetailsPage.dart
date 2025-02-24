import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:Spices_Ecommerce_app/core/routes/app_routes.dart';
import 'package:Spices_Ecommerce_app/data/model/Product.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  ProductDetailsPage({required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final CartController cartController = Get.find();
  final RxInt quantity = 1.obs;
  final RxBool showQuantity = false.obs;
  final RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          _buildCartIcon(),
        ],
      ),
      body: Stack(
        children: [
          _buildProductImage(context),
          _buildProductDetails(context),
        ],
      ),
    );
  }

  Widget _buildCartIcon() {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () {
            Get.toNamed(AppRoutes.cartPage);
          },
        ),
        Obx(() => cartController.carts.isNotEmpty
            ? Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '${cartController.carts[0].items!.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: MediaQuery.of(context).size.height * 0.5,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        child: CachedNetworkImage(
          imageUrl: widget.product.image!,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Positioned.fill(
      top: MediaQuery.of(context).size.height * 0.55,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.product.name!,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 10),
            Text('${widget.product.price} ر.س',
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            Text(widget.product.description!,
                style: TextStyle(fontSize: 18, color: Colors.grey[800])),
            const SizedBox(height: 30),
            Obx(() => showQuantity.value
                ? _buildQuantityControls()
                : _buildAddToCartButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return ElevatedButton(
      onPressed: () => showQuantity.value = true,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Center(child: Text('أضف للعربة')),
    );
  }

  Widget _buildQuantityControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                icon: const Icon(Icons.remove, color: Colors.black),
                onPressed: () => quantity.value > 1 ? quantity.value-- : null),
            Obx(() => Text('${quantity.value}',
                style: const TextStyle(color: Colors.black))),
            IconButton(
                icon: const Icon(Icons.add, color: Colors.black),
                onPressed: () => quantity.value++),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            isLoading.value = true;
            cartController.addItem(widget.product.id!, quantity.value);
            showQuantity.value = false;
            quantity.value = 1;
            isLoading.value = false;
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Obx(() => isLoading.value
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text('إضافة')),
        ),
      ],
    );
  }
}
