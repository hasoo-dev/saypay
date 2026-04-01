// import 'package:flutter/material.dart';
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:saypay/core/component/text_actions.dart';
import 'package:saypay/core/routes/routes_constant.dart';
import 'package:saypay/core/utils/validation_extension/validation.dart';
import '../../core/component/check_box.dart';
import '../../core/component/custom_form_field.dart';
import '../../services/auth_services.dart/auth_services.dart';
import 'social_action_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject/Find the AuthService
    final authService = Get.find<AuthService>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Form(
        key: authService.form, // Use key from service
        child: Column(
          children: [
            CustomTextField(
              controller:
                  authService.emailController, // Use controller from service
              label: "Email Address",
              prefixIcon: Icons.email_outlined,
              validator: (value) => value.validateEmail(),
            ),

            CustomTextField(
              controller:
                  authService.passwordController, // Use controller from service
              label: "Password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              validator: (value) => value.validatePassword(),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => CustomCheckbox(
                  label: "Remember me",
                  initialState: authService.isRememberMe.value,
                  onChanged: (value) => authService.isRememberMe.value = value,
                )),

                InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    RoutesConstant.forgetPassword,
                  ),
                  child: const Text("Forget password?"),
                ),
              ],
            ),
            const SizedBox(height: 27),

            // --- THE UPDATED LOGIN BUTTON ---
            TextActions(
              title: "Login",
              height: 54,
              background: const Color(0xFFF4F4B7),
              width: double.infinity,
              fontSize: 13,
              titleColor: Colors.black,
              onTap: () {
                // Call the login method from AuthService
                // This will trigger the full-screen loader automatically
                authService.login(context);
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  const Expanded(
                    child: Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "OR LOGIN WITH",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialActionButton(
                    title: "Google",
                    iconPath: 'assets/icons/google.png',
                    onTap: () => authService.signInWithGoogle(context),
                  ),
                  SocialActionButton(
                    title: "Facebook",
                    iconPath: 'assets/icons/facebook.png',
                    onTap: () => debugPrint("Facebook Login Pressed"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
