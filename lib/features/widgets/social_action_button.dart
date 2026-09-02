// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:saypay/core/utils/size_extension/size_ext.dart';

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
        height: 60, // Matching the standard button height
        width: MediaQuery.of(context).size.width * 0.67, // Responsive width
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
           // Pill shape
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ), // Thin grey border
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04), // Very soft shadow
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers icon and text together
          children: [
            Text(
              "Sign In With $title",
              style:  TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight:
                    FontWeight.w400, // Matching your app's standard font weight
              ),
            ),
            const SizedBox(width: 10), // Space between icon and text
            // Icon section
            Image.asset(
              iconPath,
              height: 34, // Consistent icon size
              width: 34,
            ),

            const SizedBox(width: 10), // Space between icon and text

            // Text section
          ],
        ),
      ),
    );
  }
}
