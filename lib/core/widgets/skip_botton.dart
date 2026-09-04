import 'package:flutter/material.dart';
import 'package:marketi/core/constants/app_colors.dart';
import 'package:marketi/features/onboarding/presentation/manager/onboarding_cubit.dart';

class SkipBotton extends StatelessWidget {
  const SkipBotton({super.key, required this.cubit});

  final OnboardingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: cubit.completeOnboarding,
        child: const Text(
          'Skip',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
