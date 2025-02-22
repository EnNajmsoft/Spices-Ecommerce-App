import 'package:Spices_Ecommerce_app/core/services/AuthService.dart';
import 'package:Spices_Ecommerce_app/linkapi.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Spices_Ecommerce_app/core/class/statusrequest.dart';
import 'package:Spices_Ecommerce_app/data/model/Product.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var allProducts = <Product>[].obs;
  var searchedProducts = <Product>[].obs; // قائمة نتائج البحث
  StatusRequest statusRequest = StatusRequest.none;
  final AuthService authService = Get.find();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts({Map<String, dynamic>? filters}) async {
    try {
      isLoading(true);
      final token = await authService.getToken();
      statusRequest = StatusRequest.loading;
      update();

      final Map<String, dynamic> requestBody = {
        'filters': filters ?? {},
      };

      final response = await http.post(
        Uri.parse(AppLink.productsFetch),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        print(
            'Response body fetchProducts=============================: ${response.body}');
        final data = json.decode(response.body);
        final productsData = data['products']['data'] as List;
        allProducts.assignAll(
            productsData.map((json) => Product.fromJson(json)).toList());
        productList.assignAll(allProducts);
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

  void searchProducts(String query) {
    if (query.isEmpty) {
      searchedProducts.clear(); 
    } else {
      searchedProducts.assignAll(allProducts
          .where((product) =>
              product.name!.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }
}
