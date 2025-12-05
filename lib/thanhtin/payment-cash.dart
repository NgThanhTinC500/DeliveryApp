import 'package:flutter/material.dart';
import 'package:DeliveryApp/thanhtin/confirm.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Màu sắc chủ đạo
  final Color primaryGreen = const Color(0xFF5ABF16); // Màu xanh giống trong ảnh
  final Color bgGrey = const Color(0xFFF6F7FB);
  final Color textDark = const Color(0xFF1A1A1A);

  // Trạng thái đang chọn phương thức nào (0: Cash, 1: Visa, 2: MasterCard, 3: PayPal)
  int _selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
              _buildHeader(),
              const SizedBox(height: 30),

              // 2. Payment Methods List
              _buildPaymentMethods(),
              const SizedBox(height: 30),

              // 3. Payment Details Card
              _buildDetailsCard(),

              // Spacer đẩy nút xuống cuối màn hình
              const Spacer(),

              // 4. Pay Button
              _buildPayButton(),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets con ---

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F8),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
        ),
        const SizedBox(width: 20),
        Text(
          "Payment",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textDark
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    // Danh sách icon/logo (Dùng URL ảnh mẫu logo thật)
    final List<Map<String, dynamic>> methods = [
      {'type': 'icon', 'data': Icons.money}, // Cash dùng Icon
      {'type': 'img', 'data': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png'},
      {'type': 'img', 'data': 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png'},
      {'type': 'img', 'data': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/PayPal.svg/1200px-PayPal.svg.png'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(methods.length, (index) {
        return _buildMethodItem(index, methods[index]);
      }),
    );
  }

  Widget _buildMethodItem(int index, Map<String, dynamic> method) {
    bool isSelected = _selectedMethod == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = index;
        });
      },
      child: SizedBox(
        width: 75,
        height: 70, // Cố định kích thước để vùng badge không bị cắt
        child: Stack(
          children: [
            // Ô chứa chính
            Positioned(
              top: 5,
              left: 0,
              right: 5,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : const Color(0xFFF6F8FC),
                  borderRadius: BorderRadius.circular(15),
                  border: isSelected
                      ? Border.all(color: primaryGreen, width: 2)
                      : Border.all(color: Colors.transparent),
                ),
                padding: const EdgeInsets.all(12),
                child: method['type'] == 'icon'
                    ? Icon(method['data'], color: isSelected ? primaryGreen : Colors.grey, size: 30)
                    : Image.network(method['data'], fit: BoxFit.contain),
              ),
            ),

            // Dấu tích xanh (Badge) chỉ hiện khi được chọn
            if (isSelected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: primaryGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, size: 12, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: bgGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedMethod == 0 ? "Cash Payment" : "Card Payment",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textDark
            ),
          ),
          const SizedBox(height: 20),
          _buildPriceRow("Original price:", "\$34"),
          _buildPriceRow("Discounted:", "\$4"), // Trong ảnh ghi $4, thường là -$4 nhưng mình theo ảnh
          _buildPriceRow("TAX:", "\$2"),
          _buildPriceRow("VAT:", "\$3"),
          const SizedBox(height: 15),
          const Divider(thickness: 1, color: Colors.black12),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOTAL:",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              Text(
                "\$35",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              _selectedMethod == 0
                  ? "You will have to give \$35 to the deliverer"
                  : "Payment will be deducted from your account",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[500],
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 15, color: Colors.grey[500]),
          ),
          Text(
            price,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: textDark),
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          // --- CODE CHUYỂN MÀN HÌNH ---
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ConfirmationScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: const Text(
          "PAY & CONFIRM",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}