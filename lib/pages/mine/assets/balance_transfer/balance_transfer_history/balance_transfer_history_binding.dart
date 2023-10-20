import 'package:get/get.dart';
import 'balance_transfer_history_logic.dart';

class BalanceTransferHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BalanceTransferHistoryLogic());
  }
}
