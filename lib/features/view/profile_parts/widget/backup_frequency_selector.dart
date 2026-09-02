import 'package:flutter/material.dart';
import 'package:saypay/core/theme/app_colors.dart';

class BackupFrequencyOption {
  final String label;
  final String description;
  final String value;

  const BackupFrequencyOption({
    required this.label,
    required this.description,
    required this.value,
  });
}

class BackupFrequencySelector extends StatelessWidget {
  final List<BackupFrequencyOption> options;
  final String selectedFrequency;
  final ValueChanged<String> onFrequencySelected;
  final Color surface;
  final Color textColor;
  final Color subText;

  const BackupFrequencySelector({
    super.key,
    required this.options,
    required this.selectedFrequency,
    required this.onFrequencySelected,
    required this.surface,
    required this.textColor,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        final selected = selectedFrequency == option.value;
        return GestureDetector(
          onTap: () => onFrequencySelected(option.value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: selected ? AppColors.primary.withOpacity(0.1) : surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected
                    ? AppColors.primary.withOpacity(0.5)
                    : Colors.transparent,
                width: 1.5,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : subText.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.label,
                        style: TextStyle(
                          fontFamily: 'Lufga',
                          fontSize: 14,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w600,
                          color: selected ? AppColors.primary : textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        option.description,
                        style: TextStyle(
                          fontFamily: 'Lufga',
                          fontSize: 12,
                          color: subText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
