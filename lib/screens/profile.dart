import 'package:flutter/material.dart';
import '../components/appbar_actions.dart'; // Pastikan path benar

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: const [AppBarActions()],
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Aceng Celuler',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('NIM: 1234567890'),
            Text('Kelas: 3A - Teknik Informatika'),
          ],
        ),
      ),
    );
  }
}
