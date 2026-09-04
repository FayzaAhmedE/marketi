import 'package:dio/dio.dart';
import 'package:marketi/features/home/presentation/manager/category_model.dart';
import 'package:marketi/features/home/presentation/manager/product_model.dart';

class HomeRepository {
  final Dio _dio;

  HomeRepository(this._dio);

  Future<List<ProductModel>> getProducts({int skip = 0}) async {
    try {
      final response = await _dio.request(
        'home/products',
        data: {
          "skip": skip.toString(),
          "search": "",
          "brand": "",
          "category": "",
          "rating": "",
          "price": "",
          "discount": "",
          "popular": "",
        },
        options: Options(
          method: 'GET',
          headers: {'Content-Type': 'application/json'},
        ),
      );

      final List data = _extractList(
        response.data,
        possibleKeys: ['list', 'products', 'data', 'docs', 'result'],
      );

      return data
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(_dioErrorMessage(e, fallback: 'Failed to load products'));
    } catch (e) {
      throw Exception('Failed to load products: ${e.toString()}');
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get(
        'home/categories',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final List data = _extractList(
        response.data,
        possibleKeys: ['list', 'categories', 'data', 'docs', 'result'],
      );

      return data
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        _dioErrorMessage(e, fallback: 'Failed to load categories'),
      );
    } catch (e) {
      throw Exception('Failed to load categories: ${e.toString()}');
    }
  }

  List _extractList(
    dynamic responseData, {
    required List<String> possibleKeys,
  }) {
    if (responseData is List) {
      return responseData;
    }
    if (responseData is Map<String, dynamic>) {
      for (final key in possibleKeys) {
        final value = responseData[key];
        if (value is List) return value;
      }
    }
    return [];
  }

  String _dioErrorMessage(DioException e, {required String fallback}) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    return '$fallback: ${e.message}';
  }
}
