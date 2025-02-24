class Order {
  int? id;
  double? subtotal;
  int? discountAmount;
  int? deliveryAmount;
  double? totalAmount;
  String? status;
  String? shippingAddress;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;
  User? user; // إضافة معلومات المستخدم
  List<OrderItem>? items; // إضافة قائمة العناصر في الطلب

  Order({
    this.id,
    this.subtotal,
    this.discountAmount,
    this.deliveryAmount,
    this.totalAmount,
    this.status,
    this.shippingAddress,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.items,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subtotal = (json['subtotal'] is int)
        ? (json['subtotal'] as int).toDouble()
        : json['subtotal'];
    discountAmount = json['discount_amount'];
    deliveryAmount = json['delivery_amount'];
    totalAmount = (json['total_amount'] is int)
        ? (json['total_amount'] as int).toDouble()
        : json['total_amount'];
    status = json['status'];
    shippingAddress = json['shipping_address'];
    paymentMethod = json['payment_method'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null
        ? User.fromJson(json['user'])
        : null; // تحويل بيانات المستخدم
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add(OrderItem.fromJson(v)); // تحويل بيانات العناصر
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subtotal'] = subtotal;
    data['discount_amount'] = discountAmount;
    data['delivery_amount'] = deliveryAmount;
    data['total_amount'] = totalAmount;
    data['status'] = status;
    data['shipping_address'] = shippingAddress;
    data['payment_method'] = paymentMethod;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson(); // تحويل المستخدم إلى JSON
    }
    if (items != null) {
      data['items'] =
          items!.map((v) => v.toJson()).toList(); // تحويل العناصر إلى JSON
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

class OrderItem {
  int? productId;
  String? productName;
  String? image;
  double? productPrice;
  int? quantity;
  int? categoryId;
  int? subCategoryId;

  OrderItem({
    this.productId,
    this.productName,
    this.image,
    this.productPrice,
    this.quantity,
    this.categoryId,
    this.subCategoryId,
  });

  OrderItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    image = json['image'];
    productPrice = (json['product_price'] is int)
        ? (json['product_price'] as int).toDouble()
        : json['product_price'];
    quantity = json['quantity'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['image'] = image;
    data['product_price'] = productPrice;
    data['quantity'] = quantity;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    return data;
  }
}
