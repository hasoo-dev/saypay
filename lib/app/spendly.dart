// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saypay/core/routes/routes.dart';
import 'package:saypay/core/routes/routes_constant.dart';
import 'package:saypay/core/theme/theme.dart';

import '../core/const/app_binding.dart';

class Spendly extends StatelessWidget {
  const Spendly({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Spendly",

      // Theme Configuration
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: AppBinding(),

      // Routing Configuration (The GetX Way)
      initialRoute: RoutesConstant.splash,
      getPages: AppRoutes.routes, // This replaces onGenerateRoute
      // Default transition for a premium feel
      defaultTransition: Transition.fadeIn,
    );
  }
}
