import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Spices_Ecommerce_app/controller/auth/AuthController.dart';
import 'package:Spices_Ecommerce_app/core/constants/constants.dart';

class VerifyOtpPage extends StatelessWidget {
  VerifyOtpPage({super.key});

  final AuthController authController = Get.find();
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());

  // دالة التحقق من الرمز
  void onVerifyOtp() async {
    String otp = _otpControllers.map((controller) => controller.text).join();
    authController.otpController.text = otp;
    await authController.verifyOtp();
  }

  // دالة التعامل مع ضغط الأزرار
  void _handleKeyPress(String value, BuildContext context) {
    int emptyIndex =
        _otpControllers.indexWhere((controller) => controller.text.isEmpty);
    if (value == 'delete') {
      // إذا لم يكن هناك قيمة فارغة نبدأ من النهاية
      if (emptyIndex == -1) {
        emptyIndex = _otpControllers.length;
      }
      if (emptyIndex > 0) {
        _otpControllers[emptyIndex - 1].clear();
        FocusScope.of(context).previousFocus();
      }
    } else if (value.isNotEmpty) {
      if (emptyIndex != -1 && emptyIndex < _otpControllers.length) {
        _otpControllers[emptyIndex].text = value;
        if (emptyIndex < _otpControllers.length - 1) {
          FocusScope.of(context).nextFocus();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // ترتيب الأزرار بالشكل المطلوب:
    // 1- 1، 2، 3
    // 2- 4، 5، 6
    // 3- 7، 8، 9
    // 4- فارغ، 0، delete
    final List<String> keys = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '',
      '0',
      'delete',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('التحقق من الرقم'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
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
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // زر التحقق من OTP
            ElevatedButton(
              onPressed: onVerifyOtp,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text(
                      'تحقق',
                      style: TextStyle(fontSize: 18),
                    )),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Text('ألم يصلك الرمز؟ إعادة ارسال الرمز'),
            ),
            const SizedBox(height: 20),
            // لوحة الأرقام المحسنة
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: keys.map((key) {
                  if (key.isEmpty) {
                    return const SizedBox.shrink();
                  } else if (key == 'delete') {
                    return ElevatedButton(
                      onPressed: () => _handleKeyPress('delete', context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 237, 200, 203),
                        minimumSize: const Size(40, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Icon(
                        Icons.backspace_outlined,
                        color: Colors.green[800],
                        size: 20,
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () => _handleKeyPress(key, context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen[100],
                        foregroundColor: Colors.black,
                        minimumSize: const Size(45, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        key,
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  }
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
