import 'package:get/get.dart';
import 'version_logic.dart';

class VersionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VersionLogic());
  }
}
