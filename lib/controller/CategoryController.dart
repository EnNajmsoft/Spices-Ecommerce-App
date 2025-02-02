import 'package:Spices_Ecommerce_app/data/model/ProdCategory.dart';
import 'package:Spices_Ecommerce_app/linkapi.dart'; // تأكد من استيراد AppLink
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Spices_Ecommerce_app/core/class/statusrequest.dart'; // تأكد من استيراد StatusRequest

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryList = <ProdCategory>[].obs; // تغيير النوع إلى List<Category>
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    fetchCategories(); // تغيير اسم الدالة إلى fetchCategories
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      statusRequest = StatusRequest.loading;
      update();

      final response = await http.get(
        Uri.parse(AppLink.categoriesFetch), // استخدام الرابط الصحيح
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print(
          'Response body categories=============================: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> categoriesJson =
            data['categories']; // تحليل categories
        categoryList.assignAll(
            categoriesJson.map((json) => ProdCategory.fromJson(json)).toList());
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e'); // طباعة الخطأ
      statusRequest = StatusRequest.serverfailure;
    } finally {
      isLoading(false);
      update();
    }
  }
}
