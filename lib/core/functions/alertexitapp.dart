import 'dart:io';
import 'package:Spices_Ecommerce_app/core/functions/alertelogoteadmin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: "تنبيه",
      titleStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      middleText: "هل تريد الخروج من التطبيق",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color.fromARGB(255, 8, 168, 217),
            )),
            onPressed: () {
                            myServices.sharedPreferences.setString("step", "1");
              print(myServices.sharedPreferences.getString("step"));
              exit(0);
            },
            child: const Text("تاكيد")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color.fromARGB(255, 8, 168, 217),
            )),
            onPressed: () {

              Get.back();
            },
            child: const Text("الغاء"))
      ]);
  return Future.value(true);
}
