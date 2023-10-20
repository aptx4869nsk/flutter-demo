import 'package:get/get.dart';
import 'balance_transfer_logic.dart';

class BalanceTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BalanceTransferLogic());
  }
}
