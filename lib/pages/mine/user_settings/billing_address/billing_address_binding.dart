import 'package:get/get.dart';
import 'billing_address_logic.dart';

class BillingAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BillingAddressLogic());
  }
}
