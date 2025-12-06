import 'package:flutter/material.dart';

// --- Data Models ---
class Category {
  final String name;
  bool isSelected;

  Category(this.name, {this.isSelected = false});
}

class Product {
  final String name;
  final String restaurant;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.restaurant,
    required this.price,
    required this.imageUrl,
  });
}

// --- Main Screen ---
class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  // Dummy Categories
  final List<Category> categories = [
    Category('Pizza', isSelected: true),
    Category('Sandwich'),
    Category('Burger'),
    Category('Sushi'),
    Category('Burrito'),
  ];

  // Dummy Products
  final List<Product> products = [
    Product(name: 'Pizza Margherita', restaurant: 'Rose Garden', price: 30, imageUrl: 'assets/restaurant_item_pizza_1.png'),
    Product(name: 'Pizza Sushi', restaurant: 'J Garden', price: 30, imageUrl: 'assets/restaurant_item_pizza_2.png'),
    Product(name: 'Pizza Laziz', restaurant: 'Rose Garden', price: 30, imageUrl: 'assets/restaurant_item_pizza_3.png'),
    Product(name: 'Pizza Chicago', restaurant: 'Rose Garden', price: 30, imageUrl: 'assets/restaurant_item_pizza_4.png'),
  ];

  @override
  Widget build(BuildContext context) {
    // Accessing your global theme colors
    final primaryColor = Theme.of(context).colorScheme.primary; // Green
    final redColor = Theme.of(context).colorScheme.error; // Red

    return Scaffold(
      backgroundColor: Colors.white, // White background as per design
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header (Back Button & Title)
              Row(
                children: [
                  _buildBackButton(),
                  const Expanded(
                    child: Text(
                      'Restaurant View',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Balance the back button spacing
                ],
              ),
              const SizedBox(height: 24),

              // 2. Hero Image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/pizza_banner_restaurant.png', // Replace with your asset
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 3. Restaurant Info & Metrics
              const Text(
                'Pizza Calzone European',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
              const SizedBox(height: 16),
              
              // Metrics Row (Stars, Delivery, Time)
              Row(
                children: [
                  _buildIconText(Icons.star, '4.7', const Color(0xFFFFB800)),
                  const SizedBox(width: 24),
                  _buildIconText(Icons.local_shipping, 'Free', Colors.grey), // Using generic grey icon
                  const SizedBox(width: 24),
                  _buildIconText(Icons.access_time, '20 min', Colors.grey),
                ],
              ),
              const SizedBox(height: 24),

              // 4. Horizontal Categories
              SizedBox(
                height: 45,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return _CategoryChip(
                      label: cat.name,
                      isSelected: cat.isSelected,
                      selectedColor: primaryColor,
                      onTap: () {
                        setState(() {
                          for (var c in categories) c.isSelected = false;
                          cat.isSelected = true;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // 5. Product Grid Section Title
              const Text(
                'Pizza(10)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // 6. Product Grid
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // Disable grid scrolling
                shrinkWrap: true, // Let Grid take only needed space
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75, // Adjusts the height/width ratio of cards
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: products[index],
                    addButtonColor: redColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildBackButton() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F9), // Light grey background
        borderRadius: BorderRadius.circular(48),
      ),
      child: IconButton(
        icon: const Icon(Icons.chevron_left, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text, Color iconColor) {
    // Simple helper for the metrics row
    return Row(
      children: [
        Icon(icon, color: iconColor == Colors.grey ? const Color(0xFFE14544) : iconColor, size: 18), 
        // Note: Image shows red icons for Free/Time, Yellow for star. 
        // If you want exact image match, replace Colors.grey logic above with your Red color.
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ],
    );
  }
}

// --- Component: Category Chip ---
class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: isSelected ? null : Border.all(color: Colors.grey[300]!),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// --- Component: Product Card ---
class ProductCard extends StatelessWidget {
  final Product product;
  final Color addButtonColor;

  const ProductCard({
    super.key,
    required this.product,
    required this.addButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA), // Very light grey/blue card bg from design
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image centered
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100), // Circular image
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: 100, 
                  height: 100,
                   errorBuilder: (context, error, stackTrace) => Container(
                    width: 100, height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.local_pizza, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Title
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          // Subtitle
          Text(
            product.restaurant,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),

          // Price + Add Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${product.price.toStringAsFixed(0)}\$',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              InkWell(
                onTap: () {
                  // Add to cart logic
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: addButtonColor, // Red
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}