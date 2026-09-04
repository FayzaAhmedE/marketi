import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/home_repo.dart';
import 'category_model.dart';
import 'home_state.dart';
import 'product_model.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        _homeRepo.getProducts(),
        _homeRepo.getCategories(),
      ]);

      final products = results[0] as List<ProductModel>;
      final categories = results[1] as List<CategoryModel>;

      emit(HomeSuccess(products: products, categories: categories));
    } catch (e) {
      emit(HomeError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
