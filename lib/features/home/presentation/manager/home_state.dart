import 'package:marketi/features/home/presentation/manager/category_model.dart';
import 'package:marketi/features/home/presentation/manager/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductModel> products;
  final List<CategoryModel> categories;

  HomeSuccess({required this.products, required this.categories});
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
