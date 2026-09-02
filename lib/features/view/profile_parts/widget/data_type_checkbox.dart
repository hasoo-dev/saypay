import 'package:flutter/material.dart';
import 'package:saypay/core/theme/app_colors.dart';

class DataTypeCheckbox extends StatelessWidget {
  final Map<String, bool> dataTypes;
  final ValueChanged<String> onDataTypeToggled;
  final Color surface;
  final Color textColor;
  final Color subText;

  const DataTypeCheckbox({
    super.key,
    required this.dataTypes,
    required this.onDataTypeToggled,
    required this.surface,
    required this.textColor,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    final entries = dataTypes.entries.toList();
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: entries.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.8,
      ),
      itemBuilder: (_, i) {
        final key = entries[i].key;
        final enabled = entries[i].value;
        return GestureDetector(
          onTap: () => onDataTypeToggled(key),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: enabled ? AppColors.primary.withOpacity(0.1) : surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: enabled
                    ? AppColors.primary.withOpacity(0.5)
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: enabled ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: enabled
                          ? AppColors.primary
                          : subText.withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  child: enabled
                      ? const Icon(
                          Icons.check_rounded,
                          size: 13,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    key,
                    style: TextStyle(
                      fontFamily: 'Lufga',
                      fontSize: 13,
                      fontWeight: enabled ? FontWeight.w600 : FontWeight.w400,
                      color: enabled ? textColor : subText,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
