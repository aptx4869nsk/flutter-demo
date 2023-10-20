import 'package:get/get.dart';
import 'withdrawal_history_logic.dart';

class WithdrawalHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WithdrawalHistoryLogic());
  }
}
