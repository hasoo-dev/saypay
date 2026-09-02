import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:saypay/core/theme/app_colors.dart';
import 'widget/backup_status_card.dart';
import 'widget/backup_frequency_selector.dart';
import 'widget/backup_toggle_switch.dart';
import 'widget/backup_action_button.dart';
import 'widget/restore_button.dart';
import 'widget/section_label.dart';

class Backup extends StatefulWidget {
  const Backup({super.key});

  @override
  State<Backup> createState() => _BackupState();
}

class _BackupState extends State<Backup> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  // Backup settings
  String _selectedFrequency = 'daily';
  bool _autoBackupEnabled = true;
  bool _isBackingUp = false;
  bool _isRestoring = false;
  DateTime? _lastBackup;

  final List<BackupFrequencyOption> _frequencies = [
    BackupFrequencyOption(
      label: 'Daily',
      description: 'Backup every day at 2:00 AM',
      value: 'daily',
    ),
    BackupFrequencyOption(
      label: 'Weekly',
      description: 'Backup every Sunday at 2:00 AM',
      value: 'weekly',
    ),
    BackupFrequencyOption(
      label: 'Monthly',
      description: 'Backup on the 1st of every month',
      value: 'monthly',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _lastBackup = DateTime.now().subtract(const Duration(hours: 2));
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _startBackup() async {
    setState(() => _isBackingUp = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _isBackingUp = false;
      _lastBackup = DateTime.now();
    });
    Get.snackbar(
      'Backup Successful!',
      'Your data has been backed up successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 3),
    );
  }

  void _startRestore() async {
    setState(() => _isRestoring = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isRestoring = false);
    Get.snackbar(
      'Restore Successful!',
      'Your data has been restored successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = Theme.of(context).colorScheme.onPrimary;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subText = isDark
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText;

    return Scaffold(
      backgroundColor: bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── SliverAppBar ─────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: bg,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: textColor,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _buildHeader(isDark, textColor, subText),
            ),
          ),

          // ─── Body Content ──────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Backup Status Card
                      BackupStatusCard(
                        title: 'Cloud Backup System',
                        description: 'Your data is safely backed up',
                        lastBackup: _lastBackup,
                        surface: surface,
                        textColor: textColor,
                        subText: subText,
                      ),

                      const SizedBox(height: 28),

                      // Auto-Backup Toggle
                      SectionLabel(text: 'Auto Backup', textColor: textColor),
                      const SizedBox(height: 12),
                      BackupToggleSwitch(
                        title: 'Enable Auto Backup',
                        description: 'Automatically backup your data',
                        value: _autoBackupEnabled,
                        onChanged: (value) {
                          setState(() => _autoBackupEnabled = value);
                        },
                        icon: Icons.backup_rounded,
                        textColor: textColor,
                        subText: subText,
                      ),

                      const SizedBox(height: 28),

                      // Backup Frequency
                      SectionLabel(
                        text: 'Backup Frequency',
                        textColor: textColor,
                      ),
                      const SizedBox(height: 12),
                      BackupFrequencySelector(
                        options: _frequencies,
                        selectedFrequency: _selectedFrequency,
                        onFrequencySelected: (frequency) {
                          setState(() => _selectedFrequency = frequency);
                        },
                        surface: surface,
                        textColor: textColor,
                        subText: subText,
                      ),

                      const SizedBox(height: 28),

                      // Actions
                      SectionLabel(text: 'Actions', textColor: textColor),
                      const SizedBox(height: 12),

                      // Backup Now Button
                      BackupActionButton(
                        label: _isBackingUp ? 'Backing up...' : 'Backup Now',
                        onPressed: _startBackup,
                        isLoading: _isBackingUp,
                      ),

                      const SizedBox(height: 12),

                      // Restore Button
                      RestoreButton(
                        onPressed: _startRestore,
                        isLoading: _isRestoring,
                        label: _isRestoring ? 'Restoring...' : 'Restore Backup',
                        textColor: textColor,
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark, Color textColor, Color subText) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.15),
            AppColors.primary.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Backup',
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Secure your data in the cloud',
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        fontSize: 13.5,
                        color: subText,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFFFFB347)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.cloud_sync_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
