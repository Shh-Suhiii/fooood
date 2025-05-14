import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  double _balance = 100.00;
  final List<Map<String, dynamic>> _transactions = [
    {
      'type': 'Top-up',
      'amount': 50.00,
      'date': 'Today, 10:30 AM',
      'icon': Iconsax.wallet_add,
      'color': Colors.green,
    },
    {
      'type': 'Food Order',
      'amount': -25.50,
      'date': 'Yesterday, 7:45 PM',
      'icon': Iconsax.shop,
      'color': Colors.deepOrange,
    },
    {
      'type': 'Cashback',
      'amount': 5.00,
      'date': 'Yesterday, 7:50 PM',
      'icon': Iconsax.gift,
      'color': Colors.blue,
    },
    {
      'type': 'Food Order',
      'amount': -32.75,
      'date': 'May 10, 12:30 PM',
      'icon': Iconsax.shop,
      'color': Colors.deepOrange,
    },
    {
      'type': 'Top-up',
      'amount': 100.00,
      'date': 'May 8, 9:15 AM',
      'icon': Iconsax.wallet_add,
      'color': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Wallet'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.setting),
            onPressed: () {
              // Navigate to wallet settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Balance Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Available Balance',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '₹${_balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Add Money Button
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add money functionality
                            },
                            icon: const Icon(Iconsax.add, size: 20),
                            label: const Text('Add Money'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                          // Withdraw Button
                          OutlinedButton.icon(
                            onPressed: () {
                              // Withdraw functionality
                            },
                            icon: const Icon(Iconsax.money_send, size: 20),
                            label: const Text('Withdraw'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.deepOrange,
                              side: const BorderSide(color: Colors.deepOrange),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Recent Transactions Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // View all transactions
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
            ),

            // Transactions List
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _transactions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: transaction['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      transaction['icon'],
                      color: transaction['color'],
                    ),
                  ),
                  title: Text(
                    transaction['type'],
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    transaction['date'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    '₹${transaction['amount'].toStringAsFixed(2)}',
                    style: TextStyle(
                      color: transaction['amount'] > 0
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
