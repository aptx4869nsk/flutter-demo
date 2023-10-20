import 'package:get/get.dart';
import 'modify_phone_logic.dart';

class ModifyPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModifyPhoneLogic());
  }
}
