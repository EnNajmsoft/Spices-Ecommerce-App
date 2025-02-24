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
import 'package:shimmer/shimmer.dart';

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
      appBar: PreferredSize(
        // استخدام PreferredSize لتحديد ارتفاع AppBar مع padding
        preferredSize:
            Size.fromHeight(kToolbarHeight + 10), // إضافة 10 وحدات padding أسفل
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10), // تحديد padding أسفل
          child: AppBar(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 2, 191, 128),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ابحث عن المنتجات...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 2, 191, 128),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                onChanged: (value) {
                  _performSearch(value);
                },
              ),
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    _showFilterDialog(context);
                  },
                ),
              ),
            ],
            backgroundColor: const Color.fromARGB(255, 2, 191, 128),
            elevation: 2,
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(() {
            if (productController.isLoading.value ||
                categoryController.isLoading.value) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 200,
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              );
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
                        mainAxisAlignment:
                            MainAxisAlignment.center, // توسيط النص
                        children: [
                          Text('الفئات',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryController.categoryList.length,
                        itemBuilder: (context, index) {
                          final category =
                              categoryController.categoryList[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CategoryCard(category: category),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // توسيط النص
                        children: [
                          Text('المنتجات ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          // IconButton(
                          //   icon: Icon(Icons.filter_list),
                          //   onPressed: () {
                          //     _showFilterDialog(context);
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.7),
                      itemCount: productController.productList.length,
                      itemBuilder: (context, index) {
                        final product = productController.productList[index];
                        return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ProductCard(product: product));
                      },
                    ),
                  ],
                ),
              );
            }
          }),
          if (_showDropdown)
            Positioned(
              top: 25,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.4,
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
      leading: Image.network(product.image!,
          width: 60, height: 60, fit: BoxFit.cover),
      title: Text(
        product.name!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('${product.price} ريال'),
      onTap: () {
        setState(() {
          _showDropdown = false;
        });
      },
    );
  }

  Widget _buildCategorySearchResult(ProdCategory category) {
    return ListTile(
      leading: Image.network(category.image!,
          width: 60, height: 60, fit: BoxFit.cover),
      title: Text(
        category.name!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
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
