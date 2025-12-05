import 'package:flutter/material.dart';

// Đảm bảo các đường dẫn import này đúng với tên thư mục của bạn
// Nếu IDE (VS Code/Android Studio) báo đỏ, hãy xóa dòng import đi và gõ lại để nó tự gợi ý
import 'package:flutter_project_new/thanhtin/congratulation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // Điểm bắt đầu của ứng dụng là màn hình Chúc Mừng
      home: CongratulationScreen(),
    );
  }
}