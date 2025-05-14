import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:iconsax/iconsax.dart';

class FoodCategory extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const FoodCategory({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isActive 
                  ? Colors.deepOrange.withOpacity(0.2) 
                  : Colors.deepOrange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: isActive 
                  ? Border.all(color: Colors.deepOrange, width: 2) 
                  : null,
            ),
            child: Icon(
              icon,
              size: 30,
              color: isActive 
                  ? Colors.deepOrange 
                  : Colors.deepOrange.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.deepOrange : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}