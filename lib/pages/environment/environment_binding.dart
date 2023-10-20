import 'package:get/get.dart';
import 'environment_logic.dart';

class EnvironmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EnvironmentLogic());
  }
}
