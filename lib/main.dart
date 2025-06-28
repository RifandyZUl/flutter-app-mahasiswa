import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // splash screen pertama yang ditampilkan

void main() {
  runApp(const UasMobileApp());
}

class UasMobileApp extends StatelessWidget {
  const UasMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS MOBILE PROGRAMMING',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // <- jalankan splash screen lebih dulu
    );
  }
}
