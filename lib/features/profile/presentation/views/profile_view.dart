import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../manager/profile_cubit.dart';
import '../manager/profile_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: const _ProfileBody(),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }

          final user = (state as ProfileLoaded).user;
          final cubit = context.read<ProfileCubit>();

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(user.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(user.username, style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.settings, color: AppColors.primary),
                title: const Text('Account Preferences'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: هنبنيها في خطوة جاية
                },
              ),
              ListTile(
                leading: const Icon(Icons.credit_card, color: AppColors.primary),
                title: const Text('Subscription & Payment'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              SwitchListTile(
                secondary: const Icon(Icons.notifications, color: AppColors.primary),
                title: const Text('App Notifications'),
                value: cubit.notificationsEnabled,
                onChanged: cubit.toggleNotifications,
              ),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode, color: AppColors.primary),
                title: const Text('Dark Mode'),
                value: cubit.darkModeEnabled,
                onChanged: cubit.toggleDarkMode,
              ),
              ListTile(
                leading: const Icon(Icons.star, color: AppColors.primary),
                title: const Text('Rate Us'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.feedback, color: AppColors.primary),
                title: const Text('Provide Feedback'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Log Out', style: TextStyle(color: Colors.red)),
                onTap: () {
                  // بنرجّع المستخدم لصفحة الـ login ونمسح كل الشاشات اللي فاتت
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.login, (route) => false);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
