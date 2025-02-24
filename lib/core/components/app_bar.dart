import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar buildAppBar(
  BuildContext context,
  String title, {
  bool showBackButton = true,
  bool showSearchButton = true,
  List<Widget>? actions,
  Color? backgroundColor,
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.white,
      ),
    ),
    centerTitle: true,
    elevation: 5,
    shadowColor: Colors.black.withOpacity(0.3),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundColor != null
              ? [backgroundColor, backgroundColor.withOpacity(0.8)]
              : [Colors.teal, Colors.teal.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    leading: showBackButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
           onPressed: () {
           print('زر الرجوع تم الضغط عليه'); // رسالة تأكيد الضغط
              print('المسار الحالي: ${Get.currentRoute}'); // عرض المسار الحالي
              print('المسار السابق: ${Get.previousRoute}'); // عرض المسار السابق
              print(
                  'المسار الحالي: ${Get.routing.current}'); // عرض المسار الحالي

              Get.back();
            },
          )
        : null,
    actions: [
      if (showSearchButton)
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {

          },
        ),
      if (actions != null) ...actions,
    ],
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
