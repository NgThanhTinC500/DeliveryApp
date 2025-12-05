import 'package:DeliveryApp/nav_helper.dart';
import 'package:DeliveryApp/thanhtin/confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // 0: Cash, 1: Visa, 2: Mastercard, 3: PayPal
  int _selectedMethod = 2; // Default to Mastercard as seen in image
  
  // Card State
  bool _isCardExpanded = true;
  bool _isCardNumberVisible = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary; // Green
    
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
            icon: const Icon(Icons.chevron_left_rounded, color: Color(0xFF333647)),
            onPressed: () {
              context.pop();
            },
            splashRadius: 20,
          ),
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Payment Method Selector (Horizontal List)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MethodCard(
                    index: 0,
                    assetPath: 'assets/ic_cash.svg',
                    label: 'Cash',
                    isSelected: _selectedMethod == 0,
                    onTap: () => setState(() => _selectedMethod = 0),
                  ),
                  _MethodCard(
                    index: 1,
                    assetPath: 'assets/ic_visa.svg', // You need a visa logo asset
                    label: 'Visa',
                    isSelected: _selectedMethod == 1,
                    onTap: () => setState(() => _selectedMethod = 1),
                  ),
                  _MethodCard(
                    index: 2,
                    assetPath: 'assets/ic_mastercard_2.svg', // You need a mastercard logo asset
                    label: 'Master',
                    isSelected: _selectedMethod == 2,
                    onTap: () => setState(() => _selectedMethod = 2),
                  ),
                  _MethodCard(
                    index: 3,
                    assetPath: 'assets/ic_paypal.svg', // You need a paypal logo asset
                    label: 'PayPal',
                    isSelected: _selectedMethod == 3,
                    onTap: () => setState(() => _selectedMethod = 3),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 2. Dynamic Content Area
              Expanded(
                child: SingleChildScrollView(
                  child: _selectedMethod == 0 
                      ? _buildCashView() 
                      : _buildCreditCardView(),
                ),
              ),

              // 3. Bottom Total & Button
              Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('TOTAL:', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                      const Text('\$19.99', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Confirmation Screen
                        context.push(ConfirmationScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'PAY & CONFIRM',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- View: Cash Payment ---
  Widget _buildCashView() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cash Payment',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          _buildSummaryRow('Original price:', '\$34'),
          _buildSummaryRow('Discounted:', '\$4'),
          _buildSummaryRow('TAX:', '\$2'),
          _buildSummaryRow('VAT:', '\$3'),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOTAL:', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
              Text(
                '\$35', 
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 18
                )
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'You will have to give \$35 to the deliverer',
              style: TextStyle(color: Colors.grey[500], fontSize: 12, fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }

  // --- View: Credit Card (Visa/Mastercard) ---
  Widget _buildCreditCardView() {
    return Column(
      children: [
        // Dropdown Header
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF6F8FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading: SvgPicture.asset('assets/ic_mastercard_black.svg',height: 16, width: 16),
                title: const Text('Master card', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('💳 •••• •••• •••• 436'),
                trailing: IconButton(
                  icon: Icon(_isCardExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                  onPressed: () => setState(() => _isCardExpanded = !_isCardExpanded),
                ),
              ),
              
              // The Visual Card (Only shows if expanded)
              if (_isCardExpanded)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF8C00), Color(0xFFFF2200)], // Orange to Red
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Card Logo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset('assets/ic_mastercard.svg', width: 30, height: 30), // Placeholder for Mastercard logo
                            // Eye Icon to toggle number
                             InkWell(
                              onTap: () => setState(() => _isCardNumberVisible = !_isCardNumberVisible),
                              child: Icon(
                                _isCardNumberVisible ? Icons.visibility : Icons.visibility_off, 
                                color: Colors.white70
                              ),
                             ),
                          ],
                        ),
                        // Card Number
                        Text(
                          _isCardNumberVisible ? '3018 7459 2436' : '•••• •••• •••• 436',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        // Name and Expiry
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Owner:', style: TextStyle(color: Colors.white70, fontSize: 10)),
                                Text('DAO GIA BAO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Expire date:', style: TextStyle(color: Colors.white70, fontSize: 10)),
                                Text('10/2025', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Add New Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade200),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            icon: const Icon(Icons.add),
            label: const Text('ADD NEW', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  // Helper: Summary Row for Cash View
  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[500])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// --- Component: Method Selection Card ---
class _MethodCard extends StatelessWidget {
  final int index;
  final IconData? icon;
  final String? assetPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _MethodCard({
    required this.index,
    this.icon,
    this.assetPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Note: In a real app, replace Icons/Text with your Image.assets
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F8FA),
          borderRadius: BorderRadius.circular(12),
          border: isSelected 
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : null,
        ),
        child: Center(
          child: SvgPicture.asset(assetPath!, height: 30, width: 30,),
            // ^ If you don't have assets yet, this text is a fallback
        ),
      ),
    );
  }
}