import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/services/cache_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  void _navigateNext() {
    Timer(const Duration(seconds: 15), () {
      if (!mounted) return;

      final bool onboardingDone = CacheHelper.getBool(
        key: CacheKeys.onboardingCompleted,
      );

      Navigator.pushReplacementNamed(
        context,
        onboardingDone ? AppRoutes.login : AppRoutes.onboarding,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          width: 300.166259765625,
          height: 256,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
