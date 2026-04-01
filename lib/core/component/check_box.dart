import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final String label;
  final Function(bool) onChanged;
  final bool initialState;

  const CustomCheckbox({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialState = false,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialState;
  }

  @override
  void didUpdateWidget(covariant CustomCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialState != oldWidget.initialState) {
      isChecked = widget.initialState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onChanged(isChecked);
      },
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: isChecked
                  ? const Color.fromARGB(255, 244, 244, 183)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isChecked
                    ? const Color.fromARGB(255, 244, 244, 183)
                    : Colors.grey.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: isChecked
                ? const Icon(Icons.check, color: Colors.blueGrey, size: 16)
                : null,
          ),
          const SizedBox(width: 5),
          Text(
            widget.label,
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
