import 'package:get/get.dart';
import 'login_pwd_logic.dart';

class LoginPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPwdLogic());
  }
}
