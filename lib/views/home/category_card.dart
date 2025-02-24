import 'package:Spices_Ecommerce_app/data/model/ProdCategory.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final ProdCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                category.image ?? '',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name!,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
