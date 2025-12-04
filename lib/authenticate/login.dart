import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  // Định nghĩa màu sắc theo hình mẫu
  final Color _darkBackgroundColor = const Color(0xFF0F1123); // Màu nền tối phía trên
  final Color _greenColor = const Color(0xFF55AA36); // Màu xanh lá chủ đạo
  final Color _inputFillColor = const Color(0xFFEFF3F6); // Màu nền của ô nhập liệu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // --- Phần Header (Màu tối) ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
              child: Column(
                children: const [
                  Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please Sign in to your existing account",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // --- Phần Body (Màu trắng, bo góc) ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // EMAIL LABEL & INPUT
                      _buildLabel("EMAIL"),
                      const SizedBox(height: 8),
                      _buildTextField(
                        hintText: "example@gmail.com",
                        obscureText: false,
                      ),

                      const SizedBox(height: 20),

                      // PASSWORD LABEL & INPUT
                      _buildLabel("PASSWORD"),
                      const SizedBox(height: 8),
                      _buildTextField(
                        hintText: "● ● ● ● ● ● ● ●",
                        obscureText: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // REMEMBER ME & FORGOT PASSWORD
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _rememberMe,
                                  activeColor: _greenColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  side: const BorderSide(color: Colors.grey),
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Remember me",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                color: _greenColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 24),

                      // LOGIN BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _greenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // SIGN UP LINK
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: _greenColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // "Or" SEPARATOR
                      const Center(
                        child: Text(
                          "Or",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // SOCIAL BUTTONS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            color: Colors.blue,
                            icon: Icons.facebook, // Placeholder cho Facebook
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            color: Colors.black,
                            icon: Icons.apple, // Placeholder cho Apple
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            color: Colors.blueAccent,
                            icon: Icons.send, // Placeholder cho Telegram
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper cho Label (EMAIL, PASSWORD)
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }

  // Widget helper cho TextField
  Widget _buildTextField({
    required String hintText,
    required bool obscureText,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _inputFillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  // Widget helper cho nút Social
  Widget _buildSocialButton({required Color color, required IconData icon}) {
    // Lưu ý: Trong thực tế bạn nên dùng Image.asset để hiển thị logo chính xác
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}