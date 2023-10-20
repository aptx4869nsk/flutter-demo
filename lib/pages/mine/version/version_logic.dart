import 'package:get/get.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/controller/app_controller.dart';
import 'package:kaibo/utils/upgrade_manager.dart';
import 'package:kaibo/views/upgrade_bottom_sheet_view.dart';
import 'package:kaibo/utils/logger.dart';

class VersionLogic extends GetxController with UpgradeManger {
  final appLogic = Get.find<AppController>();

  @override
  void onReady() {
    checkUpdateInApp();
    super.onReady();
  }
}
