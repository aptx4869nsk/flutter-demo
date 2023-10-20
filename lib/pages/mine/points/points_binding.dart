import 'package:get/get.dart';
import 'points_logic.dart';

class PointsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PointsLogic());
  }
}
