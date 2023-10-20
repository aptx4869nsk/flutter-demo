import 'package:get/get.dart';
import 'package:kaibo/pages/home/home_logic.dart';
import 'package:kaibo/pages/market/market_logic.dart';
import 'package:kaibo/pages/environment/environment_logic.dart';
import 'package:kaibo/pages/explore/explore_logic.dart';
import 'package:kaibo/pages/mine/mine_logic.dart';
import 'index_logic.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexLogic());
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => MarketLogic());
    Get.lazyPut(() => EnvironmentLogic());
    Get.lazyPut(() => ExploreLogic());
    Get.lazyPut(() => MineLogic());
  }
}
