class Cart {
  int? id;
  double? subtotal;
  int? userId;
  var coupon;
  double? totalAmount;
 var discountAmount;
  double? distance;
  double? deliveryAmount;
  String? createdAt;
  List<Items>? items;

  Cart(
      {this.id,
      this.subtotal,
      this.userId,
      this.coupon,
      this.totalAmount,
      this.discountAmount,
      this.distance,
      this.deliveryAmount,
      this.createdAt,
      this.items});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subtotal = json['subtotal'];
    userId = json['user_id'];
    coupon = json['coupon'];
    totalAmount = json['total_amount'];
    discountAmount = json['discount_amount'];
    distance = json['distance'];
    deliveryAmount = json['delivery_amount'];
    createdAt = json['created_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subtotal'] = this.subtotal;
    data['user_id'] = this.userId;
    data['coupon'] = this.coupon;
    data['total_amount'] = this.totalAmount;
    data['discount_amount'] = this.discountAmount;
    data['distance'] = this.distance;
    data['delivery_amount'] = this.deliveryAmount;
    data['created_at'] = this.createdAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? name;
  String? image;
  int? cartId;
  int? productId;
  int? quantity;
  double? price;
  double? totalPrice;
  Product? product;

  Items(
      {this.id,
      this.name,
      this.image,
      this.cartId,
      this.productId,
      this.quantity,
      this.price,
      this.totalPrice,
      this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    cartId = json['cart_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['total_price'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['cart_id'] = this.cartId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? slug;
  double? price;
  double? salePrice;
  int? categoryId;
  int? subCategoryId;
  String? image;
  String? summary;
  String? description;
  int? unitId;
  int? quantity;
  int? stock;
  int? status;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.name,
      this.slug,
      this.price,
      this.salePrice,
      this.categoryId,
      this.subCategoryId,
      this.image,
      this.summary,
      this.description,
      this.unitId,
      this.quantity,
      this.stock,
      this.status,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    price = json['price'];
    salePrice = json['sale_price'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    image = json['image'];
    summary = json['summary'];
    description = json['description'];
    unitId = json['unit_id'];
    quantity = json['quantity'];
    stock = json['stock'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['image'] = this.image;
    data['summary'] = this.summary;
    data['description'] = this.description;
    data['unit_id'] = this.unitId;
    data['quantity'] = this.quantity;
    data['stock'] = this.stock;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
