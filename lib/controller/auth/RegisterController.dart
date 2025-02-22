import 'dart:async';
import 'dart:io';

import 'package:Spices_Ecommerce_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Spices_Ecommerce_app/linkapi.dart';
import 'package:Spices_Ecommerce_app/core/services/NotificationService.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final NotificationService notificationService = NotificationService();

  var isLoading = false.obs;

  Future<void> register() async {
    try {
      isLoading(true);

      if (nameController.text.isEmpty ||
          phoneController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        notificationService.showErrorSnackbar('يرجى ملء جميع الحقول');
        return;
      }

      if (!GetUtils.isEmail(emailController.text)) {
        notificationService.showErrorSnackbar('يرجى إدخال بريد إلكتروني صالح');
        return;
      }

      if (passwordController.text != confirmPasswordController.text) {
        notificationService.showErrorSnackbar('كلمات المرور غير متطابقة');
        return;
      }

      final response = await http
          .post(
            Uri.parse(AppLink.signUp),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'name': nameController.text,
              'phone': phoneController.text,
              'email': emailController.text,
              'password': passwordController.text,
              'password_confirmation': confirmPasswordController.text,
            }),
          )
          .timeout(Duration(seconds: 10));

      handleResponse(response);
    } on SocketException catch (_) {
      notificationService.showErrorSnackbar('لا يوجد اتصال بالإنترنت',
          onRetry: register);
    } on TimeoutException catch (_) {
      notificationService.showErrorSnackbar(
          'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.',
          onRetry: register);
    } on FormatException catch (e) {
      notificationService
          .showErrorSnackbar('خطأ في تحليل البيانات من الخادم: ${e.message}');
    } catch (e) {
      notificationService
          .showErrorSnackbar('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.');
    } finally {
      isLoading(false);
    }
  }

  void handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      notificationService.showSuccessSnackbar('تم التسجيل بنجاح');
      Get.offAllNamed(AppRoutes.login);
    } else if (response.statusCode == 422) {
      final Map<String, dynamic> errorData = json.decode(response.body);
      final String errorMessage = errorData['message'] ?? 'فشل التسجيل';
      if (errorData.containsKey('errors')) {
        // إذا كان هناك أخطاء معقدة
        final errors = errorData['errors'] as Map<String, dynamic>;
        errors.forEach((key, value) {
          notificationService.showErrorSnackbar(value.join('\n'));
        });
      } else {
        notificationService.showErrorSnackbar(errorMessage);
      }
    } else {
      notificationService
          .showErrorSnackbar('فشل التسجيل. يرجى المحاولة مرة أخرى.');
    }
  }
}
