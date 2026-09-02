// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Added GetX import
import 'package:saypay/features/widgets/login_form.dart';
import 'package:saypay/features/widgets/register_form.dart';
import 'package:saypay/core/const/app_constant.dart';
import '../../../core/component/loading_loader.dart';
import '../../../services/auth_services.dart/auth_services.dart';
// Added AuthService import

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  // Access the controller
  final authController = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Obx(
        () => Stack(
          children: [
            // YOUR ORIGINAL CODE STARTS HERE
            Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(AppConstant.logo, height: 78),
                          Text(
                            "Go ahead and set up your account",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryFixed,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Sign in-up to enjoy the spenblyy experience",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryFixed.withOpacity(0.2),
                                ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 16,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 3,
                                ),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F2F6),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: TabBar(
                                  labelColor: Colors.black,
                                  unselectedLabelColor: const Color(0xFF9E9E9E),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  dividerColor: Colors.transparent,
                                  indicator: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  tabs: const [
                                    Tab(text: "Login"),
                                    Tab(text: "Register"),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [LoginForm(), RegisterForm()],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // YOUR ORIGINAL CODE ENDS HERE

            // --- FULL SCREEN LOADER LAYER ---
            if (authController.isLoading.value)
              // Container(
              //   color: Colors.black.withOpacity(0.5), // Dims the entire screen
              //   child: const Center(
              //     child: CircularProgressIndicator(
              //       color: Color(0xFFC4EF62), // Your brand lime green
              //     ),
              //   ),
              // ),
              LoadingLoader(),
          ],
        ),
      ),
    );
  }
}
