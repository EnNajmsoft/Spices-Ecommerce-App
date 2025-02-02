class ProdCategory {
  int? id;
  String? name;
  String? slug;
  String? description;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  ProdCategory({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  // تحويل JSON إلى كائن Category
  factory ProdCategory.fromJson(Map<String, dynamic> json) {
    return ProdCategory(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      image: json['image'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // تحويل كائن Category إلى JSON
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
