import 'package:get/get.dart';
import 'verification_logic.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationLogic());
  }
}
