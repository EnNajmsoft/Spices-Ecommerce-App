import 'package:Spices_Ecommerce_app/core/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Spices_Ecommerce_app/controller/auth/AuthController.dart';
import 'package:Spices_Ecommerce_app/core/constants/constants.dart';

class VerifyOtpPage extends StatefulWidget {
  VerifyOtpPage({super.key});

  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final AuthController authController = Get.find();
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  // دالة التحقق من الرمز
  void onVerifyOtp() async {
    String otp = _otpControllers.map((controller) => controller.text).join();
    authController.otpController.text = otp;
    await authController.verifyOtp();
  }

  // دالة إعادة إرسال الرمز
  void onResendOtp() async {
    await authController.login();
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
            appBar: buildAppBar(context, 'التحقق من الرقم',
          showBackButton: true,
          showSearchButton: false,
          backgroundColor: const Color.fromARGB(255, 2, 191, 128),
   
     
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'تحقق من رقمك',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'ادخل رمز التحقق',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            // حقول إدخال OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: screenWidth * 0.18,
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        _focusNodes[index + 1].requestFocus();
                      }
                      if (value.isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // زر التحقق من OTP
        ElevatedButton(
              onPressed: onVerifyOtp,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.6,
                    50), // تقليل العرض إلى 80% من عرض الشاشة
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text(
                      'تحقق',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
            ),
            const SizedBox(height: 40),
            // زر إعادة إرسال الرمز
            TextButton(
              onPressed: onResendOtp,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                foregroundColor: const Color.fromARGB(255, 2, 166, 65), // تغيير لون النص
              ),
              child: const Text(
                'ألم يصلك الرمز؟ إعادة ارسال الرمز',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
