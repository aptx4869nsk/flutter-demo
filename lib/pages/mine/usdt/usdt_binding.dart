import 'package:get/get.dart';
import 'usdt_logic.dart';

class UsdtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsdtLogic());
  }
}
