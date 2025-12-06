import 'package:DeliveryApp/nav_helper.dart';
import 'package:flutter/material.dart'; // Reuse your navigation helper

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary; // Green

    return Scaffold(
      body: SafeArea(
        top: false, // Allow content to go under status bar
        child: Stack(
          children: [
            // 1. The Map Background
            // In a real app, replace this Container with GoogleMap()
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  // Use the map screenshot you have or a generic map image
                  image: AssetImage('assets/location.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                // Optional: Overlay to make text pop if using a real map image as bg for demo
                color: Colors.white.withOpacity(0.1),
              ),
            ),

            // 2. Top Left: Back Button
            Positioned(
              top: 50,
              left: 20,
              child: _buildCircleButton(
                icon: Icons.chevron_left,
                onTap: () => context.pop(),
              ),
            ),

            // 3. Right Side Map Controls
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              right: 20,
              child: Column(
                children: [
                  _buildCircleButton(
                      icon: Icons.shopping_cart, color: Colors.blue),
                  const SizedBox(height: 12),
                  _buildCircleButton(
                      icon: Icons.navigation,
                      color: Colors.white,
                      iconColor: Colors.red),
                  const SizedBox(height: 12),
                  _buildCircleButton(icon: Icons.search, color: Colors.white),
                ],
              ),
            ),

            // 4. Bottom Right: Sound Toggle
            Positioned(
              bottom: 220, // Positioned above the bottom cards
              right: 20,
              child: _buildCircleButton(
                  icon: Icons.volume_up, iconColor: Colors.black),
            ),

            // 5. Bottom Left: "Re-center" Button
            Positioned(
              bottom: 220,
              left: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5)),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.navigation, color: Colors.blue, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Center', // "Center" in Vietnamese
                      style: TextStyle(
                        color: Colors.teal[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 6. Bottom Floating Cards
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Delivery Status Card
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4F9), // Light grey/blue
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Arrive at 8:00 am',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Delivering to you',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                        // Scooter Illustration
                        Image.asset(
                          'assets/scooter_delivery.png', // Needs a scooter asset
                          width: 50,
                          height: 40,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.delivery_dining,
                                  size: 40, color: Colors.red),
                        ),
                      ],
                    ),
                  ),

                  // Driver Info Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            // image: DecorationImage(image: AssetImage('assets/avatar.png'))
                          ),
                          child: Image.asset(
                            'assets/driver_avatar.png',
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Text
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('DAO GIA BAO',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text('Delivery guy',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),

                        // Action Buttons
                        _buildActionButton(
                            Icons.chat_bubble_outline, primaryColor),
                        const SizedBox(width: 10),
                        _buildActionButton(Icons.phone, primaryColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildCircleButton({
    required IconData icon,
    Color color = Colors.white,
    Color iconColor = Colors.black,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
