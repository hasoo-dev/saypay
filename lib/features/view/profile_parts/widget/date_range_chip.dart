import 'package:flutter/material.dart';
import 'package:saypay/core/theme/app_colors.dart';

class DateRangeChip extends StatelessWidget {
  final List<String> dateRanges;
  final String selectedRange;
  final ValueChanged<String> onRangeSelected;

  const DateRangeChip({
    super.key,
    required this.dateRanges,
    required this.selectedRange,
    required this.onRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: dateRanges.map((r) {
        final selected = selectedRange == r;
        return GestureDetector(
          onTap: () => onRangeSelected(r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(30),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Text(
              r,
              style: TextStyle(
                fontFamily: 'Lufga',
                fontSize: 13,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? Colors.white : AppColors.primary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
