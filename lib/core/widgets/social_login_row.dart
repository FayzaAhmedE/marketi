import 'package:flutter/material.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(Icons.g_mobiledata),
            const SizedBox(width: 16),
            _icon(Icons.apple),
            const SizedBox(width: 16),
            _icon(Icons.facebook),
          ],
        ),
      ],
    );
  }

  Widget _icon(IconData icon) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey.shade100,
      child: Icon(icon, color: Colors.black87),
    );
  }
}
