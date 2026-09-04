import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/helpers/secure_storage_helper.dart';
import 'package:marketi/core/services/cache_helper.dart';
import '../../data/repos/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final AuthRepo _authRepo = AuthRepo();

  Future<void> login({required String identifier, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await _authRepo.login(
        identifier: identifier,
        password: password,
      );
      String token = response['token'];
      await SecureStorageHelper.setToken(token);
      if (response['token'] != null) {
        await CacheHelper.saveString(key: 'token', value: response['token']);
      }
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
