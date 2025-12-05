import 'package:flutter/material.dart';

// Tên class này phải khớp với tên được gọi bên file congratulation.dart
class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  final Color primaryGreen = const Color(0xFF6CC51D);
  final Color greyText = const Color(0xFF9E9E9E);
  final Color darkText = const Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context), // Truyền context vào để làm nút Back
              const SizedBox(height: 30),
              _buildDriverInfo(),
              const SizedBox(height: 20),
              const Divider(thickness: 1, color: Color(0xFFEEEEEE)),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    "Estimate times",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkText),
                  ),
                  const Spacer(),
                  Text(
                    "30mins",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: darkText),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildStatusCard(),
              const SizedBox(height: 30),
              _buildDeliveryDetails(),
              const SizedBox(height: 30),
              Text(
                "Food to be delivered",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText),
              ),
              const SizedBox(height: 15),
              _buildFoodList(),
            ],
          ),
        ),
      ),
    );
  }

  // Sửa lại nút Back để có thể quay lại nếu muốn
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context); // Lệnh này để quay lại màn hình trước
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          ),
        ),
        const SizedBox(width: 20),
        const Text(
          "Track orders",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDriverInfo() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: NetworkImage('https://i.pravatar.cc/150?img=11'),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DAO GIA BAO", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText)),
              const SizedBox(height: 4),
              Text("Delivery guy", style: TextStyle(fontSize: 14, color: greyText)),
            ],
          ),
        ),
        _buildActionButton(Icons.chat_bubble_outline),
        const SizedBox(width: 10),
        _buildActionButton(Icons.phone),
      ],
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(color: primaryGreen, borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 15, offset: const Offset(0, 5)),
        ],
        border: Border.all(color: const Color(0xFFF5F5F5)),
      ),
      child: Column(
        children: [
          _buildTimelineItem(isActive: true, isFirst: true, isLast: false, title: "Preparing your order", subtitle: "We are preparing your food with magic and care", timeReq: "Time Req. 20mins"),
          _buildTimelineItem(isActive: false, isFirst: false, isLast: false, title: "Your order is on the way"),
          _buildTimelineItem(isActive: false, isFirst: false, isLast: true, title: "Your order has been delivered"),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({required bool isActive, required bool isFirst, required bool isLast, required String title, String? subtitle, String? timeReq}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              isActive
                  ? Icon(Icons.location_on, color: primaryGreen, size: 30)
                  : Container(margin: const EdgeInsets.only(top: 4), width: 20, height: 20, decoration: BoxDecoration(color: const Color(0xFFF2F4F8), shape: BoxShape.circle)),
              if (!isLast)
                Expanded(child: Container(width: 2, color: isActive ? primaryGreen.withOpacity(0.2) : const Color(0xFFF2F4F8), margin: const EdgeInsets.symmetric(vertical: 4))),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: isActive ? 2 : 4, bottom: isLast ? 0 : 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: isActive ? FontWeight.bold : FontWeight.normal, color: isActive ? darkText : const Color(0xFFBDBDBD))),
                  if (isActive && subtitle != null) ...[const SizedBox(height: 6), Text(subtitle, style: TextStyle(fontSize: 13, color: greyText, height: 1.4))],
                  if (isActive && timeReq != null) ...[const SizedBox(height: 8), Text(timeReq, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54))],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetails() {
    return Column(
      children: [
        _buildInfoRow(Icons.location_on_outlined, "Deliver to", "Home"),
        const SizedBox(height: 20),
        _buildInfoRow(Icons.credit_card, "Amount Paid", "\$30.00"),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 28, color: Colors.black87),
        const SizedBox(width: 15),
        Text(label, style: TextStyle(fontSize: 15, color: darkText, fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(value, style: TextStyle(fontSize: 15, color: darkText, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildFoodList() {
    final foods = [
      {'img': 'https://images.unsplash.com/photo-1562967963-ed7b6f9588e4?auto=format&fit=crop&w=200&q=80', 'count': 'x2'},
      {'img': 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?auto=format&fit=crop&w=200&q=80', 'count': 'x1'},
      {'img': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=200&q=80', 'count': 'x1'},
      {'img': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=200&q=80', 'count': 'x1'},
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4))]),
                child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(foods[index]['img']!, fit: BoxFit.cover)),
              ),
              const SizedBox(height: 8),
              Text(foods[index]['count']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          );
        },
      ),
    );
  }
}