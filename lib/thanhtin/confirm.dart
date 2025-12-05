import 'package:flutter/material.dart';
import 'package:DeliveryApp/thanhtin/preparing_order.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  final Color primaryGreen = const Color(0xFF6CC51D);
  final Color darkText = const Color(0xFF1A1A1A);
  final Color greyText = const Color(0xFF9E9E9E);
  final Color bgGrey = const Color(0xFFF6F8FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header - TRUYỀN CONTEXT VÀO ĐÂY
              _buildHeader(context),

              const SizedBox(height: 30),

              // 2. Danh sách món ăn
              Expanded(
                child: ListView(
                  children: [
                    _buildCartItem(
                      title: "Pizza Calzone European",
                      price: "\$64",
                      size: "14”",
                      quantity: "x2",
                      imageUrl: "https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=300&q=80",
                    ),
                    const SizedBox(height: 20),
                    _buildCartItem(
                      title: "Pizza Calzone European",
                      price: "\$64",
                      size: "14”",
                      quantity: "x2",
                      imageUrl: "https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=300&q=80",
                    ),
                  ],
                ),
              ),

              // 3. Thông tin thanh toán
              const SizedBox(height: 20),
              _buildPriceDetails(),

              // 4. Nút Confirm
              const SizedBox(height: 30),
              _buildConfirmButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets con ---

  // BƯỚC 1: Thêm tham số 'BuildContext context'
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // BƯỚC 2: Bọc trong GestureDetector để bắt sự kiện nhấn
        GestureDetector(
          onTap: () {
            Navigator.pop(context); // Lệnh quay lại màn hình trước
          },
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          ),
        ),
        const SizedBox(width: 20),
        Text(
          "Confirmation",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem({
    required String title,
    required String price,
    required String size,
    required String quantity,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  size,
                  style: TextStyle(
                    fontSize: 14,
                    color: greyText,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              quantity,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetails() {
    return Column(
      children: [
        _buildInfoRow("Original:", "\$96"),
        const SizedBox(height: 15),
        _buildInfoRow("Discount:", "\$10"),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment method:",
              style: TextStyle(fontSize: 16, color: greyText),
            ),
            Row(
              children: [
                Text(
                  "Mastercard",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: darkText,
                  ),
                ),
                const SizedBox(width: 8),
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png',
                  width: 30,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        const Divider(color: Color(0xFFEEEEEE), thickness: 1),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total:",
              style: TextStyle(fontSize: 16, color: greyText),
            ),
            Text(
              "\$86",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: greyText),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: darkText,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderTrackingScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: const Text(
          "CONFIRM",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}