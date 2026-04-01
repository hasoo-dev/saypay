// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../model/user/user_model.dart';
// import '../storage/local_storage.dart';

// class SessionController   {
//   final LocalStorage sharedPreferenceClass = LocalStorage();
//   static final SessionController _session = SessionController._internal();
//   final RxString avatarUrl = ''.obs;

// static SessionController get to => Get.find(); 
//   // Simple session variables
//   static bool? isLogin;
//   static String? userToken;
//   static Map<String, dynamic>? userData;
//   static UserModel? userModel; // NEW: Store modern user model

//   SessionController._internal() {
//     isLogin = false;
//   }

//   factory SessionController() {
//     return _session;
//   }

//   /// Saves user model and login state
//   Future<void> saveUser(UserModel user) async {
//     final String userJson = jsonEncode(user.toJson());
//     avatarUrl.value = user.avatarUrl ?? '';
//     await sharedPreferenceClass.setValue('user_model', userJson);
//     await sharedPreferenceClass.setValue('isLogin', 'true');
    
//     isLogin = true;
//     userModel = user;
//     userData = user.toJson();
//   }

//   /// Saves raw user data and login state (Legacy fallback)
//   Future<void> saveUserInPreference(dynamic data) async {
//     String valueToSave = data is Map ? jsonEncode(data) : data.toString();
//     await sharedPreferenceClass.setValue('token', valueToSave);
//     await sharedPreferenceClass.setValue('isLogin', 'true');
//     isLogin = true;
//     userToken = valueToSave;
//     if (data is Map) userData = data as Map<String, dynamic>;
//   }

//   /// Retrieves session status from storage
//   Future<void> getUserFromPreference() async {
//     try {
//       userToken = await sharedPreferenceClass.readValue('token');
//       String? loginStatus = await sharedPreferenceClass.readValue('isLogin');

//       isLogin = loginStatus == 'true';
      
//       if (userToken != null && userToken!.startsWith('{')) {
//         userData = jsonDecode(userToken!);
//       }

//       // Try reading modern user model
//       String? modelJson = await sharedPreferenceClass.readValue('user_model');
//       if (modelJson != null) {
//         userModel = UserModel.fromJson(jsonDecode(modelJson));
//         userData = userModel?.toJson();
//       }
//     } catch (e) {
//       debugPrint("Session Error: $e");
//       isLogin = false;
//     }
//   }

//   Future<void> logout() async {
//     await sharedPreferenceClass.clearValue('token');
//     await sharedPreferenceClass.clearValue('user_model'); // NEW: Clear modern model
//     await sharedPreferenceClass.setValue('isLogin', 'false');
    
//     isLogin = false;
//     userToken = null;
//     userModel = null;
//     userData = null;
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/user/user_model.dart';
import '../storage/local_storage.dart';

class SessionController extends GetxController {  // ✅ extend GetxController
  final LocalStorage sharedPreferenceClass = LocalStorage();
  
  static SessionController get to => Get.find();  // ✅ singleton getter

  // ✅ Reactive user details
  final RxString avatarUrl = ''.obs;
  final RxString fullName = ''.obs;
  final RxString email = ''.obs;

  // Simple session variables
  static bool? isLogin;
  static String? userToken;
  static Map<String, dynamic>? userData;
  static UserModel? userModel;

  /// Saves user model and login state
  Future<void> saveUser(UserModel user) async {
    final String userJson = jsonEncode(user.toJson());
    
    userModel = user;
    userData = user.toJson();
    isLogin = true;
    avatarUrl.value = user.avatarUrl ?? '';  // ✅ triggers Obx rebuild
    fullName.value = user.fullName ?? '';
    email.value = user.email;

    await sharedPreferenceClass.setValue('user_model', userJson);
    await sharedPreferenceClass.setValue('isLogin', 'true');
  }

  /// Saves raw user data and login state (Legacy fallback)
  Future<void> saveUserInPreference(dynamic data) async {
    String valueToSave = data is Map ? jsonEncode(data) : data.toString();
    await sharedPreferenceClass.setValue('token', valueToSave);
    await sharedPreferenceClass.setValue('isLogin', 'true');
    isLogin = true;
    userToken = valueToSave;
    if (data is Map) userData = data as Map<String, dynamic>;
  }

  /// Retrieves session status from storage
  Future<void> getUserFromPreference() async {
    try {
      userToken = await sharedPreferenceClass.readValue('token');
      String? loginStatus = await sharedPreferenceClass.readValue('isLogin');

      isLogin = loginStatus == 'true';

      if (userToken != null && userToken!.startsWith('{')) {
        userData = jsonDecode(userToken!);
      }

      // Try reading modern user model
      String? modelJson = await sharedPreferenceClass.readValue('user_model');
      if (modelJson != null) {
        userModel = UserModel.fromJson(jsonDecode(modelJson));
        userData = userModel?.toJson();
        avatarUrl.value = userModel?.avatarUrl ?? '';  // ✅ load on app start
        fullName.value = userModel?.fullName ?? '';
        email.value = userModel?.email ?? '';
      }
    } catch (e) {
      debugPrint("Session Error: $e");
      isLogin = false;
    }
  }

  Future<void> logout() async {
    await sharedPreferenceClass.clearValue('token');
    await sharedPreferenceClass.clearValue('user_model');
    await sharedPreferenceClass.setValue('isLogin', 'false');

    isLogin = false;
    userToken = null;
    userModel = null;
    userData = null;
    avatarUrl.value = '';  // ✅ clear on logout
    fullName.value = '';
    email.value = '';
  }
}