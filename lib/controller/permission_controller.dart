import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kaibo/utils/permissions.dart';

class PermissionController extends GetxController {
  @override
  void onInit() async {
    await Permissions.request([
      Permission.notification,
      Permission.photos,
      Permission.camera,
      Permission.storage,
    ]);

    super.onInit();
  }

  /// 退出应用程序
  void quitApp() {
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }
}
