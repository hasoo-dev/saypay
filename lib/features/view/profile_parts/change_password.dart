import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:saypay/core/component/custom_form_field.dart';
import 'package:saypay/core/component/text_actions.dart';
import 'package:saypay/core/utils/size_extension/size_ext.dart';

import '../../../core/component/loading_loader.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/component/app_error_widget.dart';
import '../../../core/utils/ui_utils/ui_utils.dart';
import '../../../repositories/auth_repository.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final AuthRepository _authRepository = AuthRepository();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _updatePassword() async {
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      AppErrorWidget.show(message: "Please fill in all fields.");
      return;
    }

    if (newPassword.length < 6) {
      AppErrorWidget.show(message: "Password must be at least 6 characters.");
      return;
    }

    if (newPassword != confirmPassword) {
      AppErrorWidget.show(message: "Passwords do not match.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authRepository.updatePassword(newPassword);

      if (mounted) {
        setState(() => _isLoading = false);
        UiUtils.showFlushbar(
          context,
          "Password successfully updated!",
          isError: false,
        );
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) Get.back();
      }
    } on AuthException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        AppErrorWidget.show(message: e.message);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        AppErrorWidget.show(message: "Could not update password. Error: $e");
      }
    }
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.onPrimary,
        surfaceTintColor: theme.colorScheme.onPrimary,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back_ios_new, size: 20),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children:[ SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Change Password",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                0.01.vSpace,
                Text(
                  "Create a new, strong password that you don't use for other websites.",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                0.04.vSpace,
                
                CustomTextField(
                  label: 'New Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: _newPasswordController,
                  action: TextInputAction.next,
                ),
                
                CustomTextField(
                  label: 'Confirm New Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: _confirmPasswordController,
                  action: TextInputAction.done,
                ),
          
                0.04.vSpace,
                TextActions(
                  title: _isLoading ? "Updating..." : "Update Password",
                  onTap: _isLoading ? null : _updatePassword,
                  titleColor: theme.colorScheme.onPrimary,
                  weight: FontWeight.w800,
                  fontSize: 19,
                  background: theme.colorScheme.primaryFixed,
                ),
              ],
            )
            ,
             
          ),
          if (_isLoading)
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