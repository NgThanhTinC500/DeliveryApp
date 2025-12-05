import 'dart:async';
import 'package:DeliveryApp/baodg/location_screen.dart';
import 'package:DeliveryApp/home/home_screen.dart';
import 'package:DeliveryApp/nav_helper.dart';
import 'package:DeliveryApp/thanhtin/call_driver.dart';
import 'package:DeliveryApp/thanhtin/chat_order.dart';
import 'package:flutter/material.dart';

// --- Main Screen ---
class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  // 0: Preparing, 1: On the way, 2: Delivered
  int _currentStep = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the 5-second simulation cycle
    _startTrackingSimulation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTrackingSimulation() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_currentStep < 2) {
        setState(() {
          _currentStep++;
        });
      } else {
        timer.cancel(); // Stop when we reach "Delivered"
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access global theme colors
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 16.0),
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFFECF0F4),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Color(0xFF333647),
            ),
            onPressed: () {
              context.push(HomeScreen());
            },
            splashRadius: 20,
          ),
        ),
        title: const Text(
          'Track orders',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Driver Information Card
              _buildDriverInfo(primaryColor),
              const SizedBox(height: 30),

              // 2. Estimate Time Header
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Estimate times',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '30mins',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3. Tracking Status Card (The Dynamic Part)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  children: [
                    // Step 1: Preparing
                    _buildTimelineStep(
                      stepIndex: 0,
                      title: 'Preparing your order',
                      subtitle:
                          'We are preparing your food with magic and care',
                      extraInfo: 'Time Req. 20mins',
                      isActive: _currentStep == 0,
                      isPassed: _currentStep > 0,
                      isLast: false,
                      primaryColor: primaryColor,
                    ),

                    // Step 2: On the Way
                    _buildTimelineStep(
                      stepIndex: 1,
                      title: 'Your order is on the way',
                      subtitle: null,
                      extraInfo: 'Est. time 10mins',
                      isActive: _currentStep == 1,
                      isPassed: _currentStep > 1,
                      isLast: false,
                      primaryColor: primaryColor,
                      customContent: _currentStep == 1
                          ? _buildActionButton('Track order')
                          : null,
                    ),

                    // Step 3: Delivered
                    _buildTimelineStep(
                      stepIndex: 2,
                      title: 'Your order has been delivered',
                      subtitle: null,
                      extraInfo: null,
                      isActive: _currentStep == 2,
                      isPassed: false, // It's the final state
                      isLast: true,
                      primaryColor: primaryColor,
                      customContent: _currentStep == 2
                          ? _buildActionButton('Rate the food!')
                          : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 4. Delivery Address & Amount
              _buildDetailRow(Icons.location_on, 'Deliver to', 'Home'),
              const SizedBox(height: 16),
              _buildDetailRow(Icons.credit_card, 'Amount Paid', '\$30.00'),

              const SizedBox(height: 30),

              // 5. Food List
              const Text(
                'Food to be delivered',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFoodItem('assets/img_jollibee.png', 2),
                    _buildFoodItem('assets/img_cola.png', 1),
                    _buildFoodItem('assets/img_pizz.png', 1),
                    _buildFoodItem('assets/img_burger.png', 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildDriverInfo(Color primaryColor) {
    return Row(
      children: [
        // Driver Avatar
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/driver_avatar.png'), // Add your asset
              fit: BoxFit.cover,
            ),
          ),
          // Fallback if no image
          child: const ClipOval(
            child: Icon(Icons.person, size: 50, color: Colors.grey),
          ),
        ),
        const SizedBox(width: 12),

        // Driver Details
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DAO GIA BAO',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'Delivery guy',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),

        // Buttons
        _buildDriverButton(
          Icons.chat_bubble_outline,
          primaryColor,
          onTap: () {
            context.push(ChatScreen());
          },
        ),
        const SizedBox(width: 12),
        _buildDriverButton(
          Icons.phone,
          primaryColor,
          onTap: () {
            context.push(CallScreen());
          },
        ),
      ],
    );
  }

  Widget _buildDriverButton(IconData icon, Color color,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  // The logic for the Timeline Dots and Lines
  Widget _buildTimelineStep({
    required int stepIndex,
    required String title,
    String? subtitle,
    String? extraInfo,
    required bool isActive,
    required bool isPassed,
    required bool isLast,
    required Color primaryColor,
    Widget? customContent,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Indicator Column
          Column(
            children: [
              // The Dot/Icon
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isActive ? primaryColor : Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: isActive
                    ? const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 14,
                      )
                    : null, // Empty grey circle if inactive
              ),
              // The Line (only if not last item)
              if (!isLast)
                Expanded(child: Container(width: 2, color: Colors.grey[200])),
            ],
          ),
          const SizedBox(width: 16),

          // Text Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
              ), // Spacing between steps
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                      fontSize: 15,
                      color: isActive ? Colors.black : Colors.grey[400],
                    ),
                  ),
                  if (subtitle != null && isActive) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                  if (extraInfo != null && isActive) ...[
                    const SizedBox(height: 4),
                    Text(
                      extraInfo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                  // Render Button if needed (Track order / Rate food)
                  if (customContent != null) ...[
                    const SizedBox(height: 12),
                    customContent,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: OutlinedButton(
        onPressed: () {
          if(label == 'Track order') {
            context.push(LocationScreen());
          } 
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: Colors.black,
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 24, color: Colors.black),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 15),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildFoodItem(String assetPath, int count) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 100,
      child: Column(
        children: [
          Image.asset(
            assetPath,
            fit: BoxFit.contain,
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.fastfood, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            'x$count',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
