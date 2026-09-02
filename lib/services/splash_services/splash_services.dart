import 'dart:async';
import 'package:flutter/material.dart';
import 'package:saypay/core/routes/routes_constant.dart';
import 'package:get/get.dart';

import '../session_controller/session_controller.dart';
import '../storage/local_storage.dart' show LocalStorage;
 

class SplashServices {
  final LocalStorage _storage = LocalStorage();
  final SessionController _sessionController = Get.find<SessionController>();

  void navigateToNextScreen(BuildContext context) async {
    // 1. Initialize the session (Sync storage to memory)
    await _sessionController.getUserFromPreference();

    // 2. Read Onboarding status
    String? isFirstTime = await _storage.readValue('isFirstTime');

    // 3. Professional Delay (Matches your image_3f1100.png splash aesthetic)
    Timer(const Duration(seconds: 4), () {
      if (context.mounted) {
        if (isFirstTime == null || isFirstTime == 'true') {
          // New user -> Onboarding
          Navigator.pushReplacementNamed(context, RoutesConstant.onBoard);
        } else {
          // Returning user -> Check if logged in
          if (SessionController.isLogin == true) {
            Navigator.pushReplacementNamed(context, RoutesConstant.main);
          } else {
            Navigator.pushReplacementNamed(context, RoutesConstant.login);
          }
        }
      }
    });
  }
}