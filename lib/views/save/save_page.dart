import 'package:Spices_Ecommerce_app/controller/FavoriteController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/components/app_bar.dart';
import 'empty_save_page.dart';

class SavePage extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final bool isHomePage;

  SavePage({super.key, this.isHomePage = false});

  @override
  Widget build(BuildContext context) {
 return Scaffold(
    appBar: buildAppBar(context, 'مفضلاتي',
      showBackButton: true, // عرض زر الرجوع
      showSearchButton: false, // إخفاء زر البحث
      backgroundColor: Colors.teal),      body: Obx(() {
        if (favoriteController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (favoriteController.favorites.isEmpty) {
          return const EmptySavePage();
        } else {
          return _buildFavoriteList(context);
        }
      }),
    );
  }

  Widget _buildFavoriteList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await favoriteController.fetchFavorites(),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: favoriteController.favorites.length,
        itemBuilder: (context, index) {
          final favorite = favoriteController.favorites[index];
          return _buildFavoriteListItem(context, favorite);
        },
      ),
    );
  }
Widget _buildFavoriteListItem(BuildContext context, favorite) {
  return Card(
    elevation: 2, // تقليل الارتفاع ليكون أكثر نعومة
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // زوايا أكثر استدارة
    ),
    color: Colors.white, // تحديد اللون الأبيض للكارت
    child: Padding(
      padding: const EdgeInsets.all(16.0), // زيادة الحشو الداخلي
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12), // زوايا مستديرة للصورة
            child: Image.network(
              favorite.product.image!,
              width: 90, // زيادة حجم الصورة قليلاً
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20), // زيادة المسافة بين الصورة والنص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favorite.product.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600, // وزن خط متوسط
                    fontSize: 18, // حجم خط أكبر قليلاً
                    color: Colors.black87, // لون نص أكثر وضوحًا
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${favorite.product.price}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500, // وزن خط متوسط
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  favorite.product.description ?? 'لا يوجد وصف',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600], // لون نص وصف أكثر دقة
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent), // استخدام أيقونة محددة
            onPressed: () => favoriteController.removeFavorite(favorite.id),
          ),
        ],
      ),
    ),
  );
}
}