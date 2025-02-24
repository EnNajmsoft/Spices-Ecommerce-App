import 'package:Spices_Ecommerce_app/core/services/AuthService.dart';
import 'package:Spices_Ecommerce_app/data/model/Cart.dart';
import 'package:Spices_Ecommerce_app/linkapi.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Spices_Ecommerce_app/core/services/NotificationService.dart';

class CartController extends GetxController {
  var carts = <Cart>[].obs;
  var isLoading = false.obs;
  final AuthService authService = Get.find();
  final NotificationService notificationService = NotificationService();

  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }

  Future<void> fetchCart() async {
    try {
      isLoading(true);
      final token = await authService.getToken();
      if (token == null) throw Exception('No token found');

      final response = await http.get(
        Uri.parse(AppLink.cartFetch),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
           print(
            'Response body cart=============================: ${response.body}');
        final responseData = json.decode(response.body);
        final cart = Cart.fromJson(responseData['data']);
        carts.assignAll([cart]);
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      print('Error: $e');
      notificationService.showErrorSnackbar('فشل في جلب العربة');
    } finally {
      isLoading(false);
    }
  }
  // Future<void> fetchCart() async {
  //   try {
  //     isLoading(true);
  //     final token = await authService.getToken();
  //     if (token == null) {
  //       throw Exception('No token found');
  //     }

  //     final response = await http.get(
  //       Uri.parse(AppLink.cartFetch),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //     print('Response body cart=============================: ${response.body}');
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       final Map<String, dynamic> data = responseData['data'];
  //       final Cart cart = Cart.fromJson(data);
  //       carts.assignAll([cart]);
  //     } else {
  //       throw Exception('Failed to load cart');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     notificationService.showErrorSnackbar('فشل في جلب العربة');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> addItem(int productId, int quantity) async {
    try {
      isLoading(true);
      final token = await authService.getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse(AppLink.cartAdd),
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
        fetchCart();
        notificationService.showSuccessSnackbar('تمت إضافة المنتج إلى العربة');
      } else {
        throw Exception('Failed to add item');
      }
    } catch (e) {
      print('Error: $e');
      notificationService.showErrorSnackbar('فشل في إضافة المنتج إلى العربة');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateItem(int itemId, int quantity) async {
    try {
      isLoading(true);
      final token = await authService.getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.put(
        Uri.parse('${AppLink.cartUpdate}/$itemId'),
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
        fetchCart();
        notificationService.showSuccessSnackbar('تم تحديث كمية المنتج');
      } else {
        throw Exception('Failed to update item${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      notificationService.showErrorSnackbar('فشل في تحديث كمية المنتج');
    } finally {
      isLoading(false);
    }
  }

  Future<void> removeItem(int itemId) async {
    try {
      isLoading(true);
      final token = await authService.getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.delete(
        Uri.parse('${AppLink.cartRemove}/$itemId'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        fetchCart();
        notificationService.showSuccessSnackbar('تم حذف المنتج من العربة');
      } else {
        throw Exception('Failed to remove item');
      }
    } catch (e) {
      print('Error: $e');
      notificationService.showErrorSnackbar('فشل في حذف المنتج من العربة');
    } finally {
      isLoading(false);
    }
  }

  Future<void> clearCart() async {
    try {
      isLoading(true);
      final token = await authService.getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final response = await http.post(
        Uri.parse(AppLink.cartClear),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        carts.clear();
        notificationService.showSuccessSnackbar('تم تفريغ العربة بنجاح');
      } else {
        throw Exception('Failed to clear cart');
      }
    } catch (e) {
      print('Error: $e');
      notificationService.showErrorSnackbar('فشل في تفريغ العربة');
    } finally {
      isLoading(false);
    }
  }

  double calculateTotal() {
    if (carts.isEmpty || carts[0].items!.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (var item in carts[0].items ?? []) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
