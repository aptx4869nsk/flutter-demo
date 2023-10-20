import 'package:get/get.dart';
import 'withdrawal_logic.dart';

class WithdrawalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WithdrawalLogic());
  }
}
