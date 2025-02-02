import 'package:Spices_Ecommerce_app/linkapi.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Spices_Ecommerce_app/core/class/statusrequest.dart';
import 'package:Spices_Ecommerce_app/data/model/Product.dart'; 

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }
Future<void> fetchProducts() async {
    try {
      isLoading(true);
      statusRequest = StatusRequest.loading;
      update();
      final response = await http.get(
        Uri.parse(AppLink.productsFetch),
        headers: {
        'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print(
          'Response body products=============================: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['products']['data'];
        productList.assignAll(
            productsJson.map((json) => Product.fromJson(json)).toList());
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e'); 
      statusRequest = StatusRequest.serverfailure;
    } finally {
      isLoading(false);
      update();
    }
  }
}
