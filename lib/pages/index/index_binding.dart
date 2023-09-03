import 'package:get/get.dart';
import 'package:kaibo/pages/home/home_logic.dart';
import 'package:kaibo/pages/mine/mine_logic.dart';
import 'index_logic.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexLogic());
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => MineLogic());
  }
}

