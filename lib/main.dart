import 'package:flutter/material.dart';
import 'package:DeliveryApp/splash/splash_screen.dart';
import 'package:DeliveryApp/thanhtin/congratulation.dart';
import 'package:DeliveryApp/thanhtin/payment-cash.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),   // 👉 chạy Splash trước
    );
  }
}
