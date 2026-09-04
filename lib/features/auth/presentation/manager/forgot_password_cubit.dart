import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/network/api_constants.dart';
import 'package:marketi/core/network/api_service.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  String contact = ''; 
  Future<void> sendCode(String email, dynamic apiConstants) async {
    emit(ForgotPasswordLoading());
    try {
      await ApiService.post(
        url: apiConstants.resetPassword,
        body: {'email': email},
      );
      contact = email;
      emit(CodeSent());
    } catch (e) {
      emit(ForgotPasswordError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> verifyCode(String code) async {
    emit(ForgotPasswordLoading());
    try {
      await ApiService.post(
        url:
            '${ApiConstants.baseUrl}/auth/reset-password/active-reset-password',
        body: {'resetCode': code},
      );
      emit(CodeVerified());
    } catch (e) {
      emit(ForgotPasswordError('code is wrong or expired'));
    }
  }

  Future<void> resetPassword(String newPassword, String confirmPassword) async {
    emit(ForgotPasswordLoading());
    try {
      await ApiService.post(
        url: '${ApiConstants.baseUrl}/auth/reset-password/reset-password',
        body: {
          'email': contact,
          'password': newPassword,
          'confirmPassword': confirmPassword,
        },
      );
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(ForgotPasswordError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
