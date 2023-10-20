import 'package:get/get.dart';
import 'package:kaibo/pages/auth/register/register_logic.dart';
import 'login_logic.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginLogic());
    Get.lazyPut(() => RegisterLogic());
  }
}
