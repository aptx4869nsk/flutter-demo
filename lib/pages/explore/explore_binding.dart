import 'package:get/get.dart';
import 'explore_logic.dart';

class ExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExploreLogic());
  }
}
