import 'package:get/get.dart';
import 'points_transfer_logic.dart';

class PointsTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PointsTransferLogic());
  }
}
