import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/services/cache_helper.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  int currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    emit(OnboardingPageChanged(index));
  }

  Future<void> completeOnboarding() async {
    await CacheHelper.saveBool(key: CacheKeys.onboardingCompleted, value: true);
    emit(OnboardingCompleted());
  }
}
