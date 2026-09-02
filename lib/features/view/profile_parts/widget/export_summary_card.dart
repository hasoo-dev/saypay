import 'package:flutter/material.dart';
import 'package:saypay/core/theme/app_colors.dart';

class ExportSummaryCard extends StatelessWidget {
  final String format;
  final String period;
  final int selectedCount;
  final Color surface;
  final Color textColor;
  final Color subText;

  const ExportSummaryCard({
    super.key,
    required this.format,
    required this.period,
    required this.selectedCount,
    required this.surface,
    required this.textColor,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.15),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Export Summary',
                style: TextStyle(
                  fontFamily: 'Lufga',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _summaryRow('Format', format, AppColors.primary, subText),
          const SizedBox(height: 8),
          _summaryRow('Period', period, AppColors.accent, subText),
          const SizedBox(height: 8),
          _summaryRow(
            'Data Types',
            '$selectedCount categories selected',
            const Color(0xFF8E24AA),
            subText,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, Color dot, Color subText) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(fontFamily: 'Lufga', fontSize: 13, color: subText),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Lufga',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
