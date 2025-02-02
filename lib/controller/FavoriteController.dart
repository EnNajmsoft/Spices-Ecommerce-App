import 'package:Spices_Ecommerce_app/core/services/AuthService.dart';
import 'package:Spices_Ecommerce_app/data/model/Favorite.dart';

import 'package:Spices_Ecommerce_app/linkapi.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FavoriteController extends GetxController {
  var favorites = <Favorite>[].obs;
  var isLoading = false.obs;
    final AuthService authService = Get.find();
  // final String authToken =
  //     'qUWPrqeus6s5aSDiinZBgsQKqIwJPEbm5kPjoRf70406654e'; // Define the token


  // دالة للتحقق من وجود منتج في المفضلة
  bool isProductInFavorites(int productId) {
    return favorites.any((favorite) => favorite.productId == productId);
  }
  @override
  void onInit() {
    fetchFavorites(); // جلب البيانات تلقائيًا
    super.onInit();
  }
Future<void> fetchFavorites() async {
    try {
      isLoading(true);
      final token = await authService.getToken();
      final response = await http.get(
        Uri.parse(AppLink.favoritesFetch),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(
          'Response body favorites=============================: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data =
            responseData['data']; // تحليل القائمة من 'data'
        favorites
            .assignAll(data.map((json) => Favorite.fromJson(json)).toList());
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

Future<void> addFavorite(int productId) async {
    try {
      isLoading(true);
        final token = await authService.getToken();
      final response = await http.post(
        Uri.parse(AppLink.addFavorite),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'product_id': productId,
        }),
      );

      if (response.statusCode == 201) {
        fetchFavorites();
        Get.snackbar('Success', 'Product added to favorites',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to add favorite');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to add product to favorites',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

Future<void> removeFavorite(int productId) async {
    try {
      isLoading(true);
      final token = await authService.getToken();
      final favorite = favorites.firstWhere(
        (f) => f.productId == productId,
        orElse: () => throw Exception('Product not found in favorites'),
      );

      // إرسال طلب الحذف باستخدام favoriteId
      final response = await http.delete(
        Uri.parse('${AppLink.removeFavorite}/${favorite.id}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        fetchFavorites(); // تحديث قائمة المفضلة بعد الحذف
        Get.snackbar('Success', 'Product removed from favorites',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to remove favorite');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to remove product from favorites',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
