import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'payment_screen.dart';

class TopupScreen extends StatefulWidget {
  const TopupScreen({super.key});

  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  final TextEditingController _emailController = TextEditingController();
  String gameId = '1234567890';
  String serverId = '20024';

  // Selected diamond package
  String? selectedPackage;

  // Diamond icon URL
  final String diamondIconUrl =
      'https://play-lh.googleusercontent.com/JMA0M9SRX3l9-Y1lEhJP4vyY1P6Wa-C1VCS4aFCcMB-_gM4JpaNgU-EijYc9aPvs19T0=w240-h480-rw';

  List<DiamondPackage> diamondPackages = [
    DiamondPackage(amount: 200, price: 50000),
    DiamondPackage(amount: 255, price: 65000),
    DiamondPackage(amount: 300, price: 75000),
    DiamondPackage(amount: 105, price: 30000),
    DiamondPackage(amount: 990, price: 220000),
    DiamondPackage(amount: 180, price: 45000),
    DiamondPackage(amount: 806, price: 180000),
    DiamondPackage(amount: 650, price: 150000),
  ];

  bool isEmailValid(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2B),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App bar with profile icon
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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

              // Banner section
              Row(
                children: [
                  // Purple banner on the left
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF00AA), Color(0xFF9900FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Opacity(
                              opacity: 0.4,
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://www.trustedreviews.com/wp-content/uploads/sites/54/2023/04/Mobile-Legends-Bang-Bang-Hero.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                placeholder:
                                    (context, url) => Container(
                                      color: Colors.purple.shade900,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                errorWidget:
                                    (context, url, error) => Container(
                                      color: Colors.purple.shade900,
                                      child: const Icon(
                                        Icons.error,
                                        color: Colors.white,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'AFFORDABLE TRUSTED TOP-UP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'MAGESTORE27',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Orange banner on the right
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2994A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'NOW OPEN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'TO SERVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ID GAME Section
              const Text(
                'GAME ID',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Game ID and Server ID
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Game ID',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        gameId,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: Colors.grey),

              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Server ID',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        serverId,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Diamond packages grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3.5,
                ),
                itemCount: diamondPackages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPackage =
                            diamondPackages[index].amount.toString();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            selectedPackage ==
                                    diamondPackages[index].amount.toString()
                                ? const Color(0xFF2A2D3E)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF2A2D3E),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: diamondIconUrl,
                            width: 24,
                            height: 24,
                            placeholder:
                                (context, url) => const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => const Icon(
                                  Icons.diamond,
                                  color: Colors.blue,
                                  size: 24,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            diamondPackages[index].amount.toString(),
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
                },
              ),

              const SizedBox(height: 20),

              // Email input
              const Text(
                'Enter your email',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),

              const SizedBox(height: 8),

              // Email TextField
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2D3E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'email@example.com',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: _processTopUp,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  onSubmitted: (value) {
                    _processTopUp();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processTopUp() {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your email')));
      return;
    }

    if (!isEmailValid(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email')),
      );
      return;
    }

    if (selectedPackage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a diamond package')),
      );
      return;
    }

    // Find the selected package
    DiamondPackage package = diamondPackages.firstWhere(
      (pkg) => pkg.amount.toString() == selectedPackage,
      orElse: () => DiamondPackage(amount: 0, price: 0),
    );

    // Navigate to payment screen instead of showing a dialog
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PaymentScreen(
              email: _emailController.text,
              gameId: gameId,
              serverId: serverId,
              diamonds: package.amount,
              price:
                  package.price /
                  1000, // Convert to display format (Rs. instead of Rp.)
            ),
      ),
    );
  }
}

class DiamondPackage {
  final int amount;
  final int price;

  DiamondPackage({required this.amount, required this.price});
}
