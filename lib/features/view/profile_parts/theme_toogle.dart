import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../core/utils/size_extension/size_ext.dart';
import '../main/widget/theme_tile.dart';

class ThemeToogle extends StatefulWidget {
  const ThemeToogle({super.key});

  @override
  State<ThemeToogle> createState() => _ThemeToogleState();
}

class _ThemeToogleState extends State<ThemeToogle> {
  String _selectedTheme = 'light'; // Default fallback

  @override
  void initState() {
    super.initState();
    // Very basic init based on context. In real apps, you'd pull this from a controller storing GetStorage/SecureStorage
    if (Get.isDarkMode) {
      _selectedTheme = 'dark';
    } else {
      _selectedTheme = 'light';
    }
  }

  void _changeTheme(String theme) {
    setState(() {
      _selectedTheme = theme;
    });
    
    // Switch the theme actively
    if (theme == 'light') {
      Get.changeThemeMode(ThemeMode.light);
    } else if (theme == 'dark') {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.system);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.primaryFixed, size: 20),
          ),
          onTap: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Theme",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: -1,
                ),
              ),
              0.01.vSpace,
              Text(
                "Choose your preferred theme style. Your choice perfectly aligns with our curated palettes.",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              0.04.vSpace,
              
              ThemeTile(
                title: "Light Mode",
                subtitle: "Clean and bright appearance",
                icon: Icons.light_mode_rounded,
                isSelected: _selectedTheme == 'light',
                onTap: () => _changeTheme('light'),
              ),
              
              ThemeTile(
                title: "Dark Mode",
                subtitle: "Easy on the eyes in low light",
                icon: Icons.dark_mode_rounded,
                isSelected: _selectedTheme == 'dark',
                onTap: () => _changeTheme('dark'),
              ),
              
              ThemeTile(
                title: "System Default",
                subtitle: "Matches your device settings automatically",
                icon: Icons.settings_suggest_rounded,
                isSelected: _selectedTheme == 'system',
                onTap: () => _changeTheme('system'),
              ),
              
              0.04.vSpace,
            ],
          ),
        ),
      ),
    );
  }
}

