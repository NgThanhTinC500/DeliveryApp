import 'package:DeliveryApp/baodg/payment_screen.dart';
import 'package:DeliveryApp/baodg/voucher_screen.dart';
import 'package:DeliveryApp/nav_helper.dart';
import 'package:flutter/material.dart';

// --- Data Model ---
class CartItem {
  final String id;
  final String name;
  final double price;
  final String size;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    required this.imageUrl,
    this.quantity = 1,
  });
}

// --- Main Cart Screen ---
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Dummy data
  final List<CartItem> cartItems = [
    CartItem(
      id: '1',
      name: 'Pizza Calzone \nEuropean',
      price: 64.00,
      size: '14"',
      imageUrl: 'assets/mock_pizza_cart.png',
      quantity: 2,
    ),
    CartItem(
      id: '2',
      name: 'Pizza Calzone \nEuropean',
      price: 32.00,
      size: '14"',
      imageUrl: 'assets/mock_pizza_cart.png',
      quantity: 1,
    ),
  ];

  // 1. Logic to Show the Confirmation Dialog
  void _showDeleteConfirmDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20.0,
            ), // Matches screenshot rounded corners
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            // Constrain width if needed, or let it adapt
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header: Title and Close Icon
                Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Deletion Confirm',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily:
                                'Poppins', // Assuming global font, but explicit here
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.close,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(
                  thickness: 0.5,
                  color: Color(0xFFECF0F4),
                ), // Thin separator line
                const SizedBox(height: 20),

                // Body Message
                const Text(
                  'Are you sure to delete?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 30),

                // Action Buttons
                Row(
                  children: [
                    // Delete Button (Red)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Perform Delete
                          setState(() {
                            cartItems.removeAt(index);
                          });
                          Navigator.of(context).pop(); // Close dialog
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE14544), // Your Red
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Cancel Button (Light Grey)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Just close
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFEEF1F4,
                          ), // Light bluish-grey from image
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCheckoutBottomSheet() {
    // Calculate total dynamically
    final double originalPrice = cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    const double discount = 10.0;
    final double total = originalPrice - discount;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        // 1. Get the system padding (Safe Area)
        final double bottomSafeArea = MediaQuery.of(context).padding.bottom;
        // 2. Get keyboard padding (in case user types in a field later)
        final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Padding(
          // 3. APPLY THE FIX HERE:
          // We add 'bottomSafeArea' so the content sits ABOVE the system bar.
          // We add 'keyboardHeight' so it moves up if a keyboard opens.
          // We add '20' for a little extra breathing room.
          padding: EdgeInsets.fromLTRB(
            24,
            30,
            24,
            keyboardHeight + bottomSafeArea + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- (Content remains exactly the same as before) ---
              Text(
                'DELIVERY ADDRESS',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F4FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '2118 Thornridge Cir. Syracuse',
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
              const SizedBox(height: 24),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    context.push(VoucherScreen());
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  label: const Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: Colors.black,
                  ),
                  icon: const Text(
                    'Add coupon',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Original:',
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),
                  Text(
                    '\$${originalPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount:',
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),
                  Text(
                    '\$${discount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL:',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Place Order
                    context.push(PaymentScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'PLACE ORDER',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryDarkColor = Color(0xFF13151A);

    return Scaffold(
      backgroundColor: primaryDarkColor,
      appBar: AppBar(
        backgroundColor: primaryDarkColor,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 16.0),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFF2A2A39),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.chevron_left_rounded, color: Colors.white),
            onPressed: () {
              context.pop();
            },
            splashRadius: 20,
          ),
        ),

        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _showCheckoutBottomSheet();
            },
            child: Text(
              'DONE',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child:
            cartItems.isEmpty
                ? const Center(
                  child: Text(
                    "Cart is empty",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: CartItemCard(
                        item: item,
                        // 2. Pass the dialog function here
                        onRemove: () => _showDeleteConfirmDialog(index),
                        onIncrease: () {
                          setState(() {
                            cartItems[index].quantity++;
                          });
                        },
                        onDecrease: () {
                          setState(() {
                            if (cartItems[index].quantity > 1) {
                              cartItems[index].quantity--;
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
      ),
    );
  }
}

// --- Cart Item Card (Unchanged, just ensuring correct context) ---
class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Side: Image
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            item.imageUrl,
            width: 148, // Adjusted size to match ratio better
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 100,
                height: 100,
                color: Colors.grey[800],
                child: const Icon(Icons.fastfood, color: Colors.white54),
              );
            },
          ),
        ),
        const SizedBox(width: 16.0),

        // Middle: Text Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${(item.price * item.quantity).toStringAsFixed(0)}',
                style: TextStyle(
                  color: Colors.white, // Green
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.size,
                style: TextStyle(color: Colors.grey[500], fontSize: 13),
              ),
            ],
          ),
        ),

        // Right Side: Quantity & Remove
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Remove Button
            InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Quantity Controls
            Row(
              children: [
                _QtyBtn(icon: Icons.remove, onTap: onDecrease),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _QtyBtn(icon: Icons.add, onTap: onIncrease),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: const Color(0xFF41414F),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}
