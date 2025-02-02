import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // تعريف التسلسل اللوني الأخضر
    final gradient = LinearGradient(
      colors: [
        Color.fromARGB(201, 90, 228, 77), // أخضر فاتح
        Color.fromARGB(228, 41, 163, 70), // أخضر غامق
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16), // زيادة المساحة الداخلية
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // حواف مستديرة
          ),
          backgroundColor: Colors.transparent, // جعل الخلفية شفافة
          shadowColor: Colors.transparent, // إزالة الظل
          foregroundColor: Colors.white, // لون النص أبيض
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient, // إضافة التدرج اللوني
            borderRadius: BorderRadius.circular(10), // حواف مستديرة
          ),
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: 16), // زيادة المساحة الداخلية
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white, // لون مؤشر التحميل أبيض
                      strokeWidth: 2, // سماكة المؤشر
                    )
                  : Text(
                      'الدخول',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
