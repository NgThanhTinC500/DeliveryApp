import 'package:DeliveryApp/baodg/order_tracking_screen.dart';
import 'package:DeliveryApp/nav_helper.dart';
import 'package:flutter/material.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access global theme colors
    final primaryColor = Theme.of(context).colorScheme.primary; // Green

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Optional: Background Pattern
          // If you have the doodle pattern asset, uncomment and use this:
          Positioned.fill(
            child: Opacity(
              opacity: 0.05, // Very faint as seen in image
              child: Image.asset(
                'assets/img_bg_congrats.png', 
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),

          // 2. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2), // Pushes content slightly up from center
                  
                  // Central Illustration (Wallet & Money)
                  // You will need to export this group from Figma as 'success_illustration.png'
                  SizedBox(
                    height: 250, 
                    child: Image.asset(
                      'assets/img_congrats.png', 
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback placeholder if asset is missing
                        return Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.check_circle, size: 80, color: Colors.orange),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  // Title
                  const Text(
                    'Congratulations!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                  const SizedBox(height: 16),

                  // Subtitle
                  // Note: Fixed grammar from "maked" to "made"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'You successfully made a payment, enjoy our service!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                        height: 1.5, // Line height for better readability
                      ),
                    ),
                  ),

                  const Spacer(flex: 3), // Pushes button to bottom

                  // Bottom Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(OrderTrackingScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, // Green #54A312
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'TRACK ORDER',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Bottom safe margin
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}