import 'package:get/get.dart';
import 'deposit_history_logic.dart';

class DepositHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DepositHistoryLogic());
  }
}
