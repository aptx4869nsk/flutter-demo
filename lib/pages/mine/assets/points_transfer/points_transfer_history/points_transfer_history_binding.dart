import 'package:get/get.dart';
import 'points_transfer_history_logic.dart';

class PointsTransferHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PointsTransferHistoryLogic());
  }
}
