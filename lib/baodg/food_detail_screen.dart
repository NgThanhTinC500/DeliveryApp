import 'package:DeliveryApp/baodg/review_screen.dart';
import 'package:DeliveryApp/nav_helper.dart';
import 'package:flutter/material.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen>
    with SingleTickerProviderStateMixin {
  // State variables
  String _selectedSize = '14"';
  int _quantity = 1;
  bool _isFavorite = false;
  late AnimationController _heartAnimationController;
  late Animation<double> _heartScaleAnimation;

  final List<String> sizes = ['10"', '14"', '16"'];
  final double _basePrice = 32.0; // Base price per item

  @override
  void initState() {
    super.initState();
    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heartScaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _heartAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    // Play animation
    _heartAnimationController.forward().then((_) {
      _heartAnimationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access global theme colors
    final primaryColor = Theme.of(context).colorScheme.primary; // Green
    final redColor = Theme.of(context).colorScheme.error; // Red

    return Scaffold(
      backgroundColor: Colors.white,
      // 1. Custom App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          width: 48,
          height: 48,
          margin: const EdgeInsets.only(left: 16.0),
          decoration: const BoxDecoration(
            color: Color(0xFFF0F4F9), // Light grey circle
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.black, size: 24),
            padding: EdgeInsets.zero,
            onPressed: () => context.pop(),
          ),
        ),
        title: const Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),

      // 2. Main Body with Scroll
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // --- Hero Image Section (UPDATED) ---
                    _buildHeroImage(),
                    const SizedBox(height: 24),

                    // --- Restaurant Info ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2))
                              ]),
                          child: Row(
                            children: [
                              const Icon(Icons.storefront,
                                  color: Colors.orange, size: 18),
                              const SizedBox(width: 8),
                              Text('Uttora Coffee House',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800])),
                            ],
                          ),
                        ),
                        // Review Link
                        GestureDetector(
                          onTap: () {
                            // Navigate to Review Screen
                            context.push(ReviewScreen());
                          },
                          child: Text(
                            'Review',
                            style:
                                TextStyle(color: Colors.grey[500], fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // --- Title & Description ---
                    const Text(
                      'Pizza Calzone European',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- Metrics Row ---
                    Row(
                      children: [
                        _buildMetric(Icons.star, '4.7', redColor),
                        const SizedBox(width: 24),
                        _buildMetric(Icons.local_shipping, 'Free', redColor),
                        const SizedBox(width: 24),
                        _buildMetric(Icons.access_time, '20 min', redColor),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // --- Size Selector ---
                    Row(
                      children: [
                        const Text('SIZE:',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        ...sizes
                            .map((size) => _buildSizeChip(size, primaryColor))
                            .toList(),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // --- Ingredients ---
                    const Text('INGREDIENTS',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIngredientIcon(Icons.grain), // Salt/Spice
                        _buildIngredientIcon(Icons.set_meal), // Meat
                        _buildIngredientIcon(Icons.eco), // Onion/Veg
                        _buildIngredientIcon(Icons.restaurant), // Garlic
                        _buildIngredientIcon(Icons.whatshot), // Chili
                      ],
                    ),
                    const SizedBox(height: 30), // Bottom padding for scroll
                  ],
                ),
              ),
            ),

            // 3. Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8FA), // Light grey background
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Row(
                children: [
                  // Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$${(_basePrice * _quantity).toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                  const Spacer(),

                  // Add Cart Button (Pill shaped outline)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text('Add cart',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),

                  // Quantity Control (Green Pill)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFF90C263), // Lighter green from image
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        _buildQtyBtn(Icons.remove, () {
                          if (_quantity > 1) setState(() => _quantity--);
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('$_quantity',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        _buildQtyBtn(
                            Icons.add, () => setState(() => _quantity++)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  // UPDATED: Hero Image with overlapping effect
  Widget _buildHeroImage() {
    return SizedBox(
      height: 200, // Define total height for the stack
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // 1. The Green Background (Bottom Half)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 160, // Height of the green background
              decoration: BoxDecoration(
                color: const Color(0xFFC9E9C6), // Light green
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          // 2. The Pizza Piece Image (On Top)
          Positioned(
            // Adjust top to make it "pop" out of the background
            top: 0,
            child: Image.asset(
              'assets/img_pizza_piece.png', // Your new asset
              height:
                  160, // Image should be taller than the background to overlap
              fit: BoxFit.contain,
            ),
          ),

          // 3. Favorite Button (Bottom Right)
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: _toggleFavorite,
              child: AnimatedBuilder(
                animation: _heartScaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _heartScaleAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _isFavorite
                            ? const Color(0xFFE74C3C)
                            : const Color(
                                0xFF54A312), // Red when favorited, green otherwise
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  Widget _buildSizeChip(String size, Color primaryColor) {
    final isSelected = _selectedSize == size;
    return GestureDetector(
      onTap: () => setState(() => _selectedSize = size),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF54A312)
              : Colors.grey[200], // Dark green if selected
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientIcon(IconData icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF54A312).withOpacity(0.8), // Green background
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          color: Colors.black, // Black buttons inside the green pill
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}
