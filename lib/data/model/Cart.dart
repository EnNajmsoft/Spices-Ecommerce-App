class Cart {
  final int id;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: List<CartItem>.from(
          json['items'].map((item) => CartItem.fromJson(item))),
    );
  }
}

class CartItem {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  CartItem({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cartId: json['cart_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String slug;
  final double price;
  final double salePrice;
  final int subCategoryId;
  final String imageUrl;
  final String summary;
  final String description;
  final int unitId;
  final int quantity;
  final int stock;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.price,
    required this.salePrice,
    required this.subCategoryId,
    required this.imageUrl,
    required this.summary,
    required this.description,
    required this.unitId,
    required this.quantity,
    required this.stock,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      price: json['price'].toDouble(),
      salePrice: json['sale_price'].toDouble(),
      subCategoryId: json['sub_category_id'],
      imageUrl: json['image_url'],
      summary: json['summary'],
      description: json['description'],
      unitId: json['unit_id'],
      quantity: json['quantity'],
      stock: json['stock'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
