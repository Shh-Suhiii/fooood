import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Order Shipped',
        'message': 'Your order from Burger King is on the way!',
        'icon': Icons.local_shipping,
        'time': '5 min ago',
      },
      {
        'title': 'Exclusive Offer',
        'message': 'Get 30% off on your next Pizza order.',
        'icon': Iconsax.discount_shape,
        'time': '1 hour ago',
      },
      {
        'title': 'Healthy Choice',
        'message': 'Try our new Fresh Salad at ₹99 only!',
        'icon': Iconsax.cake5,
        'time': '3 hours ago',
      },
      {
        'title': 'Welcome!',
        'message': 'Thanks for joining Foodie! Start ordering now.',
        'icon': Icons.celebration,
        'time': 'Yesterday',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepOrange),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notifications', style: TextStyle(color: Colors.deepOrange)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                backgroundColor: Colors.deepOrange.withOpacity(0.1),
                child: Icon(notification['icon'], color: Colors.deepOrange),
              ),
              title: Text(
                notification['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification['message']),
                  const SizedBox(height: 4),
                  Text(
                    notification['time'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
