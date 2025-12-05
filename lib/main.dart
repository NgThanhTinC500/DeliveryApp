import 'package:DeliveryApp/baodg/food_detail_screen.dart';
import 'package:DeliveryApp/baodg/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:DeliveryApp/splash/splash_screen.dart';
import 'package:DeliveryApp/thanhtin/congratulation.dart';
import 'package:DeliveryApp/thanhtin/payment-cash.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // 👉 chạy Splash trước
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF54A312), // Your Primary Green
          primary: const Color(0xFF54A312), // Explicitly set Primary
          surface: const Color(0xFFFFFFFF), // Your White Background
          error: const Color(0xFFE14544), // Your Red
          // Optional: Define 'on' colors for text readability
          onPrimary: Colors.white,
          onSurface: Colors.black,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
