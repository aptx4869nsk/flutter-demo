import 'package:get/get.dart';
import 'orders_logic.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersLogic());
  }
}
