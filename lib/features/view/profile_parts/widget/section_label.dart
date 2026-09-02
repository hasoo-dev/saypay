import 'package:flutter/material.dart';
import 'package:saypay/core/theme/app_colors.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  final Color textColor;

  const SectionLabel({super.key, required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Lufga',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
