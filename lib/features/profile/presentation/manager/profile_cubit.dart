import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading()) {
    _loadProfile();
  }

  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  Future<void> _loadProfile() async {
    emit(ProfileLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500)); 
      const user = UserModel(
        name: 'Yousef Ragab',
        username: '@Nba1Usef',
        email: 'you@gmail.com',
        phone: '+20 1501142409',
      );
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError('تعذر تحميل البيانات'));
    }
  }

  void toggleNotifications(bool value) {
    notificationsEnabled = value;
    if (state is ProfileLoaded) {
      emit(ProfileLoaded((state as ProfileLoaded).user));
    }
  }

  void toggleDarkMode(bool value) {
    darkModeEnabled = value;
    if (state is ProfileLoaded) {
      emit(ProfileLoaded((state as ProfileLoaded).user));
    }
  }
}
