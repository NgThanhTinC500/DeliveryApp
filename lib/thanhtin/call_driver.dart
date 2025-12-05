import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CallScreen(),
  ));
}

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // URL ảnh avatar mẫu (phong cách hoạt hình giống trong hình)
    final String avatarUrl = "https://avataaars.io/?avatarStyle=Circle&topType=ShortHairShortFlat&accessoriesType=Prescription02&hairColor=BrownDark&facialHairType=BeardMedium&facialHairColor=BrownDark&clotheType=BlazerShirt&eyeType=Wink&eyebrowType=Default&mouthType=Smile&skinColor=Light";

    return Scaffold(
      // Màu nền phía sau cùng (trùng màu áo hoặc xanh nhạt)
      backgroundColor: const Color(0xFF86B4F5),
      body: Stack(
        children: [
          // 1. LỚP NỀN (Ảnh khuôn mặt phóng to)
          Positioned(
            top: -100, // Đẩy ảnh lên trên để lấy phần trán/mắt
            left: 0,
            right: 0,
            child: Transform.scale(
              scale: 1.8, // Phóng to ảnh
              child: Image.network(
                avatarUrl,
                height: 600,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 2. LỚP THÔNG TIN (Bottom Sheet)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65, // Chiếm khoảng 65% màn hình
              decoration: const BoxDecoration(
                color: Color(0xFFDCDCDC), // Màu xám nhạt của background dưới
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Avatar tròn nhỏ
                  Container(


                    padding: const EdgeInsets.all(4), // Viền trắng
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xFF5A9BE8), // Màu nền xanh của avatar
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tên người gọi
                  const Text(
                    "DAO GIA BAO",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Trạng thái (Connecting...)
                  Text(
                    "Connecting ...........",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const Spacer(),

                  // Hàng nút bấm chức năng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Nút Mute (Micro)
                      _buildControlBtn(
                        icon: Icons.mic_off,
                        bgColor: Colors.white,
                        iconColor: Colors.black,
                        size: 60,
                      ),

                      // Nút Tắt máy (Màu đỏ - Có vòng tròn bao quanh)
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // ← quay về màn trước
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: _buildControlBtn(
                            icon: Icons.call_end,
                            bgColor: const Color(0xFFFF5252),
                            iconColor: Colors.black,
                            size: 70,
                          ),
                        ),
                      ),


                      // Nút Loa ngoài (Speaker)
                      _buildControlBtn(
                        icon: Icons.volume_up,
                        bgColor: Colors.white,
                        iconColor: Colors.black,
                        size: 60,
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Thanh Home Indicator (giả lập iPhone)
                  Container(
                    width: 130,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper để tạo nút bấm tròn
  Widget _buildControlBtn({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: size * 0.5,
      ),
    );
  }
}