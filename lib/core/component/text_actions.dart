import 'package:flutter/material.dart';

class TextActions extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final Color background;
  final Color titleColor;
  final double fontSize;
  final FontWeight weight;
  final VoidCallback? onTap; // Added to handle button clicks

  const TextActions({
    super.key,
    this.background = Colors.black,
    required this.title,
    this.titleColor =
        Colors.white, // Changed default to white for black background
    this.fontSize = 16, // Slightly larger for main buttons
    this.weight = FontWeight.w600,
    this.height = 56, // Standard button height
    this.width = double.infinity, // Full width by default
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center, // Centers the text inside the button
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(
            45,
          ), // Matching your TextField radius
          boxShadow: [
            if (background != Colors.transparent)
              BoxShadow(
                color: background.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: titleColor,
            fontSize: fontSize,
            fontWeight: weight,
          ),
        ),
      ),
    );
  }
}
