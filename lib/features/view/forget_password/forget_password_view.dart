import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saypay/core/component/custom_form_field.dart';
import 'package:saypay/core/component/text_actions.dart';
import 'package:saypay/services/auth_services.dart/auth_services.dart';

import '../../../core/const/app_constant.dart';
import '../../../core/utils/validation_extension/validation.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            // Welcome text section
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppConstant.logo,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Text(
                    "Go ahead and set up your new password",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Enter the Email for the reset the password",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withValues(alpha: 0.2),
                    ),
                  ),
                  SizedBox(height: 12),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  child: Form(
                    key: formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: emailController,
                            label: "Email Address",
                            prefixIcon: Icons.email_outlined,
                            validator: (value) => value.validateEmail(),
                          ),
                          const SizedBox(height: 22),
                          TextActions(
                            title: "Send Link",
                            background: Theme.of(context).scaffoldBackgroundColor,
                            titleColor: Colors.black,
                            fontSize: 14,
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                Get.find<AuthService>().sendPasswordReset(
                                  context, 
                                  emailController.text.trim(),
                                );
                              } else {
                                debugPrint("Form has errors.");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
