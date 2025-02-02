// import 'package:empolyeeapp/controller/empolyee/vacation/viewcontrooler.dart';
// import 'package:empolyeeapp/controller/hr/vacations/empvacatcontroller.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
// import 'package:get/get.dart';

// requestPermissionNotification() async {

//       await FirebaseMessaging.instance.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
// }

// fcmconfig() {
//   print("hai ===============================================");
//   FirebaseMessaging.onMessage.listen((message) {
//     print("================== Notification =================");
//     print(message.notification!.title);
//     print(message.notification!.body);
//     FlutterRingtonePlayer.playNotification();
//     Get.snackbar(message.notification!.title!, message.notification!.body!);
//     refreshPageNotification(message.data);
//   });
// }

// refreshPageNotification(data) {
//   print("============================= page id ");
//   print(data['pageid']);
//   print("============================= page name ");
//   print(data['pagename']);
//   print("================== Current Route");
//   print(Get.currentRoute);

//   if (Get.currentRoute == "/emp_home" &&
//       data['pagename'] == "refreshouservacation") {
//     EmpusercontrollerImp controller = Get.find();
//     controller.refrehVacation();
//   }
//   if (Get.currentRoute == "/Empvacationview" &&
//       data['pagename'] == "Empvacationview") {
//     EmpvacatcontrollerImp controller = Get.find();
//     controller.refrehHRVacation();
//   }
// }

// // Firebase + stream 
// // Socket io 
// // Notification refresh 