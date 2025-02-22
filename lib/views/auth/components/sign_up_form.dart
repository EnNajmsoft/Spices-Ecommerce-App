import 'package:Spices_Ecommerce_app/controller/auth/RegisterController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/validators.dart';
import 'already_have_accout.dart';
import 'sign_up_button.dart';
import '../../../core/themes/app_themes.dart';

class SignUpForm extends StatefulWidget {
  // جعلها StatefulWidget
  SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final RegisterController registerController = Get.put(RegisterController());
  final _key = GlobalKey<FormState>();
  bool _obscurePassword = true; // حالة إخفاء كلمة المرور
  bool _obscureConfirmPassword = true; // حالة إخفاء تأكيد كلمة المرور

  void onRegister() async {
    final bool isFormOkay = _key.currentState?.validate() ?? false;
    if (isFormOkay) {
      await registerController.register();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "الاسم",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(219, 5, 91, 15),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: registerController.nameController,
                  validator: Validators.requiredWithFieldName('الاسم').call,
                  textInputAction: TextInputAction.next,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 237, 255, 242),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(228, 41, 163, 70),
                          width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(94, 40, 167, 70),
                          width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    hintText: 'ادخل الاسم',
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(230, 9, 57, 14)),
                  ),
                ),
                const SizedBox(height: AppDefaults.padding),
                const Text(
                  "رقم الجوال",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(219, 5, 91, 15),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: registerController.phoneController,
                  textInputAction: TextInputAction.next,
                  validator: Validators.yemeniPhoneNumber
                      .call, // استخدام التحقق من رقم الهاتف اليمني
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 237, 255, 242),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(228, 41, 163, 70),
                          width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(94, 40, 167, 70),
                          width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    hintText: 'ادخل رقم الجوال',
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(230, 9, 57, 14)),
                  ),
                ),
                const SizedBox(height: AppDefaults.padding),
                const Text(
                  "البريد الإلكتروني",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(219, 5, 91, 15),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: registerController.emailController,
                  textInputAction: TextInputAction.next,
                  validator: Validators.email.call,
                  keyboardType: TextInputType.emailAddress,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 237, 255, 242),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(228, 41, 163, 70),
                          width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(94, 40, 167, 70),
                          width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    hintText: 'ادخل البريد الإلكتروني',
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(230, 9, 57, 14)),
                  ),
                ),
                const SizedBox(height: AppDefaults.padding),
                const Text(
                  "كلمة المرور",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(219, 5, 91, 15),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: registerController.passwordController,
                  validator: Validators.password.call,
                  textInputAction: TextInputAction.next,
                  obscureText: _obscurePassword,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 237, 255, 242),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(228, 41, 163, 70),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(94, 40, 167, 70),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    hintText: 'ادخل كلمة المرور',
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(230, 9, 57, 14)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppDefaults.padding),
               const Text(
                  "تأكيد كلمة المرور",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(219, 5, 91, 15),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: registerController.confirmPasswordController,
                  validator: Validators.password.call,
                  textInputAction: TextInputAction.next,
                  obscureText: _obscureConfirmPassword,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 237, 255, 242),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(228, 41, 163, 70),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(94, 40, 167, 70),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    hintText: 'تأكيد كلمة المرور',
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(230, 9, 57, 14)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppDefaults.padding),
                          Obx(() {
                  return SignUpButton(
                   isLoading: registerController.isLoading.value,
                    onPressed: registerController.register,
                  );
                }),
                const AlreadyHaveAnAccount(),
                const SizedBox(height: AppDefaults.padding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
