import 'package:Spices_Ecommerce_app/core/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Spices_Ecommerce_app/linkapi.dart';
import 'package:Spices_Ecommerce_app/core/routes/app_routes.dart';
class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
final AuthService authService = Get.find();
  var isLoading = false.obs;
  var isPasswordShown = false.obs; // إضافة متغير isPasswordShown

  void togglePasswordVisibility() {
    isPasswordShown.toggle(); // تغيير حالة isPasswordShown
  }

  Future<void> login() async {
    try {
      isLoading(true);

      if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
        Get.snackbar('Error', 'Please fill all fields',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      final response = await http.post(
        Uri.parse(AppLink.login),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'phone': phoneController.text,
          'password': passwordController.text,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String token = data['data']['token'];
        final Map<String, dynamic> user = data['data']['user'];

        // حفظ التوكن وبيانات المستخدم
        await authService.saveToken(token);
        await authService.saveUserData(user);
        
        Get.snackbar('Success', 'Login successful',
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed(AppRoutes.entryPoint);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        Get.snackbar('Error', errorData['message'] ?? 'Login failed',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
