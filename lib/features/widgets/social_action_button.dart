// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class SocialActionButton extends StatelessWidget {
  final String title;
  final String iconPath; // Use SVG path or Asset image path
  final VoidCallback onTap;

  const SocialActionButton({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50, // Matching the standard button height
        width: MediaQuery.of(context).size.width * 0.4, // Responsive width
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25), // Pill shape
          border: Border.all(color: Colors.grey.withOpacity(0.2)), // Thin grey border
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04), // Very soft shadow
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centers icon and text together
          children: [
            // Icon section
            Image.asset(
              iconPath,
              height: 24, // Consistent icon size
              width: 24,
            ),
            
            const SizedBox(width: 10), // Space between icon and text
            
            // Text section
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600, // Matching your app's standard font weight
              ),
            ),
          ],
        ),
      ),
    );
  }
}