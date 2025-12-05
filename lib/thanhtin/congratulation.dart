import 'package:flutter/material.dart';
// QUAN TRỌNG: Dòng này giúp file này nhìn thấy màn hình Preparing Order
import 'package:flutter_project_new/thanhtin/preparing_order.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  final Color primaryGreen = const Color(0xFF6CC51D);
  final Color darkText = const Color(0xFF1A1A1A);
  final Color greyText = const Color(0xFF9E9E9E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

                  // Hình minh họa
                  Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: NetworkImage('https://cdn-icons-png.flaticon.com/512/7518/7518748.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Title
                  Text(
                    "Congratulations!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Subtitle
                  Text(
                    "You successfully made a payment,\nenjoy our service!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: greyText,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Button "TRACK ORDER"
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      // --- PHẦN QUAN TRỌNG NHẤT Ở ĐÂY ---
                      onPressed: () {
                        // Lệnh này thực hiện chuyển màn hình
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderTrackingScreen(),
                          ),
                        );
                      },
                      // -----------------------------------
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "TRACK ORDER",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}