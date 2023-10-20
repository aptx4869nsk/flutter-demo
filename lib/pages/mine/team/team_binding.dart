import 'package:get/get.dart';
import 'team_logic.dart';

class TeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeamLogic());
  }
}
