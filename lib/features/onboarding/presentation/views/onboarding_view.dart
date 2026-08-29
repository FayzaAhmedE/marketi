import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/widgets/page_indicator.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/onboarding_model.dart';
import '../manager/onboarding_cubit.dart';
import '../manager/onboarding_state.dart';

/// دي الشاشة نفسها بس شغلتها إنها "تجهّز" الـ Cubit وتديه للـ Widget اللي جوه
/// (BlocProvider هو اللي بيعمل الـ Cubit ويخليه متاح للـ widgets اللي تحته)
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingBody(),
    );
  }
}

class _OnboardingBody extends StatefulWidget {
  const _OnboardingBody();

  @override
  State<_OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<_OnboardingBody> {
  final PageController _pageController = PageController();

  final List<OnboardingModel> _pages = [
    OnboardingModel(
      image: AppAssets.onboarding1,
      title: 'Welcome to Marketi',
      description:
          'Discover a world of endless possibilities and shop from the comfort of your fingertips Browse through a wide range of products, from fashion and electronics to home.',
    ),
    OnboardingModel(
      image: AppAssets.onboarding2,
      title: 'Easy to Buy',
      description:
          'Find the perfect item that suits your style and needs With secure payment options and fast delivery, shopping has never been easier.',
    ),
    OnboardingModel(
      image: AppAssets.onboarding3,
      title: 'Wonderful User Experience',
      description:
          'Start exploring now and experience the convenience of online shopping at its best.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          // BlocConsumer = BlocListener (لعمل حاجة زي التنقل) + BlocBuilder (لإعادة بناء الشاشة) مع بعض
          child: BlocConsumer<OnboardingCubit, OnboardingState>(
            listener: (context, state) {
              // لما الـ onboarding يخلص، ننتقل لشاشة الـ Login
              if (state is OnboardingCompleted) {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              }
            },
            builder: (context, state) {
              final currentIndex = cubit.currentIndex;

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: cubit.changePage,
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              _pages[index].image,
                              height: 280,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 32),
                            PageIndicator(
                              pages: _pages,
                              currentIndex: currentIndex,
                            ),
                            const SizedBox(height: 32),
                            Text(
                              _pages[index].title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _pages[index].description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bottom Button (Next / Get Started)
                  CustomButton(
                    text: currentIndex == _pages.length - 1 ? 'Get Started' : 'Next',
                    onPressed: () {
                      if (currentIndex < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        cubit.completeOnboarding();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}



