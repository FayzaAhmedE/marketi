import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final AuthRepo _authRepo = AuthRepo();

  Future<void> login({required String identifier, required String password}) async {
    emit(LoginLoading());
    try {
      await _authRepo.login(identifier: identifier, password: password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
