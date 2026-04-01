// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saypay/core/utils/ui_utils/ui_utils.dart';
import 'package:saypay/repositories/profile_repositry.dart';

import '../../core/component/app_error_widget.dart';
import '../../core/error/exceptions.dart' show AuthException;
import '../session_controller/session_controller.dart';

class ProfileServices extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final RxBool isUploading = false.obs;
  final Rx<File?> selectedFile = Rx<File?>(null);

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (image == null) return;

      selectedFile.value = File(image.path);
    } catch (e) {
      AppErrorWidget.show(message: "Could not select image. Error: $e");
    }
  }

  Future<void> saveAndContinue(BuildContext context) async {
    if (selectedFile.value == null) {
      if (SessionController.userModel != null) {
        await SessionController().saveUser(SessionController.userModel!);
      }
      Get.back();
      return;
    }

    isUploading.value = true;

    try {
      final user = SessionController.userModel;
      if (user == null) throw AuthException('No user session found');

      final publicUrl = await ProfileRepositry().uploadProfileImage(
        selectedFile.value!,
        user.id,
      );

      final updatedUser = user.copyWith(avatarUrl: publicUrl);
      await SessionController().saveUser(updatedUser);

      isUploading.value = false;

      // Show flushbar
      UiUtils.showFlushbar(
        context,
        "Profile photo updated successfully!",
        isError: false,
      );

      // Wait for flushbar to be visible then go back
      await Future.delayed(const Duration(seconds: 2));
      Get.back();

    } on AuthException catch (e) {
      isUploading.value = false;
      AppErrorWidget.show(message: e.message);
    } catch (e) {
      isUploading.value = false;
      AppErrorWidget.show(message: "Could not upload image. Error: $e");
    }
  }
}
