// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:saypay/core/utils/size_extension/size_ext.dart';
import 'package:saypay/services/auth_services.dart/auth_services.dart';
import 'package:saypay/services/session_controller/session_controller.dart';

import '../../../core/const/app_constant.dart';
import '../../../core/routes/routes_constant.dart' show RoutesConstant;
import '../../../services/profile_services/currency_controller.dart';
import 'widget/profile_menu_item.dart';
import 'widget/profile_section_header.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthService _authService = Get.find<AuthService>();
  final CurrencyController _currencyController = Get.put(
    CurrencyController(),
    permanent: true,
  );

  @override
  void initState() {
    super.initState();
    // Refresh user data when profile view loads
    _refreshUserData();
  }

  void _refreshUserData() async {
    try {
      final sessionController = SessionController.to;
      // Load user data from local storage to ensure latest values
      await sessionController.getUserFromPreference();
    } catch (e) {
      print('Error refreshing user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = Get.put(SessionController());

    final theme = Theme.of(context);

    return Scaffold(
     
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: Column(
          // Main container is a Column, not a ScrollView
          children: [
            // --- FIXED HEADER SECTION ---
            0.02.vSpace,

            Obx(() {
              final avatar = sessionController.avatarUrl.value;
              final userName = sessionController.fullName.value.isNotEmpty
                  ? sessionController.fullName.value
                  : "Unknown";
              final userEmail = sessionController.email.value.isNotEmpty
                  ? sessionController.email.value
                  : "Unknown";

              return Row(
                
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 13),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.2),
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 44,
                      backgroundColor: Colors.grey.shade200,
                      // ✅ Now reads from reactive value — updates instantly
                      backgroundImage: avatar.isNotEmpty
                          ? NetworkImage(avatar)
                          : const AssetImage(AppConstant.profile)
                                as ImageProvider,
                    ),
                  ),
                  0.04.hSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primaryFixed,
                          fontSize: 22,

                          
                        ),
                      ),
                      const SizedBox(height: 4),
                      FittedBox(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.scrim,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            userEmail,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primaryFixed,
                              fontWeight: FontWeight.w500,

                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
            0.02.vSpace,

            // --- SCROLLABLE MENU SECTION ---
            Expanded(
              // This makes the remaining space scrollable
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProfileSectionHeader(title: "Account"),
                      ProfileMenuItem(
                        icon: Icons.person_outline_rounded,
                        title: "Edit Profile",
                        iconColor: Colors.blue.shade600,
                        onTap: () => Get.toNamed(RoutesConstant.editProfile),
                      ),
                      ProfileMenuItem(
                        icon: Icons.lock_outline,
                        title: "Change Password",
                        iconColor: Colors.purple.shade500,
                        onTap: () => Get.toNamed(RoutesConstant.changePassword),
                      ),

                      const ProfileSectionHeader(title: "Preferences"),
                      Obx(
                        () => ProfileMenuItem(
                          icon: Icons.attach_money_rounded,
                          title: "Currency",
                          trailingText:
                              _currencyController.selectedCurrency.value,
                          iconColor: Colors.green.shade600,
                          onTap: () => Get.toNamed(RoutesConstant.currency),
                        ),
                      ),
                      ProfileMenuItem(
                        icon: Icons.palette_outlined,
                        title: "Theme",
                        iconColor: Colors.deepPurple.shade400,
                        onTap: () => Get.toNamed(RoutesConstant.theme),
                      ),

                      const ProfileSectionHeader(title: "Data & Privacy"),
                      ProfileMenuItem(
                        icon: Icons.file_download_outlined,
                        title: "Export Data",
                        iconColor: Colors.teal.shade600,
                        onTap: () => Get.toNamed(RoutesConstant.exportData),
                      ),
                      ProfileMenuItem(
                        icon: Icons.backup_outlined,
                        title: "Backup",
                        iconColor: Colors.cyan.shade600,
                        onTap: () => Get.toNamed(RoutesConstant.backup),
                      ),

                      ProfileMenuItem(
                        icon: Icons.info_outline_rounded,
                        title: "About Spendly",
                        iconColor: Colors.grey.shade600,
                        onTap: () => Get.toNamed(RoutesConstant.aboutSpendly),
                      ),

                      const SizedBox(height: 16),
                      ProfileMenuItem(
                        icon: Icons.logout_rounded,
                        title: "Logout",
                        isDestructive: true,
                        onTap: () => _authService.logout(context),
                      ),
                      const SizedBox(height: 20), // Bottom padding
                    ],
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
