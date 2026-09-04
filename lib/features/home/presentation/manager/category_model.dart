// category_model.dart
class CategoryModel {
  final String id;
  final String name;
  final String? image;

  CategoryModel({required this.id, required this.name, this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? json['title']?.toString() ?? 'Category',
      image: json['image']?.toString() ?? json['img']?.toString(),
    );
  }
}
