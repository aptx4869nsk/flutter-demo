import 'package:get/get.dart';
import 'invitation_logic.dart';

class InvitationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvitationLogic());
  }
}
