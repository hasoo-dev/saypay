// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegistrationSuccessSheet extends StatelessWidget {
  const RegistrationSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFC4EF62).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Color(0xFF5A7363),
              size: 50,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Registration Complete!",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Your account has been successfully established. You are now ready to experience the full potential of Spendly’s intelligent expense tracking and financial insights.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black.withOpacity(0.6),
                  height: 1.5,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                Get.back(); // Close bottom sheet
               // Go to login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF4F4B7),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Proceed to Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
