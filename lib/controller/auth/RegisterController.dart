import 'package:Spices_Ecommerce_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Spices_Ecommerce_app/linkapi.dart';


class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> register() async {
    try {
      isLoading(true);

      if (nameController.text.isEmpty ||
          phoneController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        Get.snackbar('Error', 'Please fill all fields',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar('Error', 'Passwords do not match',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      final response = await http.post(
        Uri.parse(AppLink.signUp),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': nameController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        Get.snackbar('Success', 'Registration successful',
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed(AppRoutes.entryPoint);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        Get.snackbar('Error', errorData['message'] ?? 'Registration failed',
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
