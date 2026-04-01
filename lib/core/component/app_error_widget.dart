import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;

  const AppErrorWidget({
    super.key,
    this.title = 'Something went wrong',
    required this.message,
    this.onRetry,
  });

  static void show({String? title, required String message, VoidCallback? onRetry}) {
    Get.snackbar(
      title ?? 'Error',
      message,
      backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
      colorText: Colors.red[900],
      icon: Icon(Icons.error_outline, color: Colors.red[900]),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(15),
      borderRadius: 15,
      duration: const Duration(seconds: 4),
      mainButton: onRetry != null 
          ? TextButton(onPressed: onRetry, child: const Text('RETRY')) 
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ],
      ),
    );
  }
}
