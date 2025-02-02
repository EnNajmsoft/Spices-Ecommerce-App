import '../model/Product.dart'; // مثال لمسار نسبي
class Favorite {
  final int id;
  final int userId;
  final int productId;
  final Product product;

  Favorite({
    required this.id,
    required this.userId,
    required this.productId,
    required this.product,
  });

  // تحويل JSON إلى كائن Favorite
  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      product: Product.fromJson(json['product']), // تحويل Product من JSON
    );
  }

  // تحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'product': product.toJson(), // تحويل Product إلى JSON
    };
  }
}