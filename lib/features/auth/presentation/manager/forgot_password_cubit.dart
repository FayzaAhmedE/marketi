import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  String contact = ''; 
  Future<void> sendCode(String contactValue) async {
    contact = contactValue;
    emit(ForgotPasswordLoading());
    try {
      await Future.delayed(const Duration(seconds: 1)); 
      emit(CodeSent());
    } catch (e) {
      emit(ForgotPasswordError('حصل خطأ، حاول تاني'));
    }
  }

  Future<void> verifyCode(String code) async {
    emit(ForgotPasswordLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(CodeVerified());
    } catch (e) {
      emit(ForgotPasswordError('الكود غلط، حاول تاني'));
    }
  }

  Future<void> resetPassword(String newPassword) async {
    emit(ForgotPasswordLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(ForgotPasswordError('حصل خطأ، حاول تاني'));
    }
  }
}
