import 'package:flutter/material.dart';

class FormatOption {
  final String label;
  final IconData icon;
  final Color color;

  const FormatOption({
    required this.label,
    required this.icon,
    required this.color,
  });
}

class ExportFormatCard extends StatelessWidget {
  final List<FormatOption> formats;
  final int selectedFormat;
  final ValueChanged<int> onFormatSelected;
  final Color surface;
  final Color textColor;

  const ExportFormatCard({
    super.key,
    required this.formats,
    required this.selectedFormat,
    required this.onFormatSelected,
    required this.surface,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(formats.length, (i) {
        final f = formats[i];
        final selected = selectedFormat == i;
        return Expanded(
          child: GestureDetector(
            onTap: () => onFormatSelected(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(right: i < formats.length - 1 ? 12 : 0),
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: selected ? f.color.withOpacity(0.12) : surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: selected ? f.color : Colors.transparent,
                  width: 2,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: f.color.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selected ? f.color : f.color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      f.icon,
                      color: selected ? Colors.white : f.color,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    f.label,
                    style: TextStyle(
                      fontFamily: 'Lufga',
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      color: selected ? f.color : textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
