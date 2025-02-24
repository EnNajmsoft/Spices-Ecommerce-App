import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('لديك حساب بالفعل؟'),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
          child: const Text('تسجيل الدخول'),
        ),
      ],
    );
  }
}
