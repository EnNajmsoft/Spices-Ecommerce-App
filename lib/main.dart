import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:Spices_Ecommerce_app/core/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_routes.dart';

import 'core/themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthService()); 
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Spices Ecommerce',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      // onGenerateRoute: RouteGenerator.onGenerate,
      // initialRoute: AppRoutes.entryPoint,
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
    );
  }
}
