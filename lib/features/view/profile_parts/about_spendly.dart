// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_constant.dart';
import '../../../core/utils/size_extension/size_ext.dart';
 

class AboutSpendly extends StatefulWidget {
  const AboutSpendly({super.key});

  @override
  State<AboutSpendly> createState() => _AboutSpendlyState();
}

class _AboutSpendlyState extends State<AboutSpendly> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              0.03.vSpace,
              // App Logo
              Container(
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.15),
                    width: 2,
                  ),
                ),
                child: Image.asset(
                  AppConstant.logo,
                  fit: BoxFit.contain,
                ),
              ),
              0.03.vSpace,
              
              // App Name
              Text(
                AppConstant.appName,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  letterSpacing: -0.5,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 6),
              
              // App Version
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Version 1.0.0",
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              0.04.vSpace,
              
              // Description
              Text(
                "Spendly is an AI-powered expense tracker designed to help you take full control of your money. Effortlessly say your expenses out loud, and we will intelligently log and categorize them for you.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.grey.shade600,
                ),
              ),
              0.05.vSpace,
              
              // Action Links
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     "Legal & Support",
              //     style: theme.textTheme.titleMedium?.copyWith(
              //       fontWeight: FontWeight.bold,
              //       color: Colors.black87,
              //     ),
              //   ),
              // ),
              // 0.02.vSpace,
              
              // ProfileMenuItem(
              //   icon: Icons.privacy_tip_outlined,
              //   title: "Privacy Policy",
              //   iconColor: Colors.blue.shade600,
              //   onTap: () {},
              // ),
              // ProfileMenuItem(
              //   icon: Icons.description_outlined,
              //   title: "Terms of Service",
              //   iconColor: Colors.teal.shade600,
              //   onTap: () {},
              // ),
              // ProfileMenuItem(
              //   icon: Icons.support_agent_rounded,
              //   title: "Contact Support",
              //   iconColor: Colors.orange.shade600,
              //   onTap: () {},
              // ),
              // ProfileMenuItem(
              //   icon: Icons.star_border_rounded,
              //   title: "Rate on App Store",
              //   iconColor: Colors.amber.shade500,
              //   onTap: () {},
              // ),
              
              0.06.vSpace,
              // Footer signature
              Text(
                "Made with ♥ by HasooDev",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              0.03.vSpace,
            ],
          ),
        ),
      ),
    );
  }
}