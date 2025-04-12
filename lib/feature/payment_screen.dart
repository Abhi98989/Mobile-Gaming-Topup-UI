import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PaymentScreen extends StatefulWidget {
  final String email;
  final String gameId;
  final String serverId;
  final int diamonds;
  final double price;

  const PaymentScreen({
    super.key,
    required this.email,
    required this.gameId,
    required this.serverId,
    required this.diamonds,
    required this.price,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String? selectedPaymentMethod;
  String selectedCountryCode = '+977'; // Default to Nepal

  final List<CountryCode> countryCodes = [
    CountryCode(code: '+977', country: 'Nepal'),
    CountryCode(code: '+91', country: 'India'),
    CountryCode(code: '+1', country: 'USA'),
    CountryCode(code: '+44', country: 'UK'),
    CountryCode(code: '+62', country: 'Indonesia'),
    CountryCode(code: '+65', country: 'Singapore'),
  ];

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: 'esewa',
      name: 'eSewa',
      imageUrl: 'https://esewa.com.np/common/images/esewa_logo.png',
    ),
    PaymentMethod(
      id: 'khalti',
      name: 'Khalti',
      imageUrl: 'https://khalti.com/static/images/khalti-logo.png',
    ),
    PaymentMethod(
      id: 'mobilebanking',
      name: 'Mobile Banking',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJmQ2eLlRtEr6jN8buRF41J-YXI-K7NQ0o5vRl40s5VA&s',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with first payment method selected
    selectedPaymentMethod = paymentMethods[0].id;
    // Clear phone controller
    _phoneController.text = '';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _showOrderDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF1F1D2B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Order Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please check your order details before proceeding',
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildDetailRow('Username:', 'Legacy'),
                _buildDetailRow('Email:', widget.email),
                _buildDetailRow('Item name:', '${widget.diamonds} diamonds'),
                _buildDetailRow(
                  'Item amount:',
                  'Rs. ${widget.price.toStringAsFixed(0)},000.00',
                ),
                _buildDetailRow('Payment method:', selectedPaymentMethod ?? ''),
                _buildDetailRow(
                  'Phone:',
                  '$selectedCountryCode ${_phoneController.text}',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _processPayment();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FF88),
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _processPayment() {
    if (_phoneController.text.length < 7) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    if (selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2D3E),
          title: const Text(
            'Payment Successful',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Game ID: ${widget.gameId}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Diamonds: ${widget.diamonds}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Amount: Rs. ${widget.price.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Phone: $selectedCountryCode ${_phoneController.text}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Payment Method: $selectedPaymentMethod',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to previous screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double formattedPrice = widget.price;
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2B),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with back button and profile icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.green),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Payment Method Title
                const Text(
                  'Payment Method',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                // Payment Methods List
                Column(
                  children:
                      paymentMethods
                          .map((method) => _buildPaymentMethodItem(method))
                          .toList(),
                ),
                const SizedBox(height: 24),
                // Phone Number Input
                const Text(
                  'Enter your phone number',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                // Country Code Dropdown and Phone Number TextField
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Country Code Dropdown
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2D3E),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF2A2D3E),
                          width: 1,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            value: selectedCountryCode,
                            dropdownColor: const Color(0xFF2A2D3E),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            style: const TextStyle(color: Colors.white),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCountryCode = newValue!;
                              });
                            },
                            items:
                                countryCodes.map<DropdownMenuItem<String>>((
                                  CountryCode code,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: code.code,
                                    child: Text(code.code),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Phone Number TextField
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2D3E),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF2A2D3E),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _phoneController,
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9\- ]'),
                            ),
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            hintText: '9876543210',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                          onSubmitted: (_) => _showOrderDetails(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Item Summary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Item',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      '${widget.diamonds} diamonds',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Amount Summary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Amount',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Row(
                      children: [
                        Text(
                          'Rs. ${formattedPrice.toStringAsFixed(0)},000.00',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.loop, color: Colors.teal, size: 20),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Pay Now Button
                ElevatedButton(
                  onPressed: _showOrderDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FF88),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Footer text
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'As an official Top Up partner for Mobile Legends: Bang Bang, Magestore27 offers secure, easy, and affordable Top Up services. First-time users can receive coupon packages from "Welcome Gifts".',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodItem(PaymentMethod method) {
    final bool isSelected = selectedPaymentMethod == method.id;
    final formattedPrice = widget.price.toStringAsFixed(0);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method.id;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF00FF88), width: 1),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? const Color(0xFF2A2D3E) : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(4),
                    child: CachedNetworkImage(
                      imageUrl: method.imageUrl,
                      width: 60,
                      height: 30,
                      fit: BoxFit.contain,
                      placeholder:
                          (context, url) => const SizedBox(
                            width: 60,
                            height: 30,
                            child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => Text(
                            method.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Rs. $formattedPrice,000',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethod {
  final String id;
  final String name;
  final String imageUrl;
  PaymentMethod({required this.id, required this.name, required this.imageUrl});
}

class CountryCode {
  final String code;
  final String country;
  CountryCode({required this.code, required this.country});
}
