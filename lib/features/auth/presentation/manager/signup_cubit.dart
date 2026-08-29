import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/auth_repo.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final AuthRepo _authRepo = AuthRepo();

  Future<void> signup({
    required String name,
    required String username,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      await _authRepo.register(
        name: name,
        username: username,
        phone: phone,
        email: email,
        password: password,
      );
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
