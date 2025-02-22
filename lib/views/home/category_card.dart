import 'package:Spices_Ecommerce_app/data/model/ProdCategory.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final ProdCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: 8.0), // تقليل التباعد الجانبي
      child: Column(
        children: [
          Container(
            // إضافة حاوية دائرية للصورة
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                // إضافة ظل خفيف
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipOval(
              // قص الصورة داخل دائرة
              child: Image.network(
                category.image ?? '',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4), // إضافة تباعد بين الصورة والنص
          Text(
            category.name!,
            style: const TextStyle(fontSize: 12), // تعديل حجم الخط
          ),
        ],
      ),
    );
  }
}
