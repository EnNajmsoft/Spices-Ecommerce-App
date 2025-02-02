import 'package:Spices_Ecommerce_app/core/services/AuthService.dart';
import 'package:Spices_Ecommerce_app/data/model/Cart.dart';
import 'package:Spices_Ecommerce_app/linkapi.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartController extends GetxController {
  var carts = <Cart>[].obs; // قائمة العناصر في العربة
  var isLoading = false.obs; // حالة التحميل
  final AuthService authService = Get.find(); // الوصول إلى AuthService
  @override
  void onInit() {
    fetchCart(); // جلب البيانات تلقائيًا
    super.onInit();
  }

Future<void> fetchCart() async {
    try {
      isLoading(true);
      final token = await authService.getToken(); // الحصول على التوكن
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.get(
        Uri.parse(AppLink.cartFetch), // استخدام الرابط الصحيح
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(
          'Response body cart=============================: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> data =
            responseData['data']; // data هي Map وليست List

        // تحويل البيانات إلى نموذج Cart
        final Cart cart = Cart.fromJson(data);
        carts.assignAll([cart]); // إضافة العربة إلى القائمة
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to fetch cart',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchCart2() async {
    try {
      isLoading(true);
      final token = await authService.getToken(); // الحصول على التوكن
      if (token == null) {
        print(
            'Response body cart=============================ffffffffffffffffffffffffffff');
        throw Exception('No token found');
              

      }
      // print(
      //     'Response body cart=============================tttttttttttttttttttt');
      final response = await http.get(
        Uri.parse(AppLink.cartFetch), // استبدل AppLink.cart بالرابط الصحيح
        headers: {
            'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('Response body cart=============================: ${response.body}');

      if (response.statusCode == 200) {

        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data']; // تحليل البيانات
        
            carts.assignAll(data.map((json) => Cart.fromJson(json)).toList());
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to fetch cart',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // إضافة عنصر إلى العربة
  Future<void> addItem(int productId, int quantity) async {
    try {
      isLoading(true);
      final token = await authService.getToken(); // الحصول على التوكن
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse(AppLink.cartAdd), // استبدل AppLink.cart بالرابط الصحيح
        headers: {
            'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'product_id': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 201) {
        fetchCart(); // تحديث العربة بعد الإضافة
        Get.snackbar('Success', 'Item added to cart',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to add item');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to add item to cart',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // تحديث كمية عنصر في العربة
  Future<void> updateItem(int itemId, int quantity) async {
    try {
      isLoading(true);
      final token = await authService.getToken(); // الحصول على التوكن
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.put(
        Uri.parse(
            '${AppLink.cartUpdate}/$itemId'), // استبدل AppLink.cart بالرابط الصحيح
        headers: {
            'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        fetchCart(); // تحديث العربة بعد التعديل
        Get.snackbar('Success', 'Item quantity updated',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to update item');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to update item quantity',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // حذف عنصر من العربة
  Future<void> removeItem(int itemId) async {
    try {
      isLoading(true);
      final token = await authService.getToken(); // الحصول على التوكن
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.delete(
        Uri.parse(
            '${AppLink.cartRemove}/$itemId'), // استبدل AppLink.cart بالرابط الصحيح
        headers: {
            'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        fetchCart(); // تحديث العربة بعد الحذف
        Get.snackbar('Success', 'Item removed from cart',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to remove item');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to remove item from cart',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // حذف العربة بالكامل
  Future<void> clearCart() async {
    try {
      isLoading(true);
      final token = await authService.getToken(); // الحصول على التوكن
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse(
            AppLink.cartClear), // استبدل AppLink.cart بالرابط الصحيح
        headers: {
            'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        carts.clear(); // تفريغ قائمة العناصر
        Get.snackbar('Success', 'Cart cleared successfully',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        throw Exception('Failed to clear cart');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to clear cart',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
