import 'package:get/get.dart';
import 'market_logic.dart';

class MarketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MarketLogic());
  }
}
