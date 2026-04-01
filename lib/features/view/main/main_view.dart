// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:saypay/core/utils/ui_utils/ui_utils.dart';
import 'package:saypay/features/view/main/home_view.dart';

import 'profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // 1. Track the selected index
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    
    return Scaffold(
       backgroundColor: Colors.transparent,
       extendBody: true,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Home Icon Button
          _buildNavItem(
            index: 0,
            iconPath: "assets/icons/ic_home_black.png",
          ),
          _buildMicButton(),
          // Profile Icon Button
          _buildNavItem(
            index: 1,
            iconPath: "assets/icons/ic_profile_black.png",
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // const Center(child: Text("Home")),
          HomeView(),
          ProfileView(),
          // const Center(child: Text("Profile")),
        ],
      ),
    );
  }

  // Helper method to build the items and handle logic
  Widget _buildNavItem({required int index, required String iconPath}) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        // height: 47,
        // width: 34,
        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 14),
        margin: const EdgeInsets.symmetric(vertical: 17,horizontal: 2),
        decoration: BoxDecoration(
          // Change background to black if selected, else keep transparent/white
          color: isSelected ? Colors.black : Colors.grey.shade600,
           borderRadius: BorderRadius.circular(33)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Image.asset(
            iconPath,
            height: isSelected ? 42 : 42,
            // Change image color to white if selected, else keep black
            color: isSelected ? Colors.white : Colors.white,
          ),
        ),
      ),
    );
  }
  Widget _buildMicButton() {
  return GestureDetector(
    onTap: () {
      // Add your Microphone/Voice logic here
       UiUtils.showFlushbar(context, "Mic tapped", isError: false);
    },
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // Semi-green background
        color: const Color(0xFF4CAF50).withOpacity(0.8), 
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child:   Image.asset(
        "assets/icons/ic_microphone.png", // Or use Image.asset("assets/icons/ic_mic.png")
        color: Colors.white,
        height: 45,
      ),
    ),
  );
}
}