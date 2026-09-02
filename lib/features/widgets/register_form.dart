import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
 
import 'package:saypay/core/utils/size_extension/size_ext.dart';
import 'package:saypay/core/utils/validation_extension/validation.dart';
import 'package:saypay/services/auth_services.dart/auth_services.dart';

import '../../core/component/custom_form_field.dart';
import '../../core/component/text_actions.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    final AuthService authServices = Get.find<AuthService>();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 0.06.w),
      child: Form(
        key: authServices.formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: authServices.registerFullNameController,
              label: "Full Name",
              prefixIcon: Icons.person,
              keyword: TextInputType.name,
              isPassword: false,
              validator: (value) => value.validateFullName(),
            ),
            CustomTextField(
              controller: authServices.registerEmailController,
              label: "Email Address",
              prefixIcon: Icons.email_outlined,
              keyword: TextInputType.emailAddress,
              validator: (value) => value.validateEmail(),
              isPassword: false,
            ),
            CustomTextField(
              controller: authServices.registerPasswordController,

              label: "Password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,

              action: TextInputAction.done,
              validator: (value) => value.validatePassword(),
            ),
            0.023.vSpace,

            TextActions(
              title: "Register",
              height: 54,
              background: Theme.of(context).cardColor,
              width: double.infinity,
              fontSize: 13,
              titleColor: Theme.of(
                context,
              ).colorScheme.primaryFixed,
              onTap: () {
                authServices.register(context);
              },
            ),

            // ... inside your Column after TextActions
            0.04.vSpace,

            // 1. Terms and Conditions Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                  children: [
                    const TextSpan(text: "By registering, you agree to our "),
                    TextSpan(
                      text: "Terms of Service",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      // Add recognizer for navigation here
                    ),
                    const TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      // Add recognizer for navigation here
                    ),
                  ],
                ),
              ),
            ),

            // const SizedBox(height: 30),
            // 0.03.vSpace,

            // // 2. Already have an account? Login
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Already have an account? ",
            //       style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         DefaultTabController.of(context).animateTo(0);
            //       },
            //       child: const Text(
            //         "Login",
            //         style: TextStyle(
            //           color: Color(0xFF5A7363), // Using your brand green
            //           fontWeight: FontWeight.bold,
            //           fontSize: 14,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
