import 'package:Spices_Ecommerce_app/controller/CartController.dart';
import 'package:Spices_Ecommerce_app/controller/CategoryController.dart';
import 'package:Spices_Ecommerce_app/controller/ProductController.dart';
import 'package:Spices_Ecommerce_app/core/class/statusrequest.dart';
import 'package:Spices_Ecommerce_app/data/model/ProdCategory.dart';
import 'package:Spices_Ecommerce_app/data/model/Product.dart';
import 'package:Spices_Ecommerce_app/views/home/category_card.dart';
import 'package:Spices_Ecommerce_app/views/home/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.find();
  final CategoryController categoryController = Get.put(CategoryController());

  bool _showDropdown = false;
  List<dynamic> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'ابحث عن المنتجات...',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            _performSearch(value);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // افتح القائمة الجانبية
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Obx(() {
            if (productController.isLoading.value ||
                categoryController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (productController.statusRequest ==
                    StatusRequest.failure ||
                categoryController.statusRequest == StatusRequest.failure) {
              return Center(child: Text('فشل في تحميل البيانات'));
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('الفئات',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              // عرض المزيد من الفئات
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryController.categoryList.length,
                        itemBuilder: (context, index) {
                          final category =
                              categoryController.categoryList[index];
                          return CategoryCard(category: category);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('المنتجات المميزة',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              // عرض المزيد من المنتجات
                            },
                          ),
                        ],
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: productController.productList.length,
                      itemBuilder: (context, index) {
                        final product = productController.productList[index];
                        return ProductCard(product: product);
                      },
                    ),
                  ],
                ),
              );
            }
          }),
          if (_showDropdown)
            Positioned(
              top: 25, // تعديل الموقع حسب الحاجة
              left: 0,
              right: 0,
              height:
                  MediaQuery.of(context).size.height * 0.4, // نصف الشاشة أو أقل
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final item = _searchResults[index];
                    if (item is Product) {
                      return _buildProductSearchResult(item);
                    } else if (item is ProdCategory) {
                      return _buildCategorySearchResult(item);
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _showDropdown = false;
        _searchResults.clear();
      });
      return;
    }

    productController.searchProducts(query);
    categoryController.searchCategories(query);

    setState(() {
      _searchResults.clear();
      _searchResults.addAll(productController.searchedProducts);
      _searchResults.addAll(categoryController.searchedCategories);
      _showDropdown = _searchResults.isNotEmpty;
    });
  }

  Widget _buildProductSearchResult(Product product) {
    return ListTile(
      leading: Image.network(product.image!, width: 50, height: 50),
      title: Text(product.name!),
      subtitle: Text('${product.price} ريال'),
      onTap: () {
        // التعامل مع اختيار المنتج
        setState(() {
          _showDropdown = false;
        });
      },
    );
  }

  Widget _buildCategorySearchResult(ProdCategory category) {
    return ListTile(
      leading: Image.network(category.image!, width: 50, height: 50),
      title: Text(category.name!),
      onTap: () {
        // التعامل مع اختيار القسم
        setState(() {
          _showDropdown = false;
        });
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    // ... (كود مربع التصفية)
  }
}
