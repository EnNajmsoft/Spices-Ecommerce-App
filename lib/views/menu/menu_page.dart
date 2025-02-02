import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Spices_Ecommerce_app/controller/CategoryController.dart'; // تأكد من المسار الصحيح
import 'package:Spices_Ecommerce_app/core/class/statusrequest.dart';
import 'package:Spices_Ecommerce_app/core/routes/app_routes.dart';

class MenuPage extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16), // تقليل المسافة
          Text(
            'Choose a category',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8), // تقليل المسافة
          const Expanded(child: CategoriesGrid()),
        ],
      ),
    );
  }
}

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController =
        Get.find<CategoryController>();

    return Obx(() {
      if (categoryController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (categoryController.statusRequest == StatusRequest.failure) {
        return const Center(child: Text('Failed to load categories'));
      } else if (categoryController.statusRequest ==
          StatusRequest.serverfailure) {
        return const Center(child: Text('Server error'));
      } else if (categoryController.categoryList.isEmpty) {
        return const Center(child: Text('No categories found'));
      } else {
        return GridView.builder(
          padding: const EdgeInsets.all(2), // تقليل الـ padding
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // عدد الأعمدة
            mainAxisSpacing: 4, // تقليل المسافة الرأسية بين العناصر
            crossAxisSpacing: 4, // تقليل المسافة الأفقية بين العناصر
            childAspectRatio: 0.8, // نسبة العرض إلى الارتفاع
          ),
          itemCount: categoryController.categoryList.length,
          itemBuilder: (context, index) {
            final category = categoryController.categoryList[index];
            return CategoryTile(
              imageLink: category.image ??
                  'https://via.placeholder.com/150', // صورة الفئة
              label: category.name ?? 'No Name', // اسم الفئة
              onTap: () {
                // الانتقال إلى صفحة تفاصيل الفئة
                Get.toNamed(AppRoutes.categoryDetails, arguments: category);
              },
            );
          },
        );
      }
    });
  }
}

class CategoryTile extends StatelessWidget {
  final String imageLink;
  final String label;
  final VoidCallback onTap;

  const CategoryTile({
    Key? key,
    required this.imageLink,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // صورة الفئة
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // زوايا منحنية
            child: Image.network(
              imageLink,
              height: 60, // تقليل ارتفاع الصورة
              width: 60, // تقليل عرض الصورة
              fit: BoxFit.cover, // تغطية المساحة المحددة
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 60,
                  width: 60,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 30,
                    color: Colors.grey,
                  ), // أيقونة بديلة في حالة الخطأ
                );
              },
            ),
          ),
          const SizedBox(height: 4), // تقليل المسافة بين الصورة والنص
          // نص الفئة
          Text(
            label,
            style: const TextStyle(
              color: Colors.black, // لون النص
              fontWeight: FontWeight.bold,
              fontSize: 12, // تصغير حجم الخط
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
