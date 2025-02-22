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
  final otpController = TextEditingController(); 
  final AuthService authService = Get.find();
  final NotificationService notificationService = NotificationService();
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

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          notificationService.showSuccessSnackbar('تم إرسال رمز التحقق');

          Get.toNamed(AppRoutes.verifyOtp);
        } else {
          notificationService
              .showErrorSnackbar(data['message'] ?? 'خطأ في تسجيل الدخول');
        }
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
      print('erorr==================${e}');

      notificationService
          .showErrorSnackbar('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.');
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyOtp() async {
    try {
      isLoading(true);
      if (otpController.text.isEmpty) {
        notificationService.showErrorSnackbar('يرجى إدخال رمز التحقق');
        return;
      }
      final response = await http
          .post(
            Uri.parse(AppLink.verifyOTP),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'phone': phoneController.text,
              'code': otpController.text,
            }),
          )
         
          .timeout(Duration(seconds: 10));
      // print('${phoneController.text}');
      handleVerifyResponse(response);
    } on SocketException catch (_) {
      notificationService.showErrorSnackbar('لا يوجد اتصال بالإنترنت',
          onRetry: verifyOtp);
    } on TimeoutException catch (_) {
      notificationService.showErrorSnackbar(
          'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.',
          onRetry: verifyOtp);
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

  void handleVerifyResponse(http.Response response) {
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success'] == true) {
        final String token = data['data']['token'];
        final Map<String, dynamic> user = data['data']['user'];
        authService.saveToken(token);
        authService.saveUserData(user);
        notificationService.showSuccessSnackbar('تم تسجيل الدخول بنجاح');
        Get.offAllNamed(AppRoutes.entryPoint);
      } else {
        notificationService
            .showErrorSnackbar(data['message'] ?? 'رمز التحقق غير صحيح');
      }
    } else {
      notificationService
          .showErrorSnackbar('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.');
    }
  }
}
