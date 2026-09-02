import 'package:flutter/material.dart';
import 'package:saypay/core/theme/app_colors.dart';

class ExportButton extends StatelessWidget {
  final bool isExporting;
  final int selectedCount;
  final String format;
  final VoidCallback onPressed;

  const ExportButton({
    super.key,
    required this.isExporting,
    required this.selectedCount,
    required this.format,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: selectedCount == 0 ? null : onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 58,
          decoration: BoxDecoration(
            gradient: selectedCount == 0
                ? const LinearGradient(
                    colors: [Color(0xFFCCCCCC), Color(0xFFAAAAAA)],
                  )
                : const LinearGradient(
                    colors: [AppColors.primary, Color(0xFFFFB347)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: selectedCount > 0
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.45),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: isExporting
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.file_download_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        selectedCount == 0
                            ? 'Select at least one type'
                            : 'Export $format File',
                        style: const TextStyle(
                          fontFamily: 'Lufga',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
