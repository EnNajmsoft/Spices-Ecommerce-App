import 'dart:async';
import 'dart:io';
import 'package:Spices_Ecommerce_app/core/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Spices_Ecommerce_app/linkapi.dart';
import 'package:Spices_Ecommerce_app/core/routes/app_routes.dart';
import 'package:Spices_Ecommerce_app/core/services/NotificationService.dart'; 

class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = Get.find();
  final NotificationService notificationService =
      NotificationService(); 
  var isLoading = false.obs;
  var isPasswordShown = false.obs;

  void togglePasswordVisibility() {
    isPasswordShown.toggle();
  }

  Future<void> login() async {
    try {
      isLoading(true);
      if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
        notificationService.showErrorSnackbar('يرجى ملء جميع الحقول');
        return;
      }
      final response = await http
          .post(
            Uri.parse(AppLink.login),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'phone': phoneController.text,
              'password': passwordController.text,
            }),
          )
          .timeout(Duration(seconds: 10));

      handleResponse(response);
    } on SocketException catch (_) {
      notificationService.showErrorSnackbar('لا يوجد اتصال بالإنترنت',
          onRetry: login);
    } on TimeoutException catch (_) {
      notificationService.showErrorSnackbar(
          'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.',
          onRetry: login);
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
      final Map<String, dynamic> data = json.decode(response.body);
      final String token = data['data']['token'];
      final Map<String, dynamic> user = data['data']['user'];
      authService.saveToken(token);
      authService.saveUserData(user);
      notificationService.showSuccessSnackbar('تم تسجيل الدخول بنجاح');
      Get.offAllNamed(AppRoutes.entryPoint);
    } else if (response.statusCode == 401) {
      notificationService
          .showErrorSnackbar('اسم المستخدم أو كلمة المرور غير صحيحة');
    } else if (response.statusCode == 500) {
      notificationService.showErrorSnackbar(
          'حدث خطأ في الخادم. يرجى المحاولة مرة أخرى لاحقًا.');
    } else {
      notificationService
          .showErrorSnackbar('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.');
    }
  }
}
