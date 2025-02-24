import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:Spices_Ecommerce_app/core/routes/app_routes.dart';
import 'package:Spices_Ecommerce_app/core/services/AuthService.dart';
import 'package:Spices_Ecommerce_app/data/model/Order.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Spices_Ecommerce_app/linkapi.dart';

class OrderController extends GetxController {
  final AuthService authService = Get.find();
  final RxList<Order> orders = <Order>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<Order?> selectedOrderDetails =
      Rx<Order?>(null); // متغير مراقب لتفاصيل الطلب المحدد

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }
  Future<bool> hasToken() async {
    final token = await authService.getToken();
    return token != null;
  }
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final token = await authService.getToken();
      if (token == null) {
        errorMessage.value = 'الرجاء تسجيل الدخول لعرض الطلبات.';
        return;
      }

      final response = await http.get(
        Uri.parse(AppLink.ordersFetch),
        headers: _buildHeaders(token),
      );

      print('fetchOrders: Response status code: ${response.statusCode}');
      print('fetchOrders: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'] as List;

        if (data.isNotEmpty) {
          final orderList = data[0] as List;
          orders.value = orderList.map((json) => Order.fromJson(json)).toList();
          print(
              'fetchOrders: Orders fetched successfully: ${orders.length} orders');
        } else {
          orders.value = <Order>[];
          print('fetchOrders: No orders found.');
        }
      } else {
        errorMessage.value = 'Failed to load orders';
        print('fetchOrders: Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print('fetchOrders: Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> createOrder({
    required String address,
    required String paymentMethod,
    String? coupon,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final token = await authService.getToken();
      if (token == null) throw Exception('No token found');

      final response = await http.post(
        Uri.parse(AppLink.orderCreate),
        headers: _buildHeaders(token),
        body: json.encode({
          'shipping_address': address,
          'payment_method': paymentMethod,
          'coupon_code': coupon,
        }),
      );

      print('createOrder: Response status code: ${response.statusCode}');
      print('createOrder: Response body: ${response.body}');

      if (response.statusCode == 201) {
        await fetchOrders();
        Get.snackbar('نجاح', 'تم إنشاء الطلب بنجاح');
        Get.offAllNamed(AppRoutes.entryPoint);
        print('createOrder: Order created successfully');
      } else {
        errorMessage.value =
            json.decode(response.body)['message'] ?? 'فشل في إنشاء الطلب';
        Get.snackbar('خطأ', errorMessage.value);
        print('createOrder: Failed to create order: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'خطأ: $e';
      Get.snackbar('خطأ', errorMessage.value);
      print('createOrder: Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
Future<void> applyCoupon(String code) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final token = await authService.getToken();
      if (token == null) throw Exception('No token found');

      final response = await http.post(
        Uri.parse(AppLink.couponApply),
        headers: _buildHeaders(token),
        body: json.encode({'coupon': code}),
      );

      print('applyCoupon: Response status code: ${response.statusCode}');
      print('applyCoupon: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)
            as List<dynamic>; // التعامل مع الاستجابة كقائمة
        if (responseData.isNotEmpty) {
          final couponData =
              responseData.first as Map<String, dynamic>; // الوصول إلى الخريطة

          // الآن يمكنك استخدام couponData
          print('validateCoupon: Coupon validated successfully: $couponData');

          Get.snackbar('نجاح', 'تم تطبيق الكوبون بنجاح');
          Get.find<CartController>().fetchCart();
          print('applyCoupon: Coupon applied successfully');
        } else {
          errorMessage.value = 'الكوبون غير صالح';
          Get.snackbar('خطأ', errorMessage.value);
          print('applyCoupon: Coupon not valid');
        }
      } else {
        errorMessage.value =
            json.decode(response.body)['message'] ?? 'فشل في تطبيق الكوبون';
        Get.snackbar('خطأ', errorMessage.value);
        print('applyCoupon: Failed to apply coupon: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'خطأ: $e';
      Get.snackbar('خطأ', errorMessage.value);
      print('applyCoupon: Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
Future<Map<String, dynamic>> validateCoupon(String code) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final token = await authService.getToken();
      if (token == null) throw Exception('No token found');

      final response = await http.post(
        Uri.parse(AppLink.couponApply),
        headers: _buildHeaders(token),
        body: json.encode({'coupon': code}),
      );

      print('validateCoupon: Response status code: ${response.statusCode}');
      print('validateCoupon: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)
            as Map<String, dynamic>; // التعامل مع الاستجابة كخريطة
        if (responseData['success'] == true &&
            responseData['data'] is List &&
            (responseData['data'] as List).isNotEmpty) {
          final couponData = (responseData['data'] as List).first
              as Map<String, dynamic>; // الوصول إلى الخريطة داخل القائمة
          print('validateCoupon: Coupon validated successfully: $couponData');
          return couponData; // إرجاع الخريطة
        } else {
          errorMessage.value = 'كود الكوبون غير صالح';
          print('validateCoupon: Invalid coupon code: ${response.statusCode}');
          return {'error': errorMessage.value};
        }
      } else {
        errorMessage.value =
            json.decode(response.body)['message'] ?? 'كود الكوبون غير صالح';
        print('validateCoupon: Invalid coupon code: ${response.statusCode}');
        return {'error': errorMessage.value};
      }
    } catch (e) {
      errorMessage.value = 'خطأ: $e';
      print('validateCoupon: Error: $e');
      return {'error': errorMessage.value};
    } finally {
      isLoading.value = false;
    }
  }
Future<void> cancelOrder(orderId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final token = await authService.getToken();
      if (token == null) throw Exception('No token found');

      final response = await http.put(
        // Change to http.put
        Uri.parse('${AppLink.orderCancel}/$orderId'),
        headers: _buildHeaders(token),
      );

      print('cancelOrder: Response status code: ${response.statusCode}');
      print('cancelOrder: Response body: ${response.body}');

      if (response.statusCode == 200) {
        await fetchOrders();
        Get.snackbar('نجاح', 'تم إلغاء الطلب بنجاح');
        print('cancelOrder: Order cancelled successfully: $orderId');
      } else {
        errorMessage.value =
            json.decode(response.body)['message'] ?? 'فشل في إلغاء الطلب';
        Get.snackbar('خطأ', errorMessage.value);
        print('cancelOrder: Failed to cancel order: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'خطأ: $e';
      Get.snackbar('خطأ', errorMessage.value);
      print('cancelOrder: Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
Future<void> fetchOrderDetails( orderId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final token = await authService.getToken();
      if (token == null) throw Exception('No token found');

      final response = await http.get(
        Uri.parse('${AppLink.ordersFetch}/$orderId'),
        headers: _buildHeaders(token),
      );

      print('fetchOrderDetails: Response status code: ${response.statusCode}');
      print('fetchOrderDetails: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'] as List; // data is a list

        if (data.isNotEmpty) {
          final orderData =
              data[0] as Map<String, dynamic>; // Extract the first object
          selectedOrderDetails.value =
              Order.fromJson(orderData); // Pass the object to fromJson
          print(
              'fetchOrderDetails: Order details fetched successfully: $orderId');
        } else {
          errorMessage.value = 'Order details not found.';
          print('fetchOrderDetails: Order details not found.');
        }
      } else {
        errorMessage.value = 'Failed to load order details';
        print(
            'fetchOrderDetails: Failed to load order details: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print('fetchOrderDetails: Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, String> _buildHeaders(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}
