import 'package:flutter/material.dart';
import 'custom_search_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',  // Change this path to your actual asset
            height: 32,
          ),
          const SizedBox(width: 12),
          const Text(
            'Notes',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,

            ),
          ),
          const Spacer(),
          const CustomSearchIcon(),
        ],
      ),
    );
  }
}
