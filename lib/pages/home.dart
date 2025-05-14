import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutterdelivery1/widget/food_category.dart';
import 'package:flutterdelivery1/widget/restaurant_card.dart';
import 'package:flutterdelivery1/widget/food_item_card.dart';
import 'package:flutterdelivery1/pages/profile.dart';
import 'package:flutterdelivery1/pages/settings.dart';
import 'package:flutterdelivery1/pages/wallet.dart';
import 'shopping_cart.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const Wallet(),
    const Profile(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.wallet),
                label: 'Wallet',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_circle),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.setting),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery to',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Current Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, size: 20),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
  icon: const Icon(Iconsax.notification, color: Colors.deepOrange),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationScreen()),
    );
  },
),

          IconButton(
            icon: const Icon(Iconsax.shopping_cart, color: Colors.deepOrange),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShoppingCartPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for restaurants or dishes...',
                        prefixIcon: const Icon(Iconsax.search_normal, color: Colors.deepOrange),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),

                // Food Categories
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: const [
                      FoodCategory(icon: Iconsax.shop, label: 'Restaurants', isActive: true),
                      FoodCategory(icon: Iconsax.cake, label: 'Desserts'),
                      FoodCategory(icon: Iconsax.coffee, label: 'Café'),
                      FoodCategory(icon: Iconsax.discount_shape, label: 'Offers'),
                    ],
                  ),
                ),

                // Popular Near You
                _buildSectionHeader(title: 'Popular Near You', onViewAll: () {}),

                SizedBox(
                  height: 230,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: const [
                      RestaurantCard(
                        name: 'Burger King',
                        rating: 4.5,
                        deliveryTime: '20-30 min',
                        imageUrl: 'assets/images/burger.png',
                      ),
                      SizedBox(width: 16),
                      RestaurantCard(
                        name: 'Pizza Hut',
                        rating: 4.2,
                        deliveryTime: '25-35 min',
                        imageUrl: 'assets/images/pizza.png',
                      ),
                      SizedBox(width: 16),
                      RestaurantCard(
                        name: 'Healthy Salad',
                        rating: 4.7,
                        deliveryTime: '30-40 min',
                        imageUrl: 'assets/images/salad2.png',
                      ),
                    ],
                  ),
                ),

                // Special Offers Banner
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/buy1get1free.png',
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // What Would You Like Today
                _buildSectionHeader(title: 'What would you like today?', onViewAll: () {}),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                    children: const [
                      FoodItemCard(
                        name: 'Cheese Burger',
                        price: '\₹50',
                        rating: 4.5,
                        imageUrl: 'assets/images/burger.png',
                      ),
                      FoodItemCard(
                        name: 'Veg Pizza',
                        price: '\₹149',
                        rating: 4.2,
                        imageUrl: 'assets/images/pizza.png',
                      ),
                      FoodItemCard(
                        name: 'Healthy Salad',
                        price: '\₹349',
                        rating: 4.3,
                        imageUrl: 'assets/images/salad2.png',
                      ),
                      FoodItemCard(
                        name: 'Fresh Salad',
                        price: '\₹120',
                        rating: 4.1,
                        imageUrl: 'assets/images/salad3.png',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required VoidCallback onViewAll}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            child: const Text(
              'View All',
              style: TextStyle(color: Colors.deepOrange),
            ),
          ),
        ],
      ),
    );
  }
}
