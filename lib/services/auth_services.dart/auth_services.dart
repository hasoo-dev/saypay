import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:saypay/core/error/exceptions.dart';
import 'package:saypay/core/routes/routes_constant.dart';
import 'package:saypay/core/utils/logger/app_logger.dart';
import 'package:saypay/core/component/app_error_widget.dart';
import 'package:saypay/repositories/auth_repository.dart';
import '../../core/utils/ui_utils/ui_utils.dart';
import '../session_controller/session_controller.dart';
import 'package:saypay/features/widgets/registration_success_sheet.dart';

class AuthService extends GetxController {
  final _secureStorage = const FlutterSecureStorage();
  final _authRepository = AuthRepository(); // NEW: Inject repository

  // Login Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Register Controller
  final registerFullNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();

  // Form Keys
  final formKey = GlobalKey<FormState>(); // For Register
  final form = GlobalKey<FormState>(); // For Login

  // Reactive states
  final RxBool isLoading = false.obs;
  final RxBool isRememberMe = false.obs;

  final SessionController _session = SessionController();

  @override
  void onInit() {
    super.onInit();
    _loadSecureCredentials();
  }

  Future<void> _loadSecureCredentials() async {
    try {
      AppLogger.info('Loading secure credentials', tag: 'AUTH_SERVICE');
      String? savedEmail = await _secureStorage.read(key: 'email');
      String? savedPassword = await _secureStorage.read(key: 'password');

      if (savedEmail != null && savedPassword != null) {
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
        isRememberMe.value = true;
        AppLogger.debug('Credentials loaded successfully', tag: 'AUTH_SERVICE');
      }
    } catch (e) {
      AppLogger.error('Error loading secure storage', error: e, tag: 'AUTH_SERVICE');
    }
  }

  Future<void> handleRememberMe() async {
    try {
      if (isRememberMe.value) {
        AppLogger.debug('Writing credentials to secure storage', tag: 'AUTH_SERVICE');
        await _secureStorage.write(key: 'email', value: emailController.text.trim());
        await _secureStorage.write(key: 'password', value: passwordController.text);
      } else {
        AppLogger.debug('Clearing credentials from secure storage', tag: 'AUTH_SERVICE');
        await _secureStorage.delete(key: 'email');
        await _secureStorage.delete(key: 'password');
      }
    } catch (e) {
      AppLogger.error('Error during handleRememberMe', error: e, tag: 'AUTH_SERVICE');
    }
  }

  Future<void> login(BuildContext context) async {
    if (!(form.currentState?.validate() ?? false)) {
      AppLogger.warning('Login attempt failed: Validation error', tag: 'LOGIN');
      return;
    }

    try {
      isLoading.value = true;
      AppLogger.info('Starting login process for ${emailController.text}', tag: 'LOGIN');

      await handleRememberMe();

      final user = await _authRepository.signInWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      await _session.saveUser(user);
      AppLogger.success('Login successful, user persisted', tag: 'LOGIN');

      if (context.mounted) {
        UiUtils.showFlushbar(context, "Login Successful", isError: false);
        Get.offAllNamed(RoutesConstant.main);
      }
    } on AuthException catch (e) {
      AppLogger.warning('Login failed: ${e.message}', tag: 'LOGIN');
      if (context.mounted) {
        AppErrorWidget.show(message: e.message);
      }
    } catch (e) {
      AppLogger.error('Unexpected error during login', error: e, tag: 'LOGIN');
      if (context.mounted) {
        AppErrorWidget.show(message: "An unexpected error occurred. Please try again.");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      isLoading.value = true;
      AppLogger.info('Starting Google Sign-In process', tag: 'GOOGLE_AUTH');

      final user = await _authRepository.signInWithGoogle();

      await _session.saveUser(user);
      AppLogger.success('Google login successful, user persisted', tag: 'GOOGLE_AUTH');

      if (context.mounted) {
        UiUtils.showFlushbar(context, "Welcome ${user.fullName ?? 'to Spendly'}", isError: false);
        Get.offAllNamed(RoutesConstant.main);
      }
    } on AuthException catch (e) {
      AppLogger.warning('Google login failed: ${e.message}', tag: 'GOOGLE_AUTH');
      if (context.mounted) {
        AppErrorWidget.show(message: e.message);
      }
    } catch (e) {
      AppLogger.error('Unexpected error during Google login', error: e, tag: 'GOOGLE_AUTH');
      if (context.mounted) {
        AppErrorWidget.show(message: "An unexpected error occurred during Google Sign-In.");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      AppLogger.warning('Register attempt failed: Validation error', tag: 'REGISTER');
      return;
    }

    try {
      isLoading.value = true;
      AppLogger.info('Starting registration for ${registerEmailController.text}', tag: 'REGISTER');

      await _authRepository.signUpWithEmail(
        email: registerEmailController.text.trim(),
        password: registerPasswordController.text,
        fullName: registerFullNameController.text.trim(),
      );

      AppLogger.success('Registration successful in Supabase', tag: 'REGISTER');
      
      // Clear fields and show success sheet
      onClear();
      
      if (context.mounted) {
        Get.bottomSheet(
          const RegistrationSuccessSheet(),
          isDismissible: false,
          enableDrag: false,
        );
      }
    } on AuthException catch (e) {
      AppLogger.warning('Registration failed: ${e.message}', tag: 'REGISTER');
      if (context.mounted) {
        AppErrorWidget.show(message: e.message);
      }
    } catch (e) {
      AppLogger.error('Unexpected error during registration', error: e, tag: 'REGISTER');
      if (context.mounted) {
        AppErrorWidget.show(message: "Could not complete registration. ${e.toString()}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendPasswordReset(BuildContext context, String email) async {
    try {
      isLoading.value = true;
      AppLogger.info('Starting password reset for $email', tag: 'FORGOT_PASSWORD');

      await _authRepository.resetPasswordForEmail(email: email);

      if (context.mounted) {
        UiUtils.showFlushbar(context, 'Password reset link sent to $email', isError: false);
        Get.back();
      }
    } on AuthException catch (e) {
      AppLogger.warning('Password reset failed: ${e.message}', tag: 'FORGOT_PASSWORD');
      if (context.mounted) {
        AppErrorWidget.show(message: e.message);
      }
    } catch (e) {
      AppLogger.error('Unexpected error during password reset', error: e, tag: 'FORGOT_PASSWORD');
      if (context.mounted) {
        AppErrorWidget.show(message: 'Could not send reset link. Please try again.');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      isLoading.value = true;
      AppLogger.info('Starting logout process', tag: 'LOGOUT');
      
      await _authRepository.signOut();
      await _session.logout();
      
      Get.offAllNamed(RoutesConstant.login);

      if (context.mounted) {
        UiUtils.showFlushbar(context, "Logged out successfully", isError: false);
      }
      AppLogger.success('Logout complete', tag: 'LOGOUT');
    } catch (e) {
      AppLogger.error('Logout failed', error: e, tag: 'LOGOUT');
      if (context.mounted) {
        UiUtils.showFlushbar(context, "Logout failed. Please try again.");
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    AppLogger.debug('Disposing AuthController', tag: 'LIFECYCLE');
    emailController.dispose();
    passwordController.dispose();
    registerFullNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    super.onClose();
  }

  void onClear() {
    AppLogger.debug('Clearing form controllers', tag: 'LIFECYCLE');
    registerFullNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
  }
}

