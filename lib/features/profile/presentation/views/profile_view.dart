import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isNotificationsEnabled = true;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDarkMode ? const Color(0xFF0D0D0D) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final cardColor = isDarkMode
        ? const Color(0xFF1A1A1A)
        : const Color(0xFFF9FAFB);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode ? Colors.white24 : Colors.grey.shade300,
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 16, color: textColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.primary,
                  size: 26,
                ),
                Positioned(
                  right: 0,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Avatar with Orbit Design
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Orbit Circle Decoration
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                  ),
                  // Avatar Image
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/Shapes.png')
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/profile.png'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Yousef Ragab',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '@Nba1Usef',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.grey : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 30),

            // Profile Options
            _buildProfileTile(
              icon: Icons.person_outline,
              title: 'Account Preferences',
              textColor: textColor,
              onTap: () {},
            ),
            _buildProfileTile(
              icon: Icons.credit_card_outlined,
              title: 'Subscription & Payment',
              textColor: textColor,
              onTap: () {},
            ),
            _buildSwitchTile(
              icon: Icons.notifications_none_outlined,
              title: 'App Notifications',
              value: isNotificationsEnabled,
              textColor: textColor,
              onChanged: (val) => setState(() => isNotificationsEnabled = val),
            ),
            _buildSwitchTile(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              value: isDarkMode,
              textColor: textColor,
              onChanged: (val) => setState(() => isDarkMode = val),
            ),
            _buildProfileTile(
              icon: Icons.star_border_outlined,
              title: 'Rate Us',
              textColor: textColor,
              onTap: () {},
            ),
            _buildProfileTile(
              icon: Icons.chat_bubble_outline,
              title: 'Provide Feedback',
              textColor: textColor,
              onTap: () {},
            ),
            _buildProfileTile(
              icon: Icons.logout,
              title: 'Log Out',
              textColor: Colors.red,
              iconColor: Colors.red,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required Color textColor,
    Color iconColor = AppColors.primary,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required Color textColor,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      trailing: Switch(
        value: value,
        activeColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }
}
