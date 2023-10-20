import 'package:get/get.dart';
import 'withdrawal_pwd_logic.dart';

class WithdrawalPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WithdrawalPwdLogic());
  }
}
