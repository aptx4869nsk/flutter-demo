import 'package:get/get.dart';
import 'cards_logic.dart';

class CardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CardsLogic());
  }
}
