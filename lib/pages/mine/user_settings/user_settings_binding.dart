import 'package:get/get.dart';
import 'user_settings_logic.dart';

class UserSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserSettingsLogic());
  }
}
