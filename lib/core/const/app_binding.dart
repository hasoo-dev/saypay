
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../services/session_controller/session_controller.dart';
import '../../services/auth_services.dart/auth_services.dart';
 

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SessionController(), permanent: true);
    Get.put(AuthService(), permanent: true);
  }
}