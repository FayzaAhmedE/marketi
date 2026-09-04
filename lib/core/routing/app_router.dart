import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/network/dio_factory.dart';
import 'package:marketi/features/home/presentation/manager/home_cubit.dart';
import 'package:marketi/features/home/data/repos/home_repo.dart'; 
import 'package:marketi/features/home/presentation/views/main_navigation_view.dart';

import 'app_routes.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupView());

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                HomeCubit(HomeRepository(DioFactory.getDio()))..fetchHomeData(),
            child: const MainNavigationView(),
          ),
        );

      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileView());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
