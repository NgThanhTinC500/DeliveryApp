import 'package:DeliveryApp/nav_helper.dart';
import 'package:flutter/material.dart';

// --- Data Model for Voucher ---
class Voucher {
  final String id;
  final String title;
  final String code;
  final String description;
  final String expiry;
  final int quantityLeft;
  bool isSelected;

  Voucher({
    required this.id,
    required this.title,
    required this.code,
    required this.description,
    required this.expiry,
    required this.quantityLeft,
    this.isSelected = false,
  });
}

// --- Main Screen ---
class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  // Controller for the input field
  final TextEditingController _codeController = TextEditingController();

  // Dummy Data matching the screenshot
  final List<Voucher> vouchers = [
    Voucher(
      id: '1',
      title: 'Freeship',
      code: 'ADSDSKDASO',
      description: '20,000 VND discount on conversion fee',
      expiry: '3 days',
      quantityLeft: 10,
      isSelected: true, // First one selected by default for demo
    ),
    Voucher(
      id: '2',
      title: 'Freeship',
      code: 'ADSDSKDASO',
      description: '20,000 VND discount on conversion fee',
      expiry: '3 days',
      quantityLeft: 10,
      isSelected: false,
    ),
    Voucher(
      id: '3',
      title: 'Freeship',
      code: 'ADSDSKDASO',
      description: '20,000 VND discount on conversion fee',
      expiry: '3 days',
      quantityLeft: 10,
      isSelected: false,
    ),
    Voucher(
      id: '4',
      title: 'Freeship',
      code: 'ADSDSKDASO',
      description: '20,000 VND discount on conversion fee',
      expiry: '3 days',
      quantityLeft: 10,
      isSelected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Access global theme colors
    final primaryColor = Theme.of(context).colorScheme.primary; // Green
    final redColor = Theme.of(context).colorScheme.error; // Red

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text(
          'APPLY VOUCHER',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Input Field Row
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _codeController,
                            decoration: InputDecoration(
                              hintText: 'Please enter voucher code',
                              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            // Handle Apply Logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          ),
                          child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 2. Section Title
                    const Text(
                      'Voucher available',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Please choose 1 voucher',
                      style: TextStyle(color: Colors.grey[500], fontSize: 13),
                    ),
                    const SizedBox(height: 16),

                    // 3. Voucher List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: vouchers.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final voucher = vouchers[index];
                        return _VoucherCard(
                          voucher: voucher,
                          primaryColor: primaryColor,
                          redColor: redColor,
                          onTap: () {
                            setState(() {
                              // Deselect others, select this one (Radio behavior)
                              for (var v in vouchers) {
                                v.isSelected = false;
                              }
                              voucher.isSelected = true;
                            });
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    // 4. Show More
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Show more',
                            style: TextStyle(color: Colors.black87, fontSize: 14),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black87),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20), // Spacer before bottom button
                  ],
                ),
              ),
            ),

            // 5. Bottom OK Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                     // Return result to previous screen
                     context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Component: Voucher Card ---
class _VoucherCard extends StatelessWidget {
  final Voucher voucher;
  final Color primaryColor;
  final Color redColor;
  final VoidCallback onTap;

  const _VoucherCard({
    required this.voucher,
    required this.primaryColor,
    required this.redColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            // Green border if selected or default green as shown in image
            color: primaryColor.withOpacity(0.6), 
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Side: Image/Icon
            // Since I don't have the exact truck asset, I'll build a placeholder
            Column(
              children: [
                 Container(
                  width: 50, height: 40,
                  alignment: Alignment.center,
                  child: Icon(Icons.local_shipping, color: redColor, size: 30),
                 ),
                 Text(
                   'Freeship',
                   style: TextStyle(
                     color: redColor,
                     fontWeight: FontWeight.bold,
                     fontSize: 10,
                   ),
                 )
              ],
            ),
            const SizedBox(width: 12),

            // Middle: Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row with 'x10' Badge
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'Poppins'),
                            children: [
                              const TextSpan(text: 'Enter '),
                              TextSpan(
                                text: '"${voucher.code}"', 
                                style: const TextStyle(fontWeight: FontWeight.bold)
                              ),
                              TextSpan(
                                text: ': ${voucher.description}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'x${voucher.quantityLeft}',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Limited Offer
                  Text(
                    'Limited offer',
                    style: TextStyle(color: redColor, fontSize: 11),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Expiry
                  Text(
                    'Expires in: ${voucher.expiry}',
                    style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Condition Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Condition',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Right: Radio Button
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: voucher.isSelected ? primaryColor : Colors.grey,
                    width: 2,
                  ),
                  color: voucher.isSelected ? primaryColor : Colors.transparent,
                ),
                child: voucher.isSelected
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}