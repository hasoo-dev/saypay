// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UiUtils {
  static void showFlushbar(BuildContext? context, String message, {bool isError = true}) {
    Get.snackbar(
      isError ? "Error" : "Success",
      message,
      
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.redAccent.withOpacity(0.8) : const Color(0xFFC4EF62).withOpacity(0.9), // Using brand color for success
      colorText: isError ? Colors.white : Colors.black,
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: isError ? Colors.white : Colors.black,
      ),
      margin: const EdgeInsets.all(15),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

}