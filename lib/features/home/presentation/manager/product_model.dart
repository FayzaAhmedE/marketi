// product_model.dart
class ProductModel {
  final String id;
  final String name;
  final num price;
  final String? image;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? json['title']?.toString() ?? 'No Name',
      price: json['price'] ?? 0,
      image:
          json['image']?.toString() ??
          json['img']?.toString() ??
          json['cover']?.toString(),
    );
  }
}
