class Product {
  final int? id;
  final String? name;
  final String? slug;
  final double? price;
  final double? salePrice;
  final int? subCategoryId;
  final String? image;
  final String? summary;
  final String? description;
  final int? unitId;
  final int? quantity;
  final int? stock;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final SubCategory? subCategory;
  final Unit? unit;

  const Product({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.salePrice,
    this.subCategoryId,
    this.image,
    this.summary,
    this.description,
    this.unitId,
    this.quantity,
    this.stock,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.subCategory,
    this.unit,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      salePrice: (json['sale_price'] as num?)?.toDouble(),
      subCategoryId: json['sub_category_id'] as int?,
      image: json['image'] as String?,
      summary: json['summary'] as String?,
      description: json['description'] as String?,
      unitId: json['unit_id'] as int?,
      quantity: json['quantity'] as int?,
      stock: json['stock'] as int?,
      status: json['status'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      subCategory: json['sub_category'] != null
          ? SubCategory.fromJson(json['sub_category'] as Map<String, dynamic>)
          : null,
      unit: json['unit'] != null
          ? Unit.fromJson(json['unit'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'price': price,
      'sale_price': salePrice,
      'sub_category_id': subCategoryId,
      'image': image,
      'summary': summary,
      'description': description,
      'unit_id': unitId,
      'quantity': quantity,
      'stock': stock,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'sub_category': subCategory?.toJson(),
      'unit': unit?.toJson(),
    };
  }
}

class SubCategory {
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? image;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  const SubCategory({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      status: json['status'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'image': image,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Unit {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  const Unit({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
