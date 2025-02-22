import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService {
  void showErrorSnackbar(String message, {VoidCallback? onRetry}) {
    Get.snackbar(
      'خطأ',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 255, 140, 132),
      colorText: Colors.white,
      icon: Icon(Icons.error, color: Colors.white),
      duration: Duration(seconds: 5),
      mainButton: onRetry != null
          ? TextButton(
              onPressed: onRetry,
              child:
                  Text('إعادة المحاولة', style: TextStyle(color: Colors.white)),
            )
          : null,
    );
  }

  void showSuccessSnackbar(String message) {
    Get.snackbar(
      'نجاح',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: Icon(Icons.check_circle, color: Colors.white),
      duration: Duration(seconds: 3),
    );
  }
}
