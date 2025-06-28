import 'package:flutter/material.dart';
import '../screens/profile.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  void _handleMenuSelection(BuildContext context, String value) {
    if (value == 'profil') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    } else if (value == 'logout') {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text("Logout Berhasil"),
            ],
          ),
          content: const Text("Anda telah keluar dari aplikasi."),
          actions: [
            TextButton(
              child: const Text("OK", style: TextStyle(color: Colors.blue)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) => _handleMenuSelection(context, value),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'profil',
          child: Row(
            children: [
              Icon(Icons.person, color: Colors.black54),
              SizedBox(width: 8),
              Text("Profil"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 8),
              Text("Keluar"),
            ],
          ),
        ),
      ],
    );
  }
}
