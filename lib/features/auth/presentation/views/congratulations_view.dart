import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/custom_button.dart';

class CongratulationsView extends StatelessWidget {
  const CongratulationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.celebration, size: 80, color: AppColors.primary),
              const SizedBox(height: 24),
              const Text(
                'Congratulations',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'You have updated the password, please login again with your latest password',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Log In',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.login, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
