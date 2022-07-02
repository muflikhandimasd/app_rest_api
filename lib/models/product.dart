class Product {
  int? id;
  String? title;
  String? description;
  String? image;
  String? price;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.price,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
