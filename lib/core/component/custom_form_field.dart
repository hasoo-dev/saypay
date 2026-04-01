import 'package:flutter/material.dart';
import 'package:saypay/core/utils/size_extension/size_ext.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  final bool isPassword; // This now just determines if it CAN be a password
  final TextEditingController? controller;
  final TextInputType keyword;
  final TextInputAction action;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.keyword = TextInputType.emailAddress,
    this.action = TextInputAction.next,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // 1. Create a private state variable
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // Initialize it based on whether it's a password field
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: TextFormField(
        controller: widget.controller,
        // 2. Use the state variable here
        validator: widget.validator,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        obscureText: _obscureText,
        textInputAction: widget.action,
        keyboardType: widget.keyword,
        keyboardAppearance: Brightness.dark,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Colors.grey.withValues(alpha: 0.6),
            fontSize: 14,
          ),
          prefixIcon: Icon(widget.prefixIcon, color: const Color(0xFF5A7363)),

          // 3. Add the toggle logic to the suffixIcon
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey.withValues(alpha: 0.5),
                  ),
                  onPressed: () {
                    // 4. Update the state to rebuild the UI
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 0.01.h,
            horizontal: 10,
          ),
        ),
      ),
    );
  }
}
