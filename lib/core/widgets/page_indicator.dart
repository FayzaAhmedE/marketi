import 'package:flutter/widgets.dart';
import 'package:marketi/core/constants/app_colors.dart';
import 'package:marketi/features/onboarding/data/models/onboarding_model.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this._pages, required this.currentIndex});

  final List<OnboardingModel> _pages;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: currentIndex == index ? 20 : 16,
          width: currentIndex == index ? 20 : 16,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.textPrimary
                : AppColors.primary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
