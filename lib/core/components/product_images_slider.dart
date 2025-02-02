import 'package:Spices_Ecommerce_app/controller/FavoriteController.dart';
import 'package:Spices_Ecommerce_app/data/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/home/components/animated_dots.dart';
import '../constants/constants.dart';
import 'network_image.dart';

class ProductImagesSlider extends StatefulWidget {
  const ProductImagesSlider({
    super.key,
    required this.images,
    required this.product,
  });

  final List<String> images;
  final Product product;

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  late PageController controller;
  int currentIndex = 0;
  final FavoriteController favoriteController = Get.find();
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    images = widget.images;
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: AppDefaults.borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.55,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (v) {
                    currentIndex = v;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: NetworkImageWithLoader(
                          images[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  itemCount: images.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: AnimatedDots(
                  totalItems: images.length,
                  currentIndex: currentIndex,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: Material(
              color: Colors.transparent,
              borderRadius: AppDefaults.borderRadius,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  // التحقق مما إذا كان المنتج في المفضلة
                  if (favoriteController
                      .isProductInFavorites(widget.product.id!)) {
                    // إذا كان المنتج في المفضلة، قم بإزالته
                    favoriteController.removeFavorite(widget.product.id!);
                  } else {
                    // إذا لم يكن المنتج في المفضلة، قم بإضافته
                    favoriteController.addFavorite(widget.product.id!);
                  }
                  setState(() {}); // تحديث الواجهة
                },
                child: Container(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.favorite,
                        key: ValueKey<bool>(favoriteController
                            .isProductInFavorites(widget.product.id!)),
                        color: favoriteController
                                .isProductInFavorites(widget.product.id!)
                            ? const Color.fromARGB(
                                255, 255, 127, 118) // لون القلب
                            : const Color.fromARGB(117, 23, 6, 6), // حواف شفافة
                        size: 28, // حجم الأيقونة
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
