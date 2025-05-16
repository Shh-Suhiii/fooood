import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<Map<String, dynamic>> orderHistory = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    final url = Uri.parse('http://localhost:5002/cart-history');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          orderHistory = data.cast<Map<String, dynamic>>();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load order history');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.deepOrange,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderHistory.isEmpty
              ? const Center(child: Text('No orders found.'))
              : ListView.builder(
                  itemCount: orderHistory.length,
                  itemBuilder: (context, index) {
                    final order = orderHistory[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailScreen(order: order),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order['orderId'] ?? 'No ID',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Date: ${order['date'] ?? 'Unknown'}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: (order['status'] == 'Delivered')
                                          ? Colors.green.withOpacity(0.2)
                                          : Colors.orange.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      order['status'] ?? 'N/A',
                                      style: TextStyle(
                                        color: (order['status'] == 'Delivered') ? Colors.green : Colors.orange,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    order['total'] ?? '\$0.00',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> items = [];
    try {
      items = json.decode(order['items']);
    } catch (_) {}

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order['orderId'] ?? 'N/A'}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('Date: ${order['date'] ?? 'N/A'}'),
            Text('Status: ${order['status'] ?? 'N/A'}'),
            Text('Payment: ${order['payment_method'] ?? 'N/A'}'),
            Text('Address: ${order['address'] ?? 'N/A'}'),
            const SizedBox(height: 16),
            const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item['name'] ?? ''),
                    subtitle: Text('Quantity: ${item['quantity']}'),
                    trailing: Text('\$${item['price']}'),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
            const Divider(thickness: 1.2),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: Text('Total: ${order['total'] ?? '\$0.00'}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  List<dynamic> items = [];
                  try {
                    items = json.decode(order['items']);
                  } catch (_) {}

                  // Simulate reorder logic (e.g., add to cart or navigate with items)
                  print('Reordering items: $items');

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Items added to cart!')),
                  );

                  // Optionally navigate to cart screen or refresh cart state here
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reorder', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}