import 'package:get/get.dart';
import 'assets_logic.dart';

class AssetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssetsLogic());
  }
}
